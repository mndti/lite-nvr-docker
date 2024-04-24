#!/bin/sh
HA_STATUS=$(echo "${CONFIG}" | jq -r '.ha_status')
HA_URL=$(echo "${CONFIG}" | jq -r '.ha_url')
HA_TOKEN=$(echo "${CONFIG}" | jq -r '.ha_token')

send_to_ha() {
  local sensor_name=$1
  local value=$2
  local friendly_name=$3
  local icon=$4
  local unique_id=$1
  
  local url="${HA_URL}/api/states/${sensor_name}"
  local payload="{\"state\":\"${value}\",\"attributes\":{\"friendly_name\":\"${friendly_name}\",\"icon\":\"${icon}\",\"unique_id\":\"${unique_id}\",\"device_class\":\"problem\"}}"
  curl -k -X POST -H "Authorization: Bearer ${HA_TOKEN}" -H 'Content-type: application/json' --data "${payload}" "${url}"
}

