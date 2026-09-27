# --------------------------------------------------

if [ ! -f "deps" ]; then
  sudo rm -r deps
fi
if [ ! -f "prefix" ]; then
  sudo rm -r prefix
fi

./download.sh
./patch.sh

# --------------------------------------------------

if [ ! -f "scripts/ffmpeg" ]; then
  rm scripts/ffmpeg.sh
fi
cp flavors/default.sh scripts/ffmpeg.sh

# --------------------------------------------------

./build.sh

# --------------------------------------------------
# media-kit-android-helper
#
# 上游用 gradle 构建这一步，但本仓库的 CI 容器里没有可用的 Android SDK
# （setup-android action 已失效、download-sdk-debian.sh 被整体注释），gradle 会因
# NDK 许可未接受在配置阶段直接失败。脚本没开 -e，于是后面的 cp 失败被忽略、jar 里
# 只剩 libmpv.so —— 结果 Android 端拿不到 JavaVM（av_jni_set_java_vm 没被调用），
# mediacodec 硬解与 mediacodec_embed 输出全部无法初始化，表现为黑屏且无声。
# 这里直接用 NDK 的 clang 编译，参数与 app/src/main/cpp/CMakeLists.txt 等价。

. ./include/depinfo.sh
. ./include/path.sh

cd deps/media-kit-android-helper/app/src/main/cpp

helper_abis="arm64-v8a:aarch64-linux-android21 armeabi-v7a:armv7a-linux-androideabi21 x86:i686-linux-android21 x86_64:x86_64-linux-android21"

for abi_triple in $helper_abis; do
	abi="${abi_triple%%:*}"
	triple="${abi_triple##*:}"
	"${triple}-clang++" \
		-shared -fPIC -O2 -DNDEBUG -fvisibility=hidden -static-libstdc++ -s \
		-Wl,--build-id=none -Wl,-z,max-page-size=16384 \
		-o "../../../../../../prefix/${abi}/usr/local/lib/libmediakitandroidhelper.so" \
		native-lib.cpp -llog -landroid
done

cd ../../../../../..

for abi_triple in $helper_abis; do
	abi="${abi_triple%%:*}"
	helper="prefix/${abi}/usr/local/lib/libmediakitandroidhelper.so"
	[ -s "$helper" ] || { echo "ERROR: $helper was not built"; exit 1; }
done

mkdir -p temp/lib/arm64-v8a
mkdir -p temp/lib/armeabi-v7a
mkdir -p temp/lib/x86
mkdir -p temp/lib/x86_64

cp prefix/arm64-v8a/usr/local/lib/*.so temp/lib/arm64-v8a/
cp prefix/armeabi-v7a/usr/local/lib/*.so temp/lib/armeabi-v7a/
cp prefix/x86/usr/local/lib/*.so temp/lib/x86/
cp prefix/x86_64/usr/local/lib/*.so temp/lib/x86_64/

cd temp

FIXED_TIME="2025-01-01 00:00:00"

find "lib" -type d -exec touch -d "$FIXED_TIME" {} +
find "lib/arm64-v8a" -type f -name "*.so" -exec touch -d "$FIXED_TIME" {} +
find "lib/armeabi-v7a" -type f -name "*.so" -exec touch -d "$FIXED_TIME" {} +
find "lib/x86" -type f -name "*.so" -exec touch -d "$FIXED_TIME" {} +
find "lib/x86_64" -type f -name "*.so" -exec touch -d "$FIXED_TIME" {} +

md5sum lib/arm64-v8a/*.so
md5sum lib/armeabi-v7a/*.so
md5sum lib/x86/*.so
md5sum lib/x86_64/*.so

find lib/arm64-v8a -type f | sort | zip -r -X ../default-arm64-v8a.jar -@
find lib/armeabi-v7a -type f | sort | zip -r -X ../default-armeabi-v7a.jar -@
find lib/x86 -type f | sort | zip -r -X ../default-x86.jar -@
find lib/x86_64 -type f | sort | zip -r -X ../default-x86_64.jar -@

cd ../

pwd

md5sum *.jar

# libmpv.so 与 libmediakitandroidhelper.so 缺一不可（缺 helper 会让 Android 端
# 拿不到 JavaVM 而黑屏），缺失时让 job 明确失败而不是发个残缺的 jar。
for jar in default-arm64-v8a.jar default-armeabi-v7a.jar default-x86.jar default-x86_64.jar; do
	for so in libmpv.so libmediakitandroidhelper.so; do
		unzip -l "$jar" | grep -q "$so" || { echo "ERROR: $so missing in $jar"; exit 1; }
	done
done