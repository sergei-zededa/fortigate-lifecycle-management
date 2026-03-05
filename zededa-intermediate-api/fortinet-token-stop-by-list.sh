#!/bin/sh

serials_file="20251125-my-list.txt"
cloud_file=cloud.txt
token_file=token.txt

startdatetime=`date +%Y%m%d-%H%M%S`
log_file=logfile-${startdatetime}.log

echo "============================="  2>&1 | tee ${log_file}
echo "${startdatetime} starting zombie stopping"  2>&1 | tee -a ${log_file}

CLOUD=`cat ${cloud_file}`
TOKEN=`cat ${token_file}`

endpoint="api/v1/firewall/serial/stop"
url="https://${CLOUD}/${endpoint}"


echo "using API ${url}"  2>&1 | tee -a ${log_file}
echo "using cloud url from ${cloud_file}"  2>&1 | tee -a ${log_file}
echo "using auth token from ${token_file}" 2>&1 | tee -a ${log_file}
count=0

while IFS= read -r sernum; do

  count=`expr $count + 1`
  #echo "------${sernum}------"  2>&1 | tee -a ${log_file}
  echo -n "-----count:"  2>&1 | tee -a ${log_file}
  printf "%06d" "${count}"  2>&1 | tee -a ${log_file}
  echo "---${sernum}-----"  2>&1 | tee -a ${log_file}
  curdatetime=`date +%Y%m%d-%H%M%S`
  echo "${curdatetime} stopping ${sernum}"  2>&1 | tee -a ${log_file}
  curl -sS --request POST "${url}" \
   --header 'accept: application/json' \
   --header 'Content-Type: application/json' \
   --header "Authorization: Bearer ${TOKEN}" \
   --data-raw '{ "serialNumber":"'${sernum}'" }'  2>&1 | tee -a ${log_file}
  echo ""  2>&1 | tee -a ${log_file}
  echo "-----------------------------------------"  2>&1 | tee -a ${log_file}

done < "$serials_file"

enddatetime=`date +%Y%m%d-%H%M%S`
echo "${enddatetime} done."  2>&1 | tee -a ${log_file}

echo "============================="  2>&1 | tee -a ${log_file}
