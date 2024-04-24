#!/bin/sh
CONFIG=`cat /scripts/nvr.conf.json`
SEG_TIME=$(echo "${CONFIG}" | jq -r '.seg_time')
DAYS_KEEP=$(echo "${CONFIG}" | jq -r '.days_keep')
LAST_MOD_TIME=$(echo "${CONFIG}" | jq -r '.last_mod_minutes')
FILES_KEEP_TEMP=$(echo "${CONFIG}" | jq -r '.files_keep_temp')
RAW=$(echo "${CONFIG}" | jq -r '.path_temp')
ARQUIVOS=$(echo "${CONFIG}" | jq -r '.path_completed')
PATH_LOG=$(echo "${CONFIG}" | jq -r '.path_log')
LOG=$PATH_LOG$(date +"%Y-%m-%d")
DATE=$(date +"%H:%M:%S")
if [ ! -d  $RAW ]; then
  echo "criando diretorio: $RAW"
  mkdir -p $RAW
fi
if [ ! -d  $PATH_LOG ]; then
  echo "criando diretorio: $PATH_LOG"
  mkdir -p $PATH_LOG
fi
if [ ! -d  $ARQUIVOS ]; then
  echo "criando diretorio: $ARQUIVOS"
  mkdir -p $ARQUIVOS
fi
