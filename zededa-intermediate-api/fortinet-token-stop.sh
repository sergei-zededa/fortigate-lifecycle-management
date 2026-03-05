#!/bin/sh

#POST:

sernum="FGVMMLTM00000000"

cloud_file=cloud.txt
token_file=token.txt

CLOUD=`cat ${cloud_file}`
TOKEN=`cat ${token_file}`

endpoint="api/v1/firewall/serial/stop"


curl --request POST "https://${CLOUD}/${endpoint}" \
 --header 'accept: application/json' \
 --header 'Content-Type: application/json' \
 --header "Authorization: Bearer ${TOKEN}" \
 --data-raw '{ "serialNumber":"'${sernum}'" }'
