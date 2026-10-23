# libmpv-android-video-build 测试案例库（面向 AI）

> 锚点：`main 4a8a355`（2026-10-21）｜无单元测试，验收以构建产物 + 真机冒烟为准
> 五件套：[workflow-diagram.md](./workflow-diagram.md)｜[architecture.md](./architecture.md)｜[update-history.md](./update-history.md)｜[backlog.md](./backlog.md)
> 消费方：[media-kit](../../media-kit/doc/architecture.md)

## 1. 怎么跑

```bash
cd buildscripts
./download.sh && ./patch.sh && ./bundle_default.sh
# 或复用编排：./bundle_default.sh（内部已含 download/patch/build）
```

CI：`.github/workflows/build.yaml`（PR、push main、workflow_dispatch）。

## 2. 构建验收用例

| ID | 前置 | 步骤 | 期望 |
| --- | --- | --- | --- |
| TC-A-01 | 依赖/NDK 就绪 | `./bundle_default.sh` | 退出码 0；生成 4 个 `default-<abi>.jar` |
| TC-A-02 | jar 存在 | `unzip -l default-arm64-v8a.jar` | 同时含 `libmpv.so`、`libmediakitandroidhelper.so` |
| TC-A-03 | 同上 | 对 4 个 ABI 重复 TC-A-02 | 每个 jar 都含两个 .so |
| TC-A-04 | 解包 .so | `llvm-readelf -l libmpv.so` | LOAD 段对齐 ≥ 16KB |
| TC-A-05 | 解包 .so | `llvm-readelf -d libmpv.so` | 无 `liblua/libass/libplacebo` 外部依赖（静态链接） |
| TC-A-06 | 滤镜 | `strings libmpv.so \| grep -E 'loudnorm\|aresample'` | 命中；缺失视为滤镜未编入 |
| TC-A-07 | Lua | `strings libmpv.so \| grep -i lua` | 有 Lua 符号 |
| TC-A-08 | ABI | `llvm-readelf -h` 检查 Machine | arm64-v8a=AArch64；armeabi-v7a=ARM；x86_64=X86-64 |
| TC-A-09 | 真机 | 装 media-kit 示例，播放 HLS/FLV 直播 | 首帧出现、有声音、硬解生效 |
| TC-A-10 | 真机 | 切换清晰度/线路 | 不黑屏、不崩溃；helper 注入 JavaVM 成功 |
| TC-A-11 | 伪装 HLS | 播放扩展名非 m3u8 的 HLS | 正确识别并起播（kazumi 补丁） |
| TC-A-12 | 音量均衡 | App 打开音量均衡播放 | 响度变化生效，无静音 |

## 3. 发布前清单

1. jar 的 MD5/SHA 已记录并同步 media-kit。
2. Release 为 draft（`vnext`），附件为 4 个 jar。
3. 至少 arm64-v8a 真机通过 TC-A-09/10。
4. 本次若升级 ffmpeg/libplacebo/NDK，补跑 TC-A-11/12。

## 4. 已知限制

- CI 产物只有 `default` flavor；full/encoders-gpl 需本地手动构建。
- x86/x86_64 无持续真机覆盖（见 backlog P1-3）。

## 历史锚点

| 用例 | 守护的提交 |
| --- | --- |
| TC-A-02/03 helper | `c83800c` |
| TC-A-06 滤镜 | `f0e8224`、`7c7412e`、`9d4241b` |
| TC-A-07 Lua | `a10303d`、`4a8a355` |
