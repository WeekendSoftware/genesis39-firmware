#
# Copyright (c) 2020 Gregory L. Dietsche <Gregory.Dietsche@cuw.edu>
# This is free software, licensed under the MIT License
#

include $(TOPDIR)/rules.mk

PKG_NAME:=genesis39-scripts
PKG_VERSION:=1.0.0
PKG_RELEASE:=1
PKG_LICENSE:=MIT
PKG_MAINTAINER:=Gregory L. Dietsche <Gregory.Dietsche@cuw.edu>

include $(INCLUDE_DIR)/package.mk

define Package/genesis39-scripts
	SECTION:=genesis39
	CATEGORY:=Genesis39
	TITLE:=Genesis 39 Supporting Scripts Package
	PKGARCH:=all
endef

define Package/genesis39-scripts/description
Scripts for /lib/ that are used across Genesis39 Packages
endef

define Build/Compile
endef

define Package/genesis39-scripts/install
	$(INSTALL_DIR) $(1)/lib
	$(INSTALL_DATA) ./files/lib/* $(1)/lib/
endef

$(eval $(call BuildPackage,genesis39-scripts))
