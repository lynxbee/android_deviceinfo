#!/bin/bash
echo "doing su using adb root"
adb root
sleep 2
adb shell mount -o remount,rw /
adb shell mount

adb push static-bin/smemcap-static /sdcard/
adb shell "cp /sdcard/smemcap-static /"
adb shell "chmod 777 /smemcap-static"
adb shell "/smemcap-static > /sdcard/smem.tar"
adb pull /sdcard/smem.tar .


#for tree
adb push static-bin/tree /sdcard/
adb shell "cp /sdcard/tree /"
adb shell "chmod 777 /tree"
adb shell "/tree" > tree.txt

#push static busybox
adb push static-bin/busybox /sdcard/
adb shell "cp /sdcard/busybox /"
adb shell "chmod 777 /busybox"

rm -rf busybox-logs
mkdir busybox-logs
adb shell "/busybox du" > busybox-logs/busybox-du.txt
adb shell "/busybox du -sh" > busybox-logs/busybox-du-sh.txt
adb shell "/busybox pstree" > busybox-logs/busybox-pstree.txt
adb shell "/busybox printenv" > busybox-logs/busybox-printenv.txt
adb shell "/busybox top -n 1" > busybox-logs/busybox-top.txt
adb shell "/busybox df" > busybox-logs/busybox-df.txt
adb shell "/busybox ifconfig" > busybox-logs/busybox-ifconfig.txt
adb shell "/busybox free" > busybox-logs/busybox-free.txt

# preparing for bootchart

adb shell "echo 120 > /data/bootchart/start"
adb shell reboot

# finally create smem report
#smem -S smem.tar --pie=command
