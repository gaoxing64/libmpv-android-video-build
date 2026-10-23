# libmpv-android-video-build 架构与选型对照

> 锚点：`main 4a8a355`（2026-10-21）｜范围：Gradle 壳、NDK 交叉编译、补丁、ABI 产物、CI
> 五件套：[workflow-diagram.md](./workflow-diagram.md)｜[update-history.md](./update-history.md)｜[backlog.md](./backlog.md)｜[test-suite.md](./test-suite.md)
> 消费方：[media-kit](../../media-kit/doc/architecture.md)｜同族：[win32](../../libmpv-win32-video-cmake/doc/architecture.md)｜[darwin](../../libmpv-darwin-build/doc/architecture.md)

## 1. 定位

Android 的 libmpv 构建仓（上游 `media-kit/libmpv-android-video-build` 系），产出 media-kit 使用的 per-ABI jar。Gradle 只做发布壳；真正的构建由 `buildscripts/*.sh` 驱动。

## 2. 分层

| 层 | 位置 | 职责 |
| --- | --- | --- |
| 发布壳 | `build.gradle.kts`、`settings.gradle.kts` | 声明 `:libmpv` AAR、publish 插件 |
| 编排 | `buildscripts/{download,patch,build,bundle_*}.sh` | 依赖下载→补丁→逐 ABI 构建→打包 |
| 版本/拓扑 | `buildscripts/include/depinfo.sh` | 版本号、commit SHA、依赖 DAG |
| 单包脚本 | `buildscripts/scripts/*.sh` | ffmpeg/mpv/libplacebo/lua/… 的 configure+make |
| 补丁 | `buildscripts/patches/{ffmpeg,libplacebo,mpv}` | 上游行为修正 |
| CI | `.github/workflows/build.yaml` | Debian 容器 + NDK r27c + 发布 draft |

## 3. 工具链与版本

| 项 | 值 | 证据 |
| --- | --- | --- |
| NDK | r27c（`27.2.12479018`） | `depinfo.sh:5`、`build.yaml:48` |
| minSdk / API | 26 | `build.sh:17-21` |
| ABI | armeabi-v7a / arm64-v8a / x86 / x86_64 | `build.sh:9,23-45` |
| FFmpeg | 7.1.3 | `depinfo.sh:15` |
| mpv | `32a164cc…`（0.41 线） | `depinfo.sh:16` |
| libplacebo | `d4624cbf…` | `depinfo.sh:17` |
| Lua | 5.2.4 | `depinfo.sh:9` |
| 页大小 | `-Wl,-z,max-page-size=16384` | `build.sh:54` |

## 4. 关键能力与补丁（来源：上游/本地）

> 本地分叉只有 8 条：4 个 AF 滤镜提交、Lua 2 条、helper 直编、CI SDK 目录。其余补丁与开关来自上游主线。

| 能力 | 原因 | 位置 |
| --- | --- | --- |
| `dynaudnorm/loudnorm/aresample/alimiter/acompressor` | 音量均衡；`aresample` 缺失会让 loudnorm 建图失败 | `flavors/default.sh:226-231` |
| Lua 5.2.4（`-Dlua=enabled`） | 恢复 mpv 内置脚本 | `scripts/lua.sh`、`scripts/mpv.sh:28` |
| HLS kazumi 合并补丁 | 伪装 HLS 流的探测/seek | `patches/ffmpeg/ffmpeg-hls-kazumi-combined.patch` |
| GLES shader 编译修复 | 部分设备的 shader 编译错误 | `patches/libplacebo/fix_gles_shader_compile_error.patch` |
| shaderc/Vulkan 不匹配 | Vulkan 1.4 构建 | `patches/libplacebo/fix_shaderc_vulkan_dismatch.patch` |
| fence leak 修复 | 播放/切台资源泄漏 | `patches/mpv/mpv_fence_leak-fix.patch` |
| `av_jni_set_java_vm` | Mediacodec 硬解需要 JavaVM | `patches/mpv/mpv_lavc_set_java_vm.patch` |
| 16KB page + helper 直编 | Android 15 设备；避免 Gradle/SDK 依赖 | `build.sh:54`、`bundle_default.sh:35-60` |

## 5. 产物与矩阵

- `default-<abi>.jar`（CI 唯一产出），内含 `libmpv.so` + `libmediakitandroidhelper.so`。
- flavor：`default` / `full` / `encoders-gpl`；完整矩阵需手动 `bundle_full.sh` / `bundle_encoders-gpl.sh`。
- 命名与打包脚本：`buildscripts/bundle_default.sh:80-110`。

## 6. 取舍与风险

- **不再用 Gradle 构建 helper**：CI 无 Android SDK，Gradle 会因许可失败并静默产出残缺 jar；直编更可控。
- **静态链接全部依赖**：jar 大，但运行时零额外 .so。
- **风险**：NDK/ffmpeg/libplacebo 升级导致补丁漂移；jar SHA 需人工同步到 media-kit；x86/x86_64 真机覆盖低。

## 历史锚点

| 决策 | 提交 |
| --- | --- |
| loudnorm/dynaudnorm | `f0e8224` |
| alimiter/acompressor | `7c7412e` |
| aresample | `9d4241b` |
| Lua 5.2.4 | `a10303d`、`4a8a355` |
| helper 直编 | `c83800c` |
