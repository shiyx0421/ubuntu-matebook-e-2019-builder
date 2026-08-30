#!/bin/bash
set -e

echo "🔨 开始交叉编译内核..."

cd kernel-src

# 使用ARM64默认配置
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig

# 应用额外配置 (如需要)
if [ -f "../configs/kernel-config" ]; then
    cat "../configs/kernel-config" >> .config
    make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- olddefconfig
fi

# 编译内核镜像和设备树
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j$(nproc) Image dtbs modules

# 安装模块到临时目录
mkdir -p ../kernel-output/modules
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- \
    INSTALL_MOD_PATH=../kernel-output/modules \
    modules_install

# 复制内核镜像和设备树
cp arch/arm64/boot/Image ../kernel-output/
cp arch/arm64/boot/dts/qcom/sdm850-huawei-matebook-e-2019.dtb ../kernel-output/ 2>/dev/null || \
    echo "⚠️ 设备树未在标准路径生成，请检查"

cd ..

echo "✅ 内核编译完成"
echo "📂 输出目录: kernel-output/"
ls -lh kernel-output/
