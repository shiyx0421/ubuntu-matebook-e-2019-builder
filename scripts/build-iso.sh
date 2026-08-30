#!/bin/bash
set -e

echo "📀 开始构建定制ISO..."

mkdir -p iso-mount output

# 挂载官方ISO
sudo mount -o loop ubuntu.iso iso-mount

# 解包根文件系统 (squashfs)
echo "📦 解包根文件系统..."
sudo unsquashfs -d rootfs iso-mount/casper/ubuntu-desktop.squashfs 2>/dev/null || \
    sudo unsquashfs -d rootfs iso-mount/casper/filesystem.squashfs

# 替换内核
echo "🔄 替换内核与设备树..."
sudo cp kernel-output/Image rootfs/boot/vmlinuz
sudo cp kernel-output/sdm850-huawei-matebook-e-2019.dtb rootfs/boot/

# 替换内核模块
echo "🔄 替换内核模块..."
sudo rm -rf rootfs/lib/modules/*
sudo cp -r kernel-output/modules/lib/modules/* rootfs/lib/modules/

# 添加固件 (如果有)
if [ -d "firmware" ]; then
    echo "📎 添加专有固件..."
    sudo cp -r firmware/* rootfs/lib/firmware/ 2>/dev/null || true
fi

# 重新打包 squashfs
echo "📦 重新打包根文件系统..."
sudo mksquashfs rootfs/ output/custom.squashfs -comp xz -noappend

# 使用 xorriso 重新打包 ISO
# 参考: https://gitlab.com/ncz-os/cix-installer/-/blob/main/build/build-iso.sh[reference:3]
echo "💿 生成最终 ISO..."
xorriso -as mkisofs \
    -r -V "Ubuntu-MateBook-E" \
    -J -joliet-long \
    -cache-inodes \
    -iso-level 3 \
    -partition_offset 16 \
    -A "Ubuntu/MateBook-E" \
    -p "Custom Build" \
    -b boot/grub/efi.img \
    -no-emul-boot \
    -boot-load-size 4 \
    -boot-info-table \
    -eltorito-alt-boot \
    -e boot/grub/efi.img \
    -no-emul-boot \
    -isohybrid-gpt-basdat \
    -append_partition 2 0xef iso-mount/boot/grub/efi.img \
    -o output/ubuntu-matebook-e-26.04.1.iso \
    iso-mount/ 2>/dev/null || \
    echo "⚠️ xorriso 打包失败，请检查 ISO 结构"

# 清理
sudo umount iso-mount
sudo rm -rf rootfs iso-mount

echo "✅ ISO 构建完成"
echo "📂 输出: $(ls -lh output/)"
