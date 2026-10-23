# libmpv-android-video-build 工作流程图

> 锚点：`main 4a8a355`（2026-10-21）｜范围：NDK 构建链、ABI 产物、CI 发布、media-kit 消费
> 五件套：[architecture.md](./architecture.md)｜[update-history.md](./update-history.md)｜[backlog.md](./backlog.md)｜[test-suite.md](./test-suite.md)
> 消费方：[media-kit](../../media-kit/doc/architecture.md)｜同族：[win32](../../libmpv-win32-video-cmake/doc/architecture.md)｜[darwin](../../libmpv-darwin-build/doc/architecture.md)

## 1. 主链（CI）

```
push main / PR / workflow_dispatch
  → ubuntu-24.04 + debian:bookworm-slim 容器
  → apt: build-essential/meson/nasm/python3-jinja2/zip …
  → JDK 17 + Gradle（仅配置，不产 AAR）+ NDK r27c
  → 手工 mkdir $ANDROID_HOME（setup-android 已失效）
  → buildscripts/bundle_default.sh
       ├─ download.sh  → 拉取 deps（ffmpeg 7.1.3 / mpv 32a164c / libplacebo d4624cb / lua 5.2.4 …）
       ├─ patch.sh     → 打 ffmpeg/libplacebo/mpv 补丁
       ├─ build.sh     → 4 ABI 交叉编译，prefix/<abi>/...
       ├─ NDK clang 编 libmediakitandroidhelper.so
       └─ 打包 default-<abi>.jar（libmpv.so + helper）
  → upload-artifact
  → main/手动 release：draft Release tag vnext
```

证据：`.github/workflows/build.yaml:1-85`、`buildscripts/bundle_default.sh:1-110`、`buildscripts/build.sh:13-45`。

## 2. 单 ABI 构建链

```
loadarch(armv7l|arm64|x86|x86_64)
  → 选 clang triple（API 26）
  → 生成 crossfile.txt（static、release、nodownload）
  → 按 dep_* 拓扑逐包构建：mbedtls/dav1d/libxml2 → ffmpeg → libass → lua → libplacebo → mpv
  → prefix/<abi>/usr/local/lib/*.so
```

依赖拓扑见 `buildscripts/include/depinfo.sh:34-57`。

## 3. 产物组装

```
prefix/<abi>/usr/local/lib/{libmpv.so, libmediakitandroidhelper.so}
  → temp/lib/<abi>/
  → touch 固定时间戳（可复现）
  → zip → default-<abi>.jar
  → 断言两个 .so 都在 jar 内，否则 job 失败
```

证据：`buildscripts/bundle_default.sh:63-110`。

## 4. 消费路径

```
Release jar → media-kit/libs/android/{media_kit_libs_android_audio, video}
  → media_kit 加载 libmpv.so + helper（JavaVM 注入）
  → simple_live_app Android 播放（mediacodec 硬解）
```

## 5. 失败与兜底

| 失败点 | 表现 | 兜底 |
| --- | --- | --- |
| setup-android 失效 | `sdkmanager tools` 报错 | 手工建 SDK 目录，不安装组件（`build.yaml:35-44`） |
| Gradle 构建 helper | 无 SDK/许可，jar 缺 helper → 黑屏无声 | 改用 NDK clang 直编（`c83800c`） |
| Lua 编译 | NDK 工具链 PATH 错 | `4a8a355` 修正 |
| 缺 helper | 硬解/输出初始化失败 | 打包后显式校验 `libmediakitandroidhelper.so` |
| 补丁漂移 | `patch.sh` 失败 | 见 backlog P1-1 |

## 历史锚点

| 流程 | 关键提交 |
| --- | --- |
| 本地 AF 滤镜 | `f0e8224`、`7c7412e`、`9d4241b` |
| 本地 Lua 5.2.4 | `a10303d`、`4a8a355` |
| helper 用 NDK clang 直编 | `c83800c` |
| CI 手工建 SDK 目录 | `4671506` |
