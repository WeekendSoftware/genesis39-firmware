#!/bin/sh
. /etc/openwrt_release
. /etc/genesis39_release

# DISTRIB_TARGET='ar71xx/generic'

FILE=archer-c7-sysupgrade.bin
ROOT_URL=${GENESIS39_WEBSITE}/static/release/0/$DISTRIB_TARGET
IMG_URL=${ROOT_URL}/$FILE
SIG_URL=${ROOT_URL}/$FILE.sig

cd /tmp/
wget -q $IMG_URL $SIG_URL

usign -q -V -m $FILE -P /genesis39/keys/
_ret=$?
if [ "$_ret" -eq "0" ]; then
  sysupgrade $FILE
fi
