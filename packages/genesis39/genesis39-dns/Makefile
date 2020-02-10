#
# Copyright (c) 2020 Gregory L. Dietsche <Gregory.Dietsche@cuw.edu>
# This is free software, licensed under the MIT License
#

include $(TOPDIR)/rules.mk

PKG_NAME:=genesis39-dns
PKG_VERSION:=1.0.0
PKG_RELEASE:=5
PKG_LICENSE:=MIT
PKG_MAINTAINER:=Gregory L. Dietsche <Gregory.Dietsche@cuw.edu>

include $(INCLUDE_DIR)/package.mk

define Package/genesis39-dns
	SECTION:=genesis39
	CATEGORY:=Genesis39 DNS Filtering
	TITLE:=Genesis 39
	PKGARCH:=all
  DEPENDS:= \
  	+script-guard
endef

define Package/genesis39-dns/description
Configure DNS to filter requests for the Genesis39 Project.
endef

define Build/Compile
endef

define Package/genesis39-dns/install
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_DATA) ./files/uci-defaults/* $(1)/etc/uci-defaults/
endef

$(eval $(call BuildPackage,genesis39-dns))
