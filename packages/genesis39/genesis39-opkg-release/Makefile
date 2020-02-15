#
# Copyright (c) 2018 Gregory L. Dietsche <Gregory.Dietsche@cuw.edu>
# This is free software, licensed under the MIT License
#

include $(TOPDIR)/rules.mk

PKG_NAME:=genesis39-opkg-release
PKG_VERSION:=1.0.0
PKG_RELEASE:=9
PKG_LICENSE:=MIT
PKG_MAINTAINER:=Gregory L. Dietsche <Gregory.Dietsche@cuw.edu>

include $(INCLUDE_DIR)/package.mk

define Package/genesis39-opkg-release
	SECTION:=genesis39
	CATEGORY:=Genesis39
	TITLE:=Genesis 39 opkg release update sources
	PKGARCH:=all
  DEPENDS:= \
  	+ca-certificates \
  	+ca-bundle \
  	+libustream-openssl
endef

define Package/genesis39-opkg-release/description
Production opkg repository for Genesis39 project.
endef

define Build/Compile
endef

define Package/genesis39-opkg-release/install
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_DATA) ./files/*.uci-defaults $(1)/etc/uci-defaults/
endef

define Package/genesis39-opkg-release/prerm
#!/bin/sh
if [ -z "$${IPGK_INSTROOT}" ]; then
  sed -i "/^src\/gz genesis39-opkg-release https:\/\/www\.genesis39\.org\/static\/packages\/release/d" /etc/opkg/customfeeds.conf 
fi
exit 0
endef

$(eval $(call BuildPackage,genesis39-opkg-release))
