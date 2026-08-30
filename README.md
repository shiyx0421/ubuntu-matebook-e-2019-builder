# Ubuntu 26.04.1 for Huawei MateBook E 2019

基于 GitHub Actions 自动构建适用于 MateBook E 2019 (骁龙850) 的定制 Ubuntu ARM64 镜像。

## 硬件支持状态

| 功能 | 状态 |
|------|------|
| 音量键 / 电源键 | ✅ 支持 |
| 触摸屏 / 触控笔 | ✅ 支持 |
| WiFi / 蓝牙 | ✅ 支持 |
| USB / 键盘 / 触摸板 | ✅ 支持 |
| UFS 存储 / GPU | ✅ 支持 |
| 音频 | ⚠️ 极不稳定 |
| 摄像头 | ❌ 不支持 |
| 电池监控 / 背光 | ❌ 不支持 |

> 需要将专有固件放入 `/lib/firmware`

## 使用方法

1. Fork 本仓库
2. 进入 Actions → 手动触发 Workflow
3. 选择 Ubuntu 版本和镜像类型 (Desktop/Server)
4. 等待约 60-90 分钟构建完成
5. 从 Artifacts 下载 ISO

## 参考资源

- 设备树: [NewWheat/linux-for-huawei-matebook-e-2019](https://gitlab.com/New-Wheat/linux-for-huawei-matebook-e-2019)[reference:8]
- 内核源码: [riverzhou/matebooke2019kernel](https://github.com/riverzhou/matebooke2019kernel)[reference:9]
- 社区讨论: [aarch64-laptops/build#73](https://github.com/aarch64-laptops/build/issues/73)[reference:10]
- ISO 构建参考: [YasuhiroABE/ub-autoinstall-iso](https://github.com/YasuhiroABE/ub-autoinstall-iso)[reference:11]
