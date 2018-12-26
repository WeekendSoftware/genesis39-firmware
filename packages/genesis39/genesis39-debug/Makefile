

#
# Copyright (c) 2018 Gregory L. Dietsche <Gregory.Dietsche@cuw.edu>
# This is free software, licensed under the MIT License
#

include $(TOPDIR)/rules.mk

PKG_NAME:=genesis39-debug
PKG_VERSION:=1.0.0
PKG_RELEASE:=3
PKG_LICENSE:=MIT
PKG_MAINTAINER:=Gregory L. Dietsche <Gregory.Dietsche@cuw.edu>

include $(INCLUDE_DIR)/package.mk

define Package/genesis39-debug
	SECTION:=genesis39
	CATEGORY:=Genesis39
	TITLE:=Genesis 39 Remote Debug
	PKGARCH:=all
endef

define Package/genesis39-debug/description
Allow software engineers at the Genesis39 project to access and debug your
wireless device.
endef

define Build/Compile
endef

define Package/genesis39-debug/install
	$(INSTALL_DIR) $(1)/etc/dropbear
	$(INSTALL_DATA) ./files/authorized_keys $(1)/etc/dropbear/authorized_keys
endef

define Package/genesis39-debug/postinst
#!/bin/sh
if [ -z "$${IPGK_INSTROOT}" ]; then
  echo src/gz genesis39 http://192.168.1.101/packages>> /etc/opkg/customfeeds.conf
fi
exit 0
endef

define Package/genesis39-debug/prerm
#!/bin/sh
if [ -z "$${IPGK_INSTROOT}" ]; then
  cat /etc/opkg/customfeeds.conf | grep -v "src/gz genesis39 http://192.168.1.101/packages" > /etc/opkg/customfeeds.conf
fi
exit 0
endef

$(eval $(call BuildPackage,genesis39-debug))
