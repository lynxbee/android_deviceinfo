#!/bin/bash
ADB_SHELL="adb shell"

for adb_command in "ps" "du" "du -h" "top -n 1" "mount" "free" "df" \
	"getprop"  "date" "getenforce" "groups" "global" "hostname" \
	"ifconfig" "id" "lsmod" "lsof" "lsusb" \
	"netstat -r" "netstat -n" "printenv" "pstree" "route" "uname" \
	"vmstat" "whoami"
do
	variable=${adb_command//[[:space:]]/}
	echo "running command $ADB_SHELL $adb_command and saving to file logs/$variable.txt"
	$ADB_SHELL $adb_command > logs/$variable.txt
done
