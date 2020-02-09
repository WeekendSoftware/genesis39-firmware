#
# Copyright (c) 2020 Gregory L. Dietsche <Gregory.Dietsche@cuw.edu>
# This is free software, licensed under the MIT License
#

include $(TOPDIR)/rules.mk

PKG_NAME:=script-guard
PKG_VERSION:=1.0.0
PKG_RELEASE:=1
PKG_LICENSE:=MIT
PKG_MAINTAINER:=Gregory L. Dietsche <Gregory.Dietsche@cuw.edu>

include $(INCLUDE_DIR)/package.mk

define Package/script-guard
	SECTION:=devel
	CATEGORY:=Development
	TITLE:=Prevent scripts from running more than once.
	PKGARCH:=all
endef

define Package/script-guard/description
script-guard prevents scripts from running more than one time.
This can be very useful for scripts in /etc/uci-defaults/
endef

define Build/Compile
endef

define Package/script-guard/install
	$(INSTALL_DIR) $(1)/lib
	$(INSTALL_DATA) ./files/lib/* $(1)/lib/
endef

$(eval $(call BuildPackage,script-guard))
