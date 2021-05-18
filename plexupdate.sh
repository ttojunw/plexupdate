#!/bin/bash

# Script to automagically update Plex Media Server on Synology NAS
#
# 반드시 root 권한으로 실행해야 합니다.
#
# @author @martinorob https://github.com/martinorob
# https://github.com/martinorob/plexupdate/

#!/bin/bash
mkdir -p /tmp/plexautoupdatetmpdir/ > /dev/null 2>&1
token=$(cat /volume1/Plex/Library/Application\ Support/Plex\ Media\ Server/Preferences.xml | grep -oP 'PlexOnlineToken="\K[^"]+')
url=$(echo "https://plex.tv/api/downloads/5.json?channel=plexpass&X-Plex-Token=$token")
jq=$(curl -s ${url})
newversion=$(echo $jq | jq -r .nas.Synology.version)
echo 최신 버전: $newversion
curversion=$(synopkg version "Plex Media Server")
echo 현재 사용중인 버전: $curversion
if [ "$newversion" != "$curversion" ]
then
echo 최신 버전을 발견했습니다.
/usr/syno/bin/synonotify PKGHasUpgrade '{"[%HOSTNAME%]": $(hostname), "[%OSNAME%]": "Synology", "[%PKG_HAS_UPDATE%]": "Plex", "[%COMPANY_NAME%]": "Synology"}'
CPU=$(uname -m)
url=$(echo "${jq}" | jq -r '.nas.Synology.releases[] | select(.build=="linux-'"${CPU}"'") | .url')
/bin/wget $url -P /tmp/plexautoupdatetmpdir/
/usr/syno/bin/synopkg install /tmp/plexautoupdatetmpdir/*.spk
sleep 30
/usr/syno/bin/synopkg start "Plex Media Server"
rm -rf /tmp/plexautoupdatetmpdir/*
else
echo 최신 버전입니다.
fi
exit
