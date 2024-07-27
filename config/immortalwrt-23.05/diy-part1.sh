#!/bin/bash
# diy-part1.sh script for Amlogic S9xxx OpenWrt

# Clone the packages repository
git clone -b openwrt-23.05 https://github.com/immortalwrt/packages.git

# Set kernel version to 6.1.100
KERNEL_VERSION="6.1.100"

# Update kernel version in configuration
sed -i "s/CONFIG_KERNEL_VERSION=\".*\"/CONFIG_KERNEL_VERSION=\"$KERNEL_VERSION\"/g" .config

# Update include/rootfs.mk to copy target/packages to /modules
sed -i '/define Build\/Prepare\/rootfs/a\ \t$(CP) $(STAGING_DIR)/target/packages $(BUILD_DIR)/rootfs/modules' include/rootfs.mk

# Update opkg.conf to use local source
sed -i '/src\/gz openwrt_core/d' package/feeds/packages/opkg/files/opkg.conf
echo 'src/gz openwrt_core file:///modules' >> package/feeds/packages/opkg/files/opkg.conf

# Ensure configuration is updated
make defconfig

echo "Kernel version set to $KERNEL_VERSION"
