

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

define Package/genesis39
	SECTION:=genesis39
	CATEGORY:=Genesis39
	TITLE:=Genesis 39
	PKGARCH:=all
  DEPENDS:= \
  	+genesis39-keys \
  	+safe-search
endef

define Package/genesis39/description
Install this package to install Genesis 39 on your device.
endef

define Build/Compile
endef

define Package/genesis39/install
	$(INSTALL_DIR) $(1)/bin
	$(INSTALL_BIN) ./files/bin/* $(1)/bin/

	$(INSTALL_DIR) $(1)/genesis39/service/firstboot/
	$(INSTALL_BIN) ./files/genesis39/service/firstboot/* $(1)/genesis39/service/firstboot/

	$(INSTALL_DIR) $(1)/init.d
	$(INSTALL_BIN) ./files/init.d/* $(1)/init.d/

	$(INSTALL_DIR) $(1)/lib
	$(INSTALL_DATA) ./files/lib/* $(1)/lib/

	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_DATA) ./files/uci-defaults/* $(1)/etc/uci-defaults/
endef

$(eval $(call BuildPackage,genesis39))
