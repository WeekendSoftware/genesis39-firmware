#
# Copyright (c) 2020 Gregory L. Dietsche <Gregory.Dietsche@cuw.edu>
# This is free software, licensed under the MIT License
#

include $(TOPDIR)/rules.mk

PKG_NAME:=safe-dns
PKG_VERSION:=1.0.0
PKG_RELEASE:=1
PKG_LICENSE:=MIT
PKG_MAINTAINER:=Gregory L. Dietsche <Gregory.Dietsche@cuw.edu>

include $(INCLUDE_DIR)/package.mk

define Package/safe-dns
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Safe DNS
	PKGARCH:=all
endef

define Package/safe-dns/description
This package configures dnsmasq to block adult websites on your router.
The default settings are designed to be appropriate for most businesses and
families.
endef

define Package/safe-dns/conffiles
/etc/config/safe-dns
endef

define Build/Compile
endef

define Package/safe-dns/install
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_DATA) ./files/uci-defaults/* $(1)/etc/uci-defaults/

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/safe-dns.conf $(1)/etc/config/safe-dns

	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) ./files/safe-dns-update $(1)/usr/sbin/safe-dns-update
endef

define Package/safe-dns/prerm
#!/bin/sh
if [ -z "$${IPGK_INSTROOT}" ]; then
  uci set network.wan.peerdns='1'
  uci set network.wan6.peerdns='1'
  uci delete dhcp.@dnsmasq[0].server
	uci commit dhcp
	uci commit network
	/etc/init.d/network reload
	/etc/init.d/dnsmasq reload
fi
exit 0
endef


$(eval $(call BuildPackage,safe-dns))
