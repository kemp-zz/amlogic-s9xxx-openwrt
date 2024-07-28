```bash
#!/bin/bash

# 检查GITHUB_OUTPUT中是否包含 "smart-am40"
if [ "$(grep -c "smart-am40" $GITHUB_OUTPUT)" -eq '1' ]; then
  # 获取内核版本值
  curl -s https://downloads.immortalwrt.org/snapshots/targets/armsr/armv8/kmods/6.1.86-1-58955783205c88e28ca2f240287756a0/Packages.manifest | grep kernel | awk '{print $3}' | awk -F- '{print $3}' > vermagic
  echo "smart-am40 Vermagic Done"
  echo "当前Vermagic："
  cat vermagic

  # 修改 kernel-defaults.mk 以使用固定的 vermagic
  sed -i '/grep '\''=\[ym\]'\'' $(LINUX_DIR)\/\.config\.set | LC_ALL=C sort | $(MKHASH) md5 > $(LINUX_DIR)\/\.vermagic/s/^/# /' ./include/kernel-defaults.mk
  sed -i '/$(LINUX_DIR)\/\.vermagic/a \\tcp $(TOPDIR)/vermagic $(LINUX_DIR)/.vermagic' ./include/kernel-defaults.mk
fi
