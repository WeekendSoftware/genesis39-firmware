

#
# Copyright (c) 2018 Gregory L. Dietsche <Gregory.Dietsche@cuw.edu>
# This is free software, licensed under the MIT License
#

include $(TOPDIR)/rules.mk

PKG_NAME:=genesis39-auto-upgrade
PKG_VERSION:=1.0.0
PKG_RELEASE:=7
PKG_LICENSE:=MIT
PKG_MAINTAINER:=Gregory L. Dietsche <Gregory.Dietsche@cuw.edu>

include $(INCLUDE_DIR)/package.mk

define Package/genesis39-auto-upgrade
	SECTION:=genesis39
	CATEGORY:=Genesis39
	TITLE:=Genesis 39 Automatic Upgrades
	PKGARCH:=all
  DEPENDS:=genesis39-keys
endef

define Package/genesis39-auto-upgrade/description
Automatic Genesis39 Project Upgrades
endef

define Build/Compile
endef

define Package/genesis39-auto-upgrade/install
	$(INSTALL_DIR) $(1)/sbin
	$(INSTALL_BIN) ./files/genesis39-upgrade $(1)/sbin/
endef

define Package/genesis39-auto-upgrade/postinst
#!/bin/sh
if [ -z "$${IPGK_INSTROOT}" ]; then
  (crontab -l ; echo "0 3 * * 1 /sbin/genesis39-upgrade") | sort | uniq | crontab -
  /etc/init.d/cron enable
  /etc/init.d/cron start
fi
exit 0
endef

define Package/genesis39-auto-upgrade/prerm
#!/bin/sh
if [ -z "$${IPGK_INSTROOT}" ]; then
  crontab -l | grep -v "0 3 \* \* 1 /sbin/genesis39-upgrade" | sort | uniq | crontab -
fi
exit 0
endef

$(eval $(call BuildPackage,genesis39-auto-upgrade))
