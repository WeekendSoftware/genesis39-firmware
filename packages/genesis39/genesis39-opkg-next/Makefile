#
# Copyright (c) 2020 Gregory L. Dietsche <Gregory.Dietsche@cuw.edu>
# This is free software, licensed under the MIT License
#

include $(TOPDIR)/rules.mk

PKG_NAME:=genesis39-opkg-next
PKG_VERSION:=1.0.0
PKG_RELEASE:=4
PKG_LICENSE:=MIT
PKG_MAINTAINER:=Gregory L. Dietsche <Gregory.Dietsche@cuw.edu>

include $(INCLUDE_DIR)/package.mk

define Package/genesis39-opkg-next
	SECTION:=genesis39
	CATEGORY:=Genesis39
	TITLE:=Genesis 39 opkg next update sources
	PKGARCH:=all
  DEPENDS:=genesis39-debug
endef

define Package/genesis39-opkg-next/description
next development opkg repository for Genesis39 project.
endef

define Build/Compile
endef

define Package/genesis39-opkg-next/install
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_DATA) ./files/*.uci-defaults $(1)/etc/uci-defaults/
endef

define Package/genesis39-opkg-next/prerm
#!/bin/sh
if [ -z "$${IPGK_INSTROOT}" ]; then
  sed -i "/^src\/gz genesis39 http:\/\/www\.genesis39\.org\/static\/packages\/next" /etc/opkg/customfeeds.conf 
fi
exit 0
endef

$(eval $(call BuildPackage,genesis39-opkg-next))
