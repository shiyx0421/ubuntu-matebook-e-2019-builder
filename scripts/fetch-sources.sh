#!/bin/bash
set -e

echo "📥 获取内核源码与设备树..."

# 克隆社区维护的内核分支 (骁龙850/845平台)
# 来源: https://github.com/riverzhou/matebooke2019kernel[reference:0]
git clone --depth 1 https://github.com/riverzhou/matebooke2019kernel.git kernel-src

# 获取最新的设备树文件 (如果内核中已包含则跳过)
# 来源: https://gitlab.com/New-Wheat/linux-for-huawei-matebook-e-2019[reference:1]
wget -O dts/sdm850-huawei-matebook-e-2019.dts \
  https://gitlab.com/New-Wheat/linux-for-huawei-matebook-e-2019/-/raw/main/sdm850-huawei-matebook-e-2019.dts 2>/dev/null || \
  echo "⚠️ 设备树文件已在内核中，跳过单独下载"

echo "✅ 源码准备完成"
