#
# Copyright (c) 2018 Gregory L. Dietsche <Gregory.Dietsche@cuw.edu>
# This is free software, licensed under the MIT License
#

include $(TOPDIR)/rules.mk

PKG_NAME:=genesis39-opkg
PKG_VERSION:=1.0.0
PKG_RELEASE:=1
PKG_LICENSE:=MIT
PKG_MAINTAINER:=Gregory L. Dietsche <Gregory.Dietsche@cuw.edu>

include $(INCLUDE_DIR)/package.mk

define Package/genesis39-opkg
	SECTION:=genesis39
	CATEGORY:=Genesis39
	TITLE:=Genesis 39 opkg update sources
	PKGARCH:=all
endef

define Package/genesis39-opkg/description
Where to download the latest version of the genesis39 project.
endef

define Build/Compile
endef

define Package/genesis39-opkg/install
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_DATA) ./files/uci-defaults/* $(1)/etc/uci-defaults/
endef

define Package/genesis39-opkg/prerm
#!/bin/sh
if [ -z "$${IPGK_INSTROOT}" ]; then
  cat /etc/opkg/customfeeds.conf | grep -v "src/gz genesis39 http://192.168.1.101/packages" > /etc/opkg/customfeeds.conf
fi
exit 0
endef

$(eval $(call BuildPackage,genesis39-opkg))
