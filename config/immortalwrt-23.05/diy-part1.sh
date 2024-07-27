#!/bin/bash
# diy-part1.sh script for Amlogic S9xxx OpenWrt

# Clone the packages repository
git clone -b openwrt-23.05 https://github.com/immortalwrt/packages.git

# Set kernel version to 6.1.100
KERNEL_VERSION="6.1.100"

# Update kernel version in configuration
sed -i "s/CONFIG_KERNEL_VERSION=\".*\"/CONFIG_KERNEL_VERSION=\"$KERNEL_VERSION\"/g" .config

# Update kernel version in other relevant files if needed
# For example, in target configuration files or Makefiles
# Make sure to update this part according to your project's structure

# Example: update kernel version in target Makefile
# sed -i "s/^KERNEL_PATCHVER:=.*$/KERNEL_PATCHVER:=$KERNEL_VERSION/" target/linux/your_target/Makefile

# Ensure configuration is updated
make defconfig

echo "Kernel version set to $KERNEL_VERSION"
