#!/bin/bash
#========================================================================================================================
# https://github.com/ophub/amlogic-s9xxx-openwrt
# Description: Automatically Build OpenWrt
# Function: Diy script (Before Update feeds, Modify the default IP, hostname, theme, add/remove software packages, etc.)
# Source code repository: https://github.com/immortalwrt/immortalwrt / Branch: master
#========================================================================================================================

# Add a feed source
# sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default



echo "src-git packages https://github.com/immortalwrt/packages.git;openwrt-23.05" >> feeds.conf.default
echo "src-git luci https://github.com/immortalwrt/luci.git;openwrt-23.05" >> feeds.conf.default
echo "src-git routing https://github.com/openwrt-routing/packages.git;openwrt-23.05" >> feeds.conf.default
echo "src-git telephony https://github.com/openwrt/telephony.git;openwrt-23.05" >> feeds.conf.default



# other
# rm -rf package/emortal/{autosamba,ipv6-helper}

