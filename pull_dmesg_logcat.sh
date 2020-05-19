#!/bin/bash
rm -rf logs
mkdir logs

adb shell dmesg > logs/dmesg.txt
# -d is for dump the log and then exit (don't block)
adb shell logcat -d > logs/logcat.txt

adb shell dumpsys > logs/dumpsys.txt
