#!/bin/bash

echo "                 Monitoring battery level";
i=`cat /sys/class/power_supply/BAT0/capacity`
stat=`cat /sys/class/power_supply/BAT0/status`
echo "current capacity : $i, " "target capacity : $1"
shopt -s nocasematch; 
if [[ "$stat" = "Discharging" ]];
then
	if [ $i -le $1 ];
	then
		notify-send --icon=error "Power Critical";
		paplay /usr/share/sounds/freedesktop/stereo/suspend-error.oga;
	fi
fi
shopt -u nocasematch;
