#!/bin/bash
ADB_SHELL="adb shell"
PM_LIST_COMMAND="pm list"
PM_DUMP_COMMAND="pm dump"

rm -rf pm_list #delete old directory
mkdir pm_list
for pm_list_arg in packages permission-groups permissions instrumentation features libraries users
do
	echo "running command $ADB_SHELL $PM_LIST_COMMAND $pm_list_arg"
	$ADB_SHELL $PM_LIST_COMMAND $pm_list_arg > pm_list/$pm_list_arg.txt
done

# we have ro run dos2unix to make sure its compatible with linux to remove possible ctrl+M chars
cd pm_list
dos2unix packages.txt
cd ..

DIR=pm_dump
rm -rf $PWD/$DIR
mkdir $PWD/$DIR

filename="pm_list/packages.txt"
while read -r line
do
        pkg="$line"
        pkg=${pkg##package:}


	#workaround to remove ctrl+M from end of package name
        echo $pkg > for_dos2_unix.txt
        dos2unix for_dos2_unix.txt
        read_back=$(cat for_dos2_unix.txt)

        echo "Running adb shell pm dump on package - $read_back"
        $ADB_SHELL $PM_DUMP_COMMAND $read_back > $PWD/$DIR/$read_back.txt
	rm -rf for_dos2_unix.txt

done < "$filename"

