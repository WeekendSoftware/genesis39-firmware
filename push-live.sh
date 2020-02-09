#!/bin/bash

IP=192.168.1.1

echo pushing latest firmware - `date`
scp -o "StrictHostKeyChecking no" dynamic-files/bin/openwrt-imagebuilder-19.07.1-ath79-generic.Linux-x86_64/openwrt-19.07.1-ath79-generic-tplink_archer-a7-v5-squashfs-sysupgrade.bin $IP:/tmp/

echo starting upgrade - `date`
ssh -o "StrictHostKeyChecking no" $IP sysupgrade -v -n /tmp/openwrt-19.07.1-ath79-generic-tplink_archer-a7-v5-squashfs-sysupgrade.bin

echo waiting for router to go down - `date`
while ping -c1 $IP &>/dev/null
  do sleep 1
done

echo waiting for router to come back up... - `date`

while ! ping -c1 $IP &>/dev/null
  do sleep 1
done

echo router is back up - `date`
ssh-keygen -R $IP>/dev/null
ssh -o "StrictHostKeyChecking no" root@$IP
