#!/bin/bash
# Copyright (C) 2017 Gregory L. Dietsche
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License version 2 as published by the
# Free Software Foundation. This program is distributed in the hope that it
# will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty
# of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# You should have received a copy of the GNU General Public License along with
# this program. If not, see http://www.gnu.org/licenses/.

. settings.sh

#The LEDE image builder wants this umask set
umask 022

#git doesn't save permissions, so explicitly set what we need here
#this is specifically needed so that dnsmasq can read the hosts from /genesis39/hosts
chmod -R ugo+rX filesystem/genesis39

if [ ! -f dynamic-files/$ledeBuilder.tar.xz  ]; then
	mkdir -p dynamic-files
	pushd dynamic-files>/dev/null

	echo Download Image Builder
	wget --continue -q --show-progress $ledeDownload

	echo Extracting Image Builder
	tar -xf $ledeBuilder.tar.xz
	popd>/dev/null
fi

#the BIN_DIR variable seems to do better when it has a fully qualified path.
mkdir -p dynamic-files/bin/$ledeBuilder
rm  dynamic-files/bin/$ledeBuilder/*
binfolder=`echo $(pwd)/dynamic-files/bin/$ledeBuilder`

pushd dynamic-files/$ledeBuilder>/dev/null
make image  PROFILE="$ledeProfile" PACKAGES="luci luci-app-sqm luci-app-ddns dnscrypt-proxy -wpad-mini wpad hostapd-utils" FILES="../../filesystem/" BIN_DIR="$binfolder"
#make clean
popd>/dev/null
echo Genesis 39: Build Complete
