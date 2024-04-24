#!/bin/sh
source /scripts/conf_set.sh
source /scripts/ha_status.sh
for row in $(echo "${CONFIG}" | jq -r '.cams[] | @base64'); do
    _jq() {
		echo ${row} | base64 -d | jq -r ${1}
    }
	NAME=$(_jq '.name')
	LINK=$(_jq '.link')
	PID_FF=$(pgrep -f $NAME)
	if [ -z "$PID_FF" ]; then
	  if ($HA_STATUS); then
		send_to_ha "binary_sensor.${NAME_HA}" "off" "${NAME_HA_F}" "${HA_ICON}"	
	  else
		echo "$DATE - INICIADO" >> $LOG$NAME.txt
	  fi	  
	  export LINK SEG_TIME RAW NAME
	  /scripts/ffmpeg.sh > /dev/null 2>&1 &
	else
	  if ($HA_STATUS); then
		send_to_ha "binary_sensor.${NAME_HA}" "off" "${NAME_HA_F}" "${HA_ICON}"	
	  else
		echo "$DATE - ATIVO" >> $LOG$NAME.txt
	  fi	  
	fi
done
