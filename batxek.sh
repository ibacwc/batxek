#! /bin/bash

stat() {
	return $(acpi | awk '{print $3}' | sed -e 's/,//g')
} 
bat() {
	return $(acpi | awk '{print $4}' | sed -e 's/%,//g')
}

PERSISTENT=$1
NOTIF_TIME=10000
LSTAT=stat
NOTIFIED=0
if [[ $PERSISTENT -eq 1 ]]; then
	NOTIFY_TIME=1000000
fi

while true
do
	CSTAT=stat
	BAT=bat
	if [[ $BAT -le 15 ]] && [[ $CSTAT == "Discharging" ]]; then
		if [[ $NOTIFIED -eq 0 ]]; then
			notify-send -t $NOTIF_TIME -u critical "Battery low! Plug in your charger!"
			NOTIFIED=1
		fi
	fi
	if [[ $BAT -ge 95 ]] && [[ $CSTAT == "Charging" ]]; then
		if [[ $NOTIFIED -eq 0 ]]; then
			notify-send -t $NOTIF_TIME -u low "Battery full! Unplug your charger."
			NOTIFIED=1
		fi
	fi
	if [[ $NOTIFIED -eq 1 ]] && [[ $LSTAT != $CSTAT ]]; then
		NOTIFIED=0
	fi
	LSTAT=$CSTAT
	sleep 30s
	
done

