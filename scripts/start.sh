#!/bin/sh
echo "iniciando nvr"
TZDATA=$(apk list --installed tzdata)
if [ -z "${TZDATA}" ]; then
    echo "instalando tzdata"
	apk update \
	&& apk add --no-cache \
	tzdata \
	&& rm -rf /var/cache/apk/*
	echo "tzdata concluido"
else
    echo "tzdata OK"
fi
APK_FFMPEG=$(apk list --installed ffmpeg)
if [ -z "${APK_FFMPEG}" ]; then
    echo 'instalando ffmpeg'
	apk update \
	&& apk add --no-cache \
	ffmpeg \
	&& rm -rf /var/cache/apk/*
	echo "ffmpeg concluido"
else
    echo "ffmpeg OK"
fi
APK_JQ=$(apk list --installed jq)
if [ -z "${APK_JQ}" ]; then
    echo 'instalando jq'
	apk update \
	&& apk add --no-cache \
	jq \
	&& rm -rf /var/cache/apk/*
	echo "jq concluido"
else
    echo "jq OK"
fi
APK_CURL=$(apk list --installed curl)
if [ -z "${APK_CURL}" ]; then
    echo 'instalando curl'
	apk update \
	&& apk add --no-cache \
	curl \
	&& rm -rf /var/cache/apk/*
	echo "curl concluido"
else
    echo "curl OK"
fi
CRON_CK=$(crontab -l | grep nvr)
if [ -z "${CRON_CK}" ]; then
    echo "importando cron"
	crontab /scripts/crontab
	echo "cron concluido"
else
    echo "cron OK"
fi
echo 'iniciando crond'
crond -b -l 8
echo 'iniciando fluxos nvr.sh'
/scripts/start_cams.sh
/bin/sh