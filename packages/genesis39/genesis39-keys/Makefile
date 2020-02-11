#
# Copyright (c) 2018 Gregory L. Dietsche <Gregory.Dietsche@cuw.edu>
# This is free software, licensed under the MIT License
#

include $(TOPDIR)/rules.mk

PKG_NAME:=genesis39-keys
PKG_VERSION:=1.0.0
PKG_RELEASE:=1
PKG_LICENSE:=MIT
PKG_MAINTAINER:=Gregory L. Dietsche <Gregory.Dietsche@cuw.edu>

include $(INCLUDE_DIR)/package.mk

define Package/genesis39-keys
	SECTION:=genesis39
	CATEGORY:=Genesis39
	TITLE:=Genesis39 Keys
	PKGARCH:=all
endef

define Package/genesis39-keys/description
Genesis39 project opkg keys
endef

define Build/Compile
endef

define Package/genesis39-keys/install
	$(INSTALL_DIR) $(1)/etc/opkg/keys
	$(INSTALL_DATA) ./files/keys/* $(1)/etc/opkg/keys/
endef

$(eval $(call BuildPackage,genesis39-keys))
