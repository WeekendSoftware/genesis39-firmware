#!/bin/bash
# Copyright (C) 2017 Gregory L. Dietsche
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License version 2 as published by the
# Free Software Foundation. This program is distributed in the hope that it
# will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty
# of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# You should have received a copy of the GNU General Public License along with
# this program. If not, see http://www.gnu.org/licenses/.

builder=lede-imagebuilder-17.01.1-ar71xx-generic.Linux-x86_64

#The LEDE image builder wants this umask set
umask 022

#the BIN_DIR variable seems to do better when it has a fully qualified path.
mkdir -p dynamic-files/bin
rm  dynamic-files/bin/*
binfolder=`echo $(pwd)/dynamic-files/bin`

pushd dynamic-files/$builder>/dev/null
make image PROFILE="archer-c7-v2" PACKAGES="luci luci-app-sqm luci-app-ddns" FILES="../../filesystem/" BIN_DIR="$binfolder"
#make clean
popd>/dev/null
echo Genesis 39: Build Complete
