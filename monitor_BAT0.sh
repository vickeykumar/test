#!/bin/bash

echo "                 Monitoring battery level";
i=`cat /sys/class/power_supply/BAT0/capacity`
stat=`cat /sys/class/power_supply/BAT0/status`
retry=1
echo "current capacity : $i, " "target capacity : $1"
shopt -s nocasematch;
echo "status: " $stat
if [[ "$stat" = "Discharging" ]];
then
	if [ $i -le $1 ];
	then
		notify-send --icon=error "Power Critical";
		paplay /usr/share/sounds/freedesktop/stereo/suspend-error.oga;
		retry=$(( $retry+1 ));
		if [ $retry -ge 10 ];
		then
			echo "suspending...";
			systemctl suspend;
		fi
	fi
fi
shopt -u nocasematch;
