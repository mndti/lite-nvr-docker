#!/bin/sh
source /scripts/conf_set.sh
for FILE in $(ls -1 ${RAW} | head -n-$FILES_KEEP_TEMP)
do
  DIR_DATE=`echo ${FILE%%.*} | cut -d "T" -f 1` 
  FILE_NEW=`echo ${FILE%%.*} | cut -d "T" -f 2`
  NEW_DIR=${ARQUIVOS}/${DIR_DATE}
  mkdir -p $NEW_DIR
  # move files
  mv ${RAW}/${FILE} ${NEW_DIR}/${FILE_NEW}.mp4  
done
