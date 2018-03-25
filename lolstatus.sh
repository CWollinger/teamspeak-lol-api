#!/bin/bash
### Version: 1.0
### Author: Christian Wollinger
############### Description ###############
LOL_USER=`grep LOL_USER env.txt`
LOL_PORT=`grep LOL_PORT env.txt`
LOL_PASSWORD=`grep LOL_PASSWORD env.txt`
LOL_NICK=`grep LOL_NICK env.txt`
LOL_IP=`grep LOL_IP env.txt`
eval $LOL_USER
eval $LOL_PORT
eval $LOL_PASSWORD
eval $LOL_NICK
eval $LOL_IP

> lolstatus.tmp
curl -s http://status.leagueoflegends.com/shards/euw | jq '.' | sed -n -e '/Game/{p;n;n;p;}' | sed 's/"//g' | sed 's/,/[\/color]/g' | awk '{print $2}' | sed ':a;N;$!ba;s/\n/ -> [color=green]/g' | sed 's/Game/[color=blue]Game/g' >> lolstatus.tmp
curl -s http://status.leagueoflegends.com/shards/euw | jq '.' | sed -n -e '/Store/{p;n;n;p;}' | sed 's/"//g' | sed 's/,/[\/color]/g' | awk '{print $2}' | sed ':a;N;$!ba;s/\n/ -> [color=green]/g' | sed 's/Store/[color=blue]Store/g' >> lolstatus.tmp
curl -s http://status.leagueoflegends.com/shards/euw | jq '.' | sed -n -e '/Website/{p;n;n;p;}' | sed 's/"//g' | sed 's/,/[\/color]/g' | awk '{print $2}' | sed ':a;N;$!ba;s/\n/ -> [color=green]/g' | sed 's/Website/[color=blue]Website/g' >> lolstatus.tmp
curl -s http://status.leagueoflegends.com/shards/euw | jq '.' | sed -n -e '/Client/{p;n;n;p;}' | sed 's/"//g' | sed 's/,/[\/color]/g' | awk '{print $2}' | sed ':a;N;$!ba;s/\n/ -> [color=green]/g' | sed 's/Client/[color=blue]Client/g' >> lolstatus.tmp
curl -s http://status.leagueoflegends.com/shards/euw | jq '.' | sed -n -e '/updates/{n;n;n;n;p;}' | sed 's/"//g' | sed 's/,//g' | sed 's/content: //g' | sed 's/              //g' >> lolstatus.tmp

CHECKSUM=`sha1sum lolstatus.tmp`;
CHECKSUM_DATEI=`cat lolstatus.chk`;
if [[ $CHECKSUM != $CHECKSUM_DATEI ]]; then
        php lolstatus.php $LOL_IP $LOL_PORT $LOL_USER $LOL_PASSWORD $LOL_NICK
        sha1sum lolstatus.tmp > lolstatus.chk
fi
