#
# Copyright (c) 2020 Gregory L. Dietsche <Gregory.Dietsche@cuw.edu>
# This is free software, licensed under the MIT License
#

include $(TOPDIR)/rules.mk

PKG_NAME:=genesis39-wifi-postfix-mac
PKG_VERSION:=1.0.0
PKG_RELEASE:=5
PKG_LICENSE:=MIT
PKG_MAINTAINER:=Gregory L. Dietsche <Gregory.Dietsche@cuw.edu>

include $(INCLUDE_DIR)/package.mk

define Package/genesis39-wifi-postfix-mac
	SECTION:=genesis39
	CATEGORY:=Genesis39
	TITLE:=Genesis 39 WiFi Postfix Mac
	PKGARCH:=all
  DEPENDS:= \
  	+genesis39-scripts \
  	+script-guard
endef

define Package/genesis39-wifi-postfix-mac/description
Add the last 4 digits of the mac address to the wifi network name(s).
endef

define Build/Compile
endef

define Package/genesis39-wifi-postfix-mac/install
	$(INSTALL_DIR) $(1)/genesis39/service/firstboot/
	$(INSTALL_BIN) ./files/genesis39/service/firstboot/* $(1)/genesis39/service/firstboot/

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/init.d/* $(1)/etc/init.d/

	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_DATA) ./files/uci-defaults/* $(1)/etc/uci-defaults/
endef

$(eval $(call BuildPackage,genesis39-wifi-postfix-mac))
