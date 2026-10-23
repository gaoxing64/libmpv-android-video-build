# libmpv-android-video-build 修改历史（Git 完整复现）

> 锚点：`main 4a8a355`（2026-10-21）｜全仓 **199** 条；本地分叉 **8** 条
> 五件套：[workflow-diagram.md](./workflow-diagram.md)｜[architecture.md](./architecture.md)｜[backlog.md](./backlog.md)｜[test-suite.md](./test-suite.md)
> 消费方：[media-kit](../../media-kit/doc/update-history.md)

> 作者列：G = gaoxing64，P = Predidit，其余为原值。

## 1. 复现命令

```bash
git log --date=short --pretty=format:'%h %ad %an %s'
git log --date=short --pretty=format:'%h %ad %an %s' upstream/main..HEAD
git log --oneline -- buildscripts/patches
```

## 2. 本地分叉（相对 upstream/main 全量 8 条）

| 日期 | 提交 | 作者 | 内容 |
| --- | --- | --- | --- |
| 2026-09-28 | `4a8a355` | G | fix(ci): 修 lua.sh 的 NDK 工具链 PATH |
| 2026-09-28 | `a10303d` | G | feat(lua): 恢复 lua 5.2.4 支持 |
| 2026-09-28 | `dc997ac` | G | fix(ci): 给 bundle_default.sh 补 shebang |
| 2026-09-28 | `c83800c` | G | fix(ci): 用 NDK clang 编译 libmediakitandroidhelper |
| 2026-09-27 | `9d4241b` | G | feat(ffmpeg): enable aresample filter |
| 2026-09-27 | `7c7412e` | G | feat(ffmpeg): enable alimiter/acompressor audio filters |
| 2026-09-26 | `4671506` | G | ci: create SDK dir manually instead of setup-android action |
| 2026-09-26 | `f0e8224` | G | feat(ffmpeg): enable dynaudnorm/loudnorm audio filters |

## 3. 全量时间线（199 条，新→旧）

| 日期 | 提交 | 作者 | 内容 |
| --- | --- | --- | --- |
| 2026-09-28 | `4a8a355` | G | fix(ci): 修 lua.sh 的 NDK 工具链 PATH |
| 2026-09-28 | `a10303d` | G | feat(lua): 恢复 lua 5.2.4 支持 |
| 2026-09-28 | `dc997ac` | G | fix(ci): 给 bundle_default.sh 补 shebang |
| 2026-09-28 | `c83800c` | G | fix(ci): 用 NDK clang 编译 libmediakitandroidhelper |
| 2026-09-27 | `9d4241b` | G | feat(ffmpeg): enable aresample filter |
| 2026-09-27 | `7c7412e` | G | feat(ffmpeg): enable alimiter/acompressor audio filters |
| 2026-09-26 | `4671506` | G | ci: create SDK dir manually instead of setup-android action |
| 2026-09-26 | `f0e8224` | G | feat(ffmpeg): enable dynaudnorm/loudnorm audio filters |
| 2026-08-11 | `dd2bfba` | P | fix(ffmpeg): improve HLS probing for disguised streams |
| 2026-06-04 | `045cd0f` | P | deps: bump libplacebo (#10) |
| 2026-04-27 | `5ba738d` | P | deps: pin more deps && fix libplacebo build |
| 2026-02-26 | `3b7ddcf` | P | feat: add gles shader patch (#9) |
| 2026-02-24 | `878c8af` | P | fix: libplacebo opengl sync object leak (#8) |
| 2026-02-07 | `d98d55c` | P | feat: ffmpeg 7.1.3 (#7) |
| 2026-01-31 | `3bfb48c` | P | fix: fix android API26 support (#6) |
| 2026-01-29 | `05df588` | P | feat: add libplacebo shaderc patch for vulkan 1.4 (#5) |
| 2026-01-28 | `31e7bdf` | P | feat: mpv 0.41 (#4) |
| 2025-12-10 | `e6d2a77` | 林晨 | feat: ad blocker (#3) |
| 2025-05-17 | `084342e` | P | fix android helper 16k page size support |
| 2025-05-16 | `56f1981` | P | support android 16k page size |
| 2025-01-25 | `6a17c15` | P | Merge pull request #2 from linsui/repro |
| 2025-01-25 | `78af54c` | linsui | Remove embeded path |
| 2025-01-21 | `9bcdfa2` | P | remove unused build-id flag |
| 2025-01-20 | `2d47176` | P | fix patch.sh |
| 2025-01-20 | `41ad128` | P | ndk link to sdk |
| 2025-01-20 | `b090175` | P | set ndk by github actions |
| 2025-01-20 | `d71fe14` | P | fix previous fix |
| 2025-01-20 | `5b27df6` | P | debian12: set android sdk |
| 2025-01-20 | `8ef9fd1` | P | add missing os_ndk params |
| 2025-01-20 | `39464d0` | P | try export ANDROID_HOME |
| 2025-01-20 | `6023754` | P | remove unused bask params |
| 2025-01-20 | `963ffc3` | P | try fix ANDROID_HOME path |
| 2025-01-20 | `589756b` | P | more check point |
| 2025-01-20 | `97cfe19` | P | add check point |
| 2025-01-20 | `7aa3536` | P | fix dependency |
| 2025-01-20 | `2cf9d64` | P | fix previous fix |
| 2025-01-20 | `a187a2e` | P | fix premisssion |
| 2025-01-20 | `ae26166` | P | add download sdk debian |
| 2025-01-20 | `5dfa200` | P | disable download_sdk.sh |
| 2025-01-20 | `5883835` | P | better dependency |
| 2025-01-20 | `92a9b1d` | P | remove debian backports |
| 2025-01-20 | `a7b5e12` | P | remove meson |
| 2025-01-20 | `4d9106e` | P | debian12: remove python3-* |
| 2025-01-20 | `f337536` | P | debian12: add missing apt params |
| 2025-01-20 | `7e4ef2e` | P | debian12: add backport source |
| 2025-01-19 | `81e164b` | P | debian12 slim |
| 2025-01-19 | `0e2a53b` | P | more dependency |
| 2025-01-19 | `63d2da4` | P | debian12 dependency (sudo) |
| 2025-01-19 | `c9b7b7a` | P | debian 12 |
| 2025-01-19 | `4659fb5` | P | try migrate to debian12 |
| 2025-01-19 | `5d8742c` | P | try ubuntu 24.04 |
| 2025-01-19 | `65fecde` | P | remove shaderrc build-id |
| 2025-01-19 | `71726fc` | P | fix previous fix |
| 2025-01-19 | `ae12b8d` | P | try disable build id |
| 2025-01-19 | `2ee4fc5` | P | print binary md5 |
| 2025-01-19 | `f5550a0` | P | sort .so files before zip |
| 2025-01-18 | `d481482` | P | pin .so path timestamp |
| 2025-01-18 | `537a30f` | P | pin .so timestamp |
| 2025-01-18 | `4fd4448` | P | try remove .jar timestamp |
| 2025-01-18 | `cb4c99a` | P | remove strip-all flag |
| 2025-01-18 | `edec2c7` | P | remove android helper build id |
| 2025-01-18 | `0815923` | P | remove mpv build date |
| 2025-01-18 | `708916e` | P | try enable strip all |
| 2025-01-18 | `2870db6` | P | enable strip for default build |
| 2025-01-18 | `156ab17` | P | remove missing frandom-seed flag |
| 2025-01-18 | `91f96c4` | P | remove fPIC flag for libxml2 |
| 2025-01-18 | `bcc7322` | P | remove fPIC flag for libass |
| 2025-01-18 | `04da016` | P | remove all random seed flag |
| 2025-01-18 | `9acaa3b` | P | remove all timestamp extra flags |
| 2025-01-18 | `307c6f7` | P | remove all c extra build flags for meason build |
| 2025-01-18 | `846abf9` | P | remove fribidi build flag |
| 2025-01-18 | `4078176` | P | fix fribidi build |
| 2025-01-18 | `f10168b` | P | fix libassmacro  redefine |
| 2025-01-18 | `678c005` | P | remove flutter dependency & try enable cmake reproduce |
| 2025-01-18 | `56756be` | P | re-add flutter dependency |
| 2025-01-18 | `37edefa` | P | add missing variables |
| 2025-01-18 | `264c07e` | P | try enable crypto for mbedtls |
| 2025-01-17 | `3ca0baf` | P | bump ndk to r27c & ndk build tools to 35.0 |
| 2025-01-17 | `b838980` | P | bump gradle & disable cache |
| 2025-01-17 | `d54d68c` | P | remove flutter dependency |
| 2025-01-17 | `a584d36` | P | bump ndk version to r27c |
| 2025-01-14 | `080fd2c` | P | add workflow dispatch |
| 2025-01-13 | `9e818e7` | P | Merge pull request #1 from ErBWs/main |
| 2025-01-13 | `d2f5f22` | ErBW_s | remove depth 1 |
| 2025-01-13 | `3c79fc0` | ErBW_s | fix mediakit git clone |
| 2025-01-13 | `bd56d84` | ErBW_s | f |
| 2025-01-13 | `2664878` | ErBW_s | change mediakit commit |
| 2025-01-13 | `3e1b6d1` | ErBW_s | f |
| 2025-01-13 | `0b35ce5` | ErBW_s | pin git tag or commit |
| 2024-12-01 | `0053be4` | P | add fvp patch |
| 2024-12-01 | `f606a74` | P | update upload path |
| 2024-12-01 | `8a6f1b7` | P | add debug output |
| 2024-12-01 | `68eee44` | P | remove native event loop |
| 2024-12-01 | `dae86af` | P | correct upload path |
| 2024-12-01 | `467b233` | P | update bundle_default.sh |
| 2024-12-01 | `4399e8b` | P | remove debug symbols |
| 2024-12-01 | `dcf00a6` | P | bump java to 17 |
| 2024-12-01 | `5670726` | P | disable full build & gpl build |
| 2024-12-01 | `2920d56` | P | revert to 186205a |
| 2024-12-01 | `0b01e94` | P | revert font render lib |
| 2024-11-30 | `d40c4f9` | P | revert libplacebo to 6.338.2 |
| 2024-11-30 | `66a170f` | P | revert ffmpeg to 0.37.0 |
| 2024-11-30 | `abf9a9b` | P | revert mpv to 0.37.0 & add fvp patch |
| 2024-11-30 | `68505dc` | P | remove ffmpeg patch temporary |
| 2024-11-30 | `3c5ad09` | P | corrent path in jar |
| 2024-11-30 | `7b670eb` | P | port ffmpeg patch from fvp |
| 2024-11-30 | `9af483d` | P | disable gpl encoder |
| 2024-10-14 | `ca0d9d2` | Hitesh Kumar S | build |
| 2024-09-30 | `293d1a6` | Jarne Demeulem | build: bump version to 0.4.1 |
| 2024-09-30 | `c517517` | Jarne Demeulem | chore: update ffmpeg and mbedtls |
| 2024-09-29 | `3f29fc7` | Jarne Demeulem | build: bump version to 0.4.0 |
| 2024-09-29 | `cf4c71f` | Jarne Demeulem | chore: update gradle |
| 2024-09-29 | `b51b789` | Jarne Demeulem | chore: update dependencies |
| 2024-08-12 | `9a04172` | jarnedemeuleme | build: bump version to 0.3.1 |
| 2024-08-10 | `2ad4046` | Jarne Demeulem | fix: add patch for ffmpeg mediacodec |
| 2024-08-10 | `df6a923` | Jarne Demeulem | chore(deps): update agp, annotation and gradle action |
| 2024-08-03 | `8cea9b7` | Jarne Demeulem | chore: support 16 KB page sizes |
| 2024-08-03 | `2672e3e` | Jarne Demeulem | chore(deps): upgrade ffmpeg to 7.0.2 |
| 2024-07-31 | `a981f99` | jarnedemeuleme | chore: update dependencies |
| 2024-07-04 | `c14949c` | jarnedemeuleme | chore(deps): update libass and libplacebo |
| 2024-06-30 | `7753090` | Jarne Demeulem | build: bump version to 0.3.0 |
| 2024-06-30 | `9f8a01f` | Jarne Demeulem | ci(publish): create release |
| 2024-06-30 | `4398de4` | Jarne Demeulem | chore: upgrade to sdk 35 and clean up ci workflows |
| 2024-06-30 | `d8d0aba` | Jarne Demeulem | chore(deps): update harfbuzz and dav1d |
| 2024-06-08 | `8aab5a3` | Jarne Demeulem | chore(deps): upgrade gradle, fribidi, dav1d, ffmpeg |
| 2024-05-23 | `d579f03` | Jarne Demeulem | chore(deps): upgrade agp, annotations, libass and harfbuzz |
| 2024-05-06 | `912ce01` | Jarne Demeulem | chore(deps): upgrade agp and fribidi |
| 2024-04-20 | `4516b31` | Jarne Demeulem | chore(deps): upgrade ffmpeg and mpv |
| 2024-04-13 | `2c799e0` | Jarne Demeulem | chore(deps): upgrade dependencies |
| 2024-04-13 | `918c987` | Jarne Demeulem | chore(deps): upgrade gradle and dependencies |
| 2024-02-24 | `52d2246` | Jarne Demeulem | ci: update gradle setup action |
| 2024-02-24 | `56bc62c` | Jarne Demeulem | build: bump version to 0.2.0 |
| 2024-02-24 | `94674bb` | Jarne Demeulem | chore: update gradle and android gradle plugin |
| 2024-02-24 | `30e5b8d` | Jarne Demeulem | chore: update sdk tools, ndk, mbedtls and dav1d |
| 2024-01-23 | `e605211` | jarnedemeuleme | chore: update libplacebo and ffmpeg |
| 2023-12-31 | `d97daff` | Jarne Demeulem | build: bump version to 0.1.4 |
| 2023-12-31 | `9a5ad20` | Jarne Demeulem | chore: update android plugin and androidx annotations |
| 2023-12-31 | `6c1925f` | Jarne Demeulem | chore: update github actions |
| 2023-12-31 | `238d1e9` | Jarne Demeulem | chore: update gradle to 8.5 |
| 2023-11-24 | `be46a78` | Jarne Demeulem | build: update mpv to 0.37 and add libplacebo |
| 2023-11-18 | `fc7de4a` | Jarne Demeulem | build(mbedtls): fix x86 compilation |
| 2023-11-18 | `99d3a02` | Jarne Demeulem | build(ffmpeg): disable v4l2-m2m |
| 2023-11-18 | `4086579` | Jarne Demeulem | build: update ndk and checkout action |
| 2023-11-18 | `2f67b0d` | Jarne Demeulem | chore: update dependencies and upstream changes |
| 2023-09-23 | `522916d` | Jarne Demeulem | build: upgrade harfbuzz to 8.2.1 |
| 2023-09-14 | `e292f14` | jarnedemeuleme | build: upgrade harfbuzz and freetype |
| 2023-08-22 | `0995027` | Jarne Demeulem | build: small cleanup |
| 2023-08-21 | `f8ddfb7` | Jarne Demeulem | build: convert publish gradle files to kotlin dsl |
| 2023-08-21 | `afa6cab` | jarnedemeuleme | build: bump version to 0.1.3 |
| 2023-08-20 | `d95103b` | Jarne Demeulem | chore(deps): update gradle to v8.3 |
| 2023-08-14 | `ceadd45` | Jarne Demeulem | fix(mpv): add patch to restore default sub selection behavior |
| 2023-08-13 | `e613d7e` | Jarne Demeulem | build: remove shaderc as it does not work right now |
| 2023-08-13 | `360ac23` | Jarne Demeulem | build: build mpv with meson |
| 2023-08-12 | `2668bbc` | Jarne Demeulem | build: compile with sdk 34 |
| 2023-08-12 | `370dc6e` | Jarne Demeulem | build: upgrade to gradle 8.2.1 |
| 2023-08-12 | `f7490b7` | Jarne Demeulem | build: upgrade harfbuzz and mbedtls |
| 2023-08-12 | `603a9a1` | Jarne Demeulem | ci: pin major versions of actions |
| 2023-07-24 | `b4e46b7` | Jarne Demeulem | build: upgrade sdk, harfbuzz, fribidi, dav1d and mpv |
| 2023-05-08 | `a4f9591` | Jarne Demeulem | build: bump version to 0.1.2 |
| 2023-05-08 | `4b9bd35` | Jarne Demeulem | build: fix `patch.sh` when there are no patches |
| 2023-05-07 | `2c05448` | Jarne Demeulem | build: disable harfbuzz docs |
| 2023-05-07 | `e339a68` | Jarne Demeulem | build: upgrade ndk, build tools, libass, harfbuzz, mbedtls, libplacebo, dav1d, ffmpeg |
| 2023-02-18 | `f915a8b` | Jarne Demeulem | build: upgrade harfbuzz, freetype, mbedtls and dav1d |
| 2023-02-18 | `be44ef8` | Jarne Demeulem | ci: apply patches |
| 2023-02-07 | `0403925` | Jarne Demeulem | ci: add publish.yaml |
| 2023-02-07 | `977cb11` | Jarne Demeulem | build: upgrade libmpv and libplacebo |
| 2023-02-06 | `e0003ce` | Jarne Demeulem | build: unset ANDROID_SDK_ROOT and ANDROID_NDK_ROOT |
| 2023-02-06 | `5c6e0a6` | Jarne Demeulem | build: install nasm |
| 2023-02-06 | `c4da8a9` | Jarne Demeulem | build: fix shaderc includ |
| 2023-02-05 | `f85709c` | Jarne Demeulem | ci: fix shaderc linking bug |
| 2023-02-05 | `3b77af4` | Jarne Demeulem | temp: echo $PWD |
| 2023-02-05 | `b10e8eb` | Jarne Demeulem | temp: debug current working directory |
| 2023-02-05 | `a0f127c` | Jarne Demeulem | temp: only build libplacebo |
| 2023-02-05 | `96a28cc` | Jarne Demeulem | ci: create build.yaml |
| 2023-01-05 | `f991cfb` | Jarne Demeulem | Set up publishing to Maven Central |
| 2023-01-01 | `5759a7f` | Jarne Demeulem | Rename ndk version var |
| 2023-01-01 | `652799b` | Jarne Demeulem | Simplify ndk location |
| 2023-01-01 | `86c4b0a` | Jarne Demeulem | Don't download m2repository but do install cmake |
| 2023-01-01 | `c3436c0` | Jarne Demeulem | Fix download folder check freetype |
| 2023-01-01 | `8e9e4b0` | Jarne Demeulem | Change version to 0.1.0 |
| 2023-01-01 | `bcd6e06` | Jarne Demeulem | Make use of existing android sdk if symlinked |
| 2022-12-31 | `d375143` | Jarne Demeulem | Build all architectures by default |
| 2022-12-30 | `303e609` | Jarne Demeulem | Revert "Switch to meson for mpv build" |
| 2022-12-30 | `cfaeaeb` | Jarne Demeulem | Bump shaderc to 2022.1 |
| 2022-12-30 | `bc19522` | Jarne Demeulem | Switch to meson for mpv build |
| 2022-12-30 | `854883a` | Jarne Demeulem | Switch to cmake for building native part and use externalNativeBuild inside build.gradle |
| 2022-12-30 | `b75bf34` | Jarne Demeulem | Remove gcc option |
| 2022-12-29 | `3a428d6` | Jarne Demeulem | Switch to version catalog |
| 2022-12-29 | `e789592` | Jarne Demeulem | Switch to kotlin dsl for gradle files |
| 2022-12-28 | `9f2cfbc` | Jarne Demeulem | Upgrade to gradle 7.6 |
| 2022-12-28 | `99cdfb8` | Jarne Demeulem | Remove `cacert.pem` and `subfont.ttf` |
| 2022-12-27 | `e5f91a5` | Jarne Demeulem | Apply custom patches |
| 2022-12-25 | `60f4f2e` | Jarne Demeulem | Rename app to libmpv and add publishing |
| 2022-12-25 | `bcb4648` | Jarne Demeulem | Update README |
| 2022-12-25 | `c112b73` | Jarne Demeulem | Also disable vulkan in mpv |
| 2022-12-25 | `cca4813` | Jarne Demeulem | Disable mpv cplayer |
| 2022-12-25 | `8961881` | Jarne Demeulem | Disable vulkan in libplacebo |
| 2022-12-25 | `8e53f7f` | Jarne Demeulem | Use shaderc source from ndk |
| 2022-12-25 | `cc33914` | Jarne Demeulem | Initial commit |

## 4. 当前状态

- 分支 `main`，HEAD `4a8a355`；相对上游领先 8 条（Lua、5 个 AF 滤镜、helper 直编、SDK 目录）。
- 全量历史中 2025-01 的 30+ 条为 Debian 12 CI 迁移试错。
