#
# Copyright (c) 2020 Gregory L. Dietsche <Gregory.Dietsche@cuw.edu>
# This is free software, licensed under the MIT License
#

include $(TOPDIR)/rules.mk

PKG_NAME:=genesis39
PKG_VERSION:=1.0.0
PKG_RELEASE:=1
PKG_LICENSE:=MIT
PKG_MAINTAINER:=Gregory L. Dietsche <Gregory.Dietsche@cuw.edu>

include $(INCLUDE_DIR)/package.mk

define Package/genesis39
	SECTION:=genesis39
	CATEGORY:=Genesis39
	TITLE:=Genesis 39
	PKGARCH:=all
  DEPENDS:= \
  	+genesis39-auto-upgrade \
  	+genesis39-dns \
  	+genesis39-scripts \
  	+genesis39-wifi \
  	+safe-search \
  	+script-guard
endef

define Package/genesis39/description
Install this package to install Genesis 39 on your device.
endef

define Build/Compile
endef

define Package/genesis39/install
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_DATA) ./files/uci-defaults/* $(1)/etc/uci-defaults/
endef

$(eval $(call BuildPackage,genesis39))
