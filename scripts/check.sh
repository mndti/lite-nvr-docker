#!/bin/sh
source /scripts/conf_set.sh
source /scripts/ha_status.sh
for row in $(echo "${CONFIG}" | jq -r '.cams[] | @base64'); do
    _jq() {
		echo ${row} | base64 -d | jq -r ${1}
    }
	NAME=$(_jq '.name')
	LINK=$(_jq '.link')
    NAME_HA=$(_jq '.name_ha')
	NAME_HA_F=$(_jq '.name_ha_friendly')
    HA_ICON=$(_jq '.ha_icon')
	
	if find $RAW -name "*$NAME.mkv" -type f -mmin -$LAST_MOD_TIME | read; then
		if ($HA_STATUS); then
		  send_to_ha "binary_sensor.${NAME_HA}" "off" "${NAME_HA_F}" "${HA_ICON}"	
		else
		  echo "$DATE - OK" >> $LOG$NAME.txt
		fi
	else
	  PID_FF=$(pgrep -f $NAME)
	  kill -9 $PID_FF
	  export LINK SEG_TIME RAW NAME
	  /scripts/ffmpeg.sh > /dev/null 2>&1 &
	  if ($HA_STATUS); then
		send_to_ha "binary_sensor.${NAME_HA}" "on" "${NAME_HA_F}" "${HA_ICON}"	
	   else
	     echo "$DATE - ERRO - REINICIADO" >> $LOG$NAME.txt
	   fi
	fi
done
