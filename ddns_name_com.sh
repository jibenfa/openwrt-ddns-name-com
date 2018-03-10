#!/bin/sh
 
USER="YOUR_USER_NAME"
TOKEN="YOUR_API_TOKEN"
ID="YOUR_URL_ID"
HOST="www"
DOMAIN="example.com"
URL=${HOST}.${DOMAIN}
IP=`ping ${URL} -c 1 |awk 'NR==2 {print $4}' |awk -F ':' '{print $1}'`
echo "Ip of ${URL} is ${IP}"
 
if [ -f /tmp/ddnsResult ]; then
   OLD_IP=`cat /tmp/ddnsResult | awk '{ print $1}'`
   if [ "${OLD_IP}" = "${IP}" ]; then
      exit
   fi
fi
 
echo "start ddns refresh"
IP=`ifconfig pppoe-wan|awk -F "[: ]+" '/inet addr/{print $4}'`
curl -u ''""${USER}""':'""${TOKEN}""'' 'https://api.name.com/v4/domains/'""${DOMAIN}""'/records/'""${ID}""'' -X PUT --data '{"host":"'""${HOST}""'","type":"A","answer":"'""${IP}""'","ttl":300}'
echo ${IP} > /tmp/ddnsResult