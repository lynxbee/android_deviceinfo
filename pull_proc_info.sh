#!/bin/bash
ADB_SHELL="adb shell"

PROC_DIR=proc_info
rm -rf $PROC_DIR
mkdir $PROC_DIR

prepare_proc_dirs() {
	for dir_name in asound "bus/input" device-tree driver fs ion irq net scsi sys sysvipc tty uid_stat
	do
		mkdir -p $PROC_DIR/$dir_name
	done
}

prepare_proc_dirs

for proc_info in "asound/cards" buddyinfo "bus/input/devices" cgroups cmdline consoles cpuinfo \
			crypto devices dia-num-remotes diskstats execdomains fb filesystems \
			inand interrupts iomem "ion/vmalloc_ion" ioports kallsyms key-users \
			loadavg locks meminfo misc modules mounts mtd ntd pagetypeinfo partitions \
			sched_debug schedstat "scsi/scsi" "scsi/device_info" slabinfo softirqs \
			stat swaps timer_list timer_stats "tty/drivers" uptime version vmallocinfo \
			vmstat wakelocks zoneinfo 
do
	echo "Running adb command $ADB_SHELL cat /proc/$proc_info"
	$ADB_SHELL cat /proc/$proc_info > $PROC_DIR/$proc_info.txt

done

for only_ls in device-tree driver fs irq net sys sysvipc
do
	$ADB_SHELL ls /proc/$only_ls > $PROC_DIR/$only_ls/$only_ls.txt
done
