# libmpv-android-video-build 待办与优化清单

> 锚点：`main 4a8a355`（2026-10-21）
> 五件套：[workflow-diagram.md](./workflow-diagram.md)｜[architecture.md](./architecture.md)｜[update-history.md](./update-history.md)｜[test-suite.md](./test-suite.md)
> 消费方：[media-kit](../../media-kit/doc/architecture.md)

## P0 — 会直接影响播放

| ID | 现象 | 证据 | 建议 |
| --- | --- | --- | --- |
| P0-1 | jar 缺 `libmediakitandroidhelper.so` 时硬解/输出初始化失败，表现为黑屏无声 | `bundle_default.sh:103-110`；`c83800c` | 保留打包后断言；release 前抽查 jar 内容 |
| P0-2 | 音量均衡依赖定制 ffmpeg；替换成上游库则滤镜静默失效 | `flavors/default.sh:226-231`、`9d4241b` | media-kit 更新 jar 时校验 `loudnorm/aresample` |
| P0-3 | 16KB page size 不满足会导致 Android 15 设备无法加载 | `build.sh:54`、`56f1981` | 每次 NDK 升级后检查 `.so` 段对齐 |

## P1 — 构建脆弱点

| ID | 现象 | 证据 | 建议 |
| --- | --- | --- | --- |
| P1-1 | 3 组补丁按上下文打，ffmpeg/libplacebo 升级易冲突 | `buildscripts/patches/**` | bump 依赖时逐补丁重放并记录偏移 |
| P1-2 | CI 只产 `default` flavor，`full`/`encoders-gpl` 无自动化 | `build.yaml:60-64` | 需要时加矩阵或定时构建 |
| P1-3 | x86/x86_64 产物无真机验证 | `build.sh:9` | 至少模拟器冒烟一次 |
| P1-4 | Lua 脚本依赖 `-Dlua=enabled` 与 lua.sh 的 bionic 兼容宏 | `scripts/lua.sh:17-25` | 升级 Lua 时重跑 test-suite |
| P1-5 | 构建依赖 Debian bookworm + backports meson，版本漂移风险 | `build.yaml:23-31` | 固定 meson 版本或镜像 |

## P2 — 可维护性

| ID | 现象 | 证据 | 建议 |
| --- | --- | --- | --- |
| P2-1 | jar 哈希靠人工同步到 media-kit | `media-kit/libs/android` | 发布后自动开 PR 更新 |
| P2-2 | Gradle 壳保留但实际不参与构建，易误解 | `build.gradle.kts` | 注释说明或移除 |
| P2-3 | 补丁无来源/适用版本记录 | `patches/**` | 每个 patch 头部写上游 issue/适用版本 |

## 已决策取舍

- 保持「CI 只产 default」：full/encoders-gpl 体积大且本项目不用。
- 保持静态依赖与单 jar/ABI：简化运行时加载，接受包体增大。

## 历史锚点

| 条目 | 来源提交 |
| --- | --- |
| P0-1 jar 缺 helper | `c83800c` |
| P0-2 滤镜静默失效 | `9d4241b` |
| P1-4 Lua 兼容宏 | `a10303d`、`4a8a355` |
