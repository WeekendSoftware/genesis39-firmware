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

if [ ! -d dynamic-files/$upstreamSdk ]; then
	mkdir -p dynamic-files
	pushd dynamic-files>/dev/null

	echo Downloading SDK
	wget --continue -q --show-progress $upstreamSdkDownload

	echo Extracting Image Builder
	tar -xf $upstreamSdk.tar.xz

	cd $upstreamSdk
	echo src-link genesis39 `pwd`/../../packages/>feeds.conf.default
	cp ../../../usign-genesis39/usign.genesis39.secret.key key-build

	make defconfig

	./scripts/feeds update -a
	./scripts/feeds install -a

	popd>/dev/null
fi


pushd dynamic-files/$upstreamSdk>/dev/null

make package/genesis39/compile
make package/genesis39-debug/compile
make package/index
#make
cd ..
if [ ! -d genesis39-packages ]; then
  #TODO: how to dynamically detect this path or the mips_24kc part.
  ln -s ./openwrt-sdk-${upstreamVersion}-${upstreamTarget}-generic_gcc-7.5.0_musl.Linux-x86_64/bin/packages/mips_24kc/genesis39 genesis39-packages
fi

popd>/dev/null
