#!/bin/bash
# Copyright (C) 2020 Gregory L. Dietsche
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License version 2 as published by the
# Free Software Foundation. This program is distributed in the hope that it
# will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty
# of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# You should have received a copy of the GNU General Public License along with
# this program. If not, see http://www.gnu.org/licenses/.

. settings.sh

#The OpenWrt image builder wants this umask set
umask 022

GENESIS39_INFO_FILE=filesystem/etc/genesis39_release
GENESIS39_RELEASE="${upstreamVersion}.G$(cat release-id)"
echo "GENESIS39_BUILD_TIMESTAMP='$(date)'">$GENESIS39_INFO_FILE
echo "GENESIS39_GIT_HASH='$(git log -1 --format="%H")'">>$GENESIS39_INFO_FILE
echo "GENESIS39_RELEASE=${GENESIS39_RELEASE}">>$GENESIS39_INFO_FILE
echo "GENESIS39_WEBSITE='https://www.genesis39.org'">>$GENESIS39_INFO_FILE

if [ ! -d dynamic-files/$upstreamBuilder ]; then
	mkdir -p dynamic-files
	pushd dynamic-files>/dev/null

	echo Downloading Image Builder
	wget --continue -q --show-progress $upstreamDownload

	echo Extracting Image Builder
	tar -xf $upstreamBuilder.tar.xz

	echo src genesis39 file:../genesis39-packages>>${upstreamBuilder}/repositories.conf
	popd>/dev/null
fi

#git doesn't save permissions, so explicitly set what we need here
#this is specifically needed so that dnsmasq can read the hosts from /genesis39/hosts
chmod -R ugo+rX filesystem/genesis39

#the BIN_DIR variable seems to do better when it has a fully qualified path.
mkdir -p dynamic-files/bin/$upstreamBuilder
rm  dynamic-files/bin/$upstreamBuilder/*
binfolder=`echo $(pwd)/dynamic-files/bin/$upstreamBuilder`

pushd dynamic-files/$upstreamBuilder>/dev/null

make image PROFILE="$upstreamProfile" PACKAGES="luci luci-app-sqm luci-app-ddns safe-search family-dns genesis39 genesis39-debug" FILES="../../filesystem/" BIN_DIR="$binfolder"
#make image PROFILE="$upstreamProfile" PACKAGES="luci luci-app-sqm luci-app-ddns safe-search family-dns" FILES="../../filesystem/" BIN_DIR="$binfolder"

popd>/dev/null
echo Genesis 39: Build Complete

export genesis39_publish_packages=/data/ace/greg/tftp/g39/packages
export genesis39_publish_firmware=/data/ace/greg/tftp/g39/firmware
export genesis39_secret_key=/home/greg/genesis39/usign-genesis39/usign.genesis39.secret.key

../usign/usign  -S -m ${genesis39_publish_firmware}/* -s ${genesis39_secret_key}
chmod ugo+r dynamic-files/bin/${upstreamFaction}-imagebuilder-${upstreamVersion}-${upstreamTarget}-generic.Linux-x86_64/
rsync -avz dynamic-files/bin/${upstreamFaction}-imagebuilder-${upstreamVersion}-${upstreamTarget}-generic.Linux-x86_64/${upstreamFaction}-${upstreamVersion}-${upstreamTarget}-generic-${upstreamProfile}-squashfs-sysupgrade.bin ${genesis39_publish_firmware}/
