#!/bin/bash
#========================================================================================================================
# https://github.com/ophub/amlogic-s9xxx-openwrt
# Description: Automatically Build OpenWrt
# Function: Diy script (After Update feeds, Modify the default IP, hostname, theme, add/remove software packages, etc.)
# Source code repository: https://github.com/immortalwrt/immortalwrt / Branch: master
#========================================================================================================================

# ------------------------------- Main source started -------------------------------
#
# Add the default password for the 'root' user（Change the empty password to 'password'）
sed -i 's/root:::0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.::0:99999:7:::/g' package/base-files/files/etc/shadow

# Set etc/openwrt_release
sed -i "s|DISTRIB_REVISION='.*'|DISTRIB_REVISION='R$(date +%Y.%m.%d)'|g" package/base-files/files/etc/openwrt_release
echo "DISTRIB_SOURCECODE='immortalwrt'" >>package/base-files/files/etc/openwrt_release

# Modify default IP（FROM 192.168.1.1 CHANGE TO 192.168.31.4）
# sed -i 's/192.168.1.1/192.168.31.4/g' package/base-files/files/bin/config_generate
#
# ------------------------------- Main source ends -------------------------------

# ------------------------------- Other started -------------------------------
#
# Add luci-app-amlogic
rm -rf package/luci-app-amlogic
git clone https://github.com/ophub/luci-app-amlogic.git package/luci-app-amlogic
#
# Apply patch
# git apply ../config/patches/{0001*,0002*}.patch --directory=feeds/luci
#
# ------------------------------- Other ends -------------------------------
# 假设 $OPENWRT_KERNEL_VERSION 是通过环境变量或者其它方式传递给脚本的
OPENWRT_KERNEL_VERSION="6.1.96"  
KERNEL_DOWNLOAD_URL="https://github.com/ophub/kernel/releases/download/kernel_stable/${OPENWRT_KERNEL_VERSION}.tar.gz"

# 下载内核
curl -L $KERNEL_DOWNLOAD_URL -o kernel.tar.gz
if [ $? -ne 0 ]; then
    echo "Failed to download kernel from $KERNEL_DOWNLOAD_URL"
    exit 1
fi

# 解压内核
tar -xzf kernel.tar.gz -C /home/runner/work/amlogic-s9xxx-openwrt/amlogic-s9xxx-openwrt/kernel 

# 检查 kconfig-package 是否已安装，如果未安装则进行安装
if ! command -v kconfig-package &> /dev/null; then
    ./scripts/feeds install -a -p kconfig-package
fi

#  打印环境变量 PATH 的值
export PATH=$PATH:$(pwd)/feeds/packages/utils/kconfig-package/

#  尝试执行 kconfig-package 命令，并将命令的输出和错误信息都打印到控制台
kconfig-package --version 2>&1

# 打印错误信息
if [ $? -ne 0 ]; then
    echo "Error running kconfig-package: $?" 
fi

# 选择 jool 软件包 - 使用 kconfig-package
(
  echo "CONFIG_PACKAGE_jool=y"
  echo "CONFIG_PACKAGE_jool-core=y"
  echo "CONFIG_PACKAGE_jool-tools=y"
  echo "CONFIG_PACKAGE_jool-tools-netfilter=y"
  echo "CONFIG_ALL_KMODS=y" 
) | kconfig-package -s .config

# ... 其他代码 ... 
tar -czvf kmods.tar.gz -C openwrt/bin/targets/{target}/kmods .
