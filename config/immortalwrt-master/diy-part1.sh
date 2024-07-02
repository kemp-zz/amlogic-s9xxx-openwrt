#!/bin/bash
#========================================================================================================================
# https://github.com/ophub/amlogic-s9xxx-openwrt
# Description: Automatically Build OpenWrt
# Function: Diy script (Before Update feeds, Modify the default IP, hostname, theme, add/remove software packages, etc.)
# Source code repository: https://github.com/immortalwrt/immortalwrt / Branch: master
#========================================================================================================================

# Add a feed source
# sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default


# 创建 package/emortal 目录
mkdir -p package/emortal

# 删除 autosamba 和 ipv6-helper 软件包（如果需要）
rm -rf package/emortal/{autosamba,ipv6-helper}

# ... (其他代码) ...
# other
# rm -rf package/emortal/{autosamba,ipv6-helper}

