#!/bin/sh
 
USER="YOUR_USER_NAME"
TOKEN="YOUR_API_TOKEN"
ID="YOUR_URL_ID"
HOST="www"
DOMAIN="example.com"
URL=${HOST}.${DOMAIN}
IP=`ping ${URL} -c 1 |awk 'NR==2 {print $4}' |awk -F ':' '{print $1}'`
#如果安装了dig也可以这样
#IP=`dig ${DOMAIN} @114.114.114.114 | awk -F "[ ]+" '/IN/{print $1}' | awk 'NR==2 {print $5}'`
echo "Ip of ${URL} is ${IP}"
LIP=`ifconfig pppoe-wan|awk -F "[: ]+" '/inet addr/{print $4}'`
echo "Local Ip is ---${LIP}---"

if [ "${LIP}" = "${IP}" ]; then
   exit
fi

echo "start ddns refresh"
if [ x"${LIP}" != x ]; then
   curl -u ''""${USER}""':'""${TOKEN}""'' 'https://api.name.com/v4/domains/'""${DOMAIN}""'/records/'""${ID}""'' -X PUT --data '{"host":"'""${HOST}""'","type":"A","answer":"'""${LIP}""'","ttl":300}'
   echo ${LIP} > /tmp/ddnsResult
fi
