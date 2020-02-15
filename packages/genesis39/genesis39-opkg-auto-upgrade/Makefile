

#
# Copyright (c) 2018 Gregory L. Dietsche <Gregory.Dietsche@cuw.edu>
# This is free software, licensed under the MIT License
#

include $(TOPDIR)/rules.mk

PKG_NAME:=genesis39-opkg-auto-upgrade
PKG_VERSION:=1.0.0
PKG_RELEASE:=5
PKG_LICENSE:=MIT
PKG_MAINTAINER:=Gregory L. Dietsche <Gregory.Dietsche@cuw.edu>

include $(INCLUDE_DIR)/package.mk

define Package/genesis39-opkg-auto-upgrade
	SECTION:=genesis39
	CATEGORY:=Genesis39
	TITLE:=Genesis 39 Automatic Upgrades
	PKGARCH:=all
  DEPENDS:=genesis39-keys \
  	genesis39-opkg-release
endef

define Package/genesis39-opkg-auto-upgrade/description
Automatic Genesis39 Project Upgrades
endef

define Build/Compile
endef

define Package/genesis39-opkg-auto-upgrade/install
	$(INSTALL_DIR) $(1)/sbin
	$(INSTALL_BIN) ./files/sbin/* $(1)/sbin/

	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_DATA) ./files/uci-defaults/* $(1)/etc/uci-defaults/
endef

define Package/genesis39-opkg-auto-upgrade/prerm
#!/bin/sh
if [ -z "$${IPGK_INSTROOT}" ]; then
  crontab -l | grep -v "0 3 \* \* 1 /sbin/genesis39-opkg-upgrade" | sort | uniq | crontab -
fi
exit 0
endef

$(eval $(call BuildPackage,genesis39-opkg-auto-upgrade))
