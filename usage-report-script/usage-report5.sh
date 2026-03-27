#!/bin/sh

# this script is started from cron

echo "============================"

#-----------------------------------------------------------
#reading variables:
VARFILE="./usage-report5-config.sh"
if [ ! -f "$VARFILE" ]; then
    echo "Config file $VARFILE missing. Exiting right away."
    exit 1
fi
echo "Reading variables from ${VARFILE}"
. ${VARFILE}
#-----------------------------------------------------------


cd ${WORKFOLDER}

CURDATE=`date +%Y%m%d`
DOWTODAY=`date +%a`
curdatetime=`date`
echo ${curdatetime}


/usr/bin/sh list_entitlements_per_configuration_new.sh > ${licenseslist}

actualsize=$(wc -c <"$licenseslist")
if [ ${actualsize} -le ${minimumsize} ]; then
  subj="${licenseslist} file size is ${actualsize} bytes, which is under ${minimumsize}"
  message="${licenseslist} file size is ${actualsize} bytes, which is under ${minimumsize}; exiting"
  echo ${message}
  uuid=`uuidgen`
  echo -n "/usr/local/bin/mailsend-go -smtp ${SMTPSERVER} -port ${SMTPPORT} -t ${BCC} -f ${FROM} -fname \"${ROBOTNAME}\" -sub \"${subj}\" body -msg \"${message}\" auth -user ${SMTPUSER} -pass ${SMTPPASS} header -name Message-ID -value \"<${uuid}@${MESSIDDOMAIN}\" -log mailsend.log" > mailcmd.sh
  /bin/sh mailcmd.sh
  rm -f mailcmd.sh
  exit 100
else
  echo "File ${licenseslist} is big enough: ${actualsize} bytes"
fi

totallicenses=`cat ${licenseslist} | wc -l`
activelicenses=`cat ${licenseslist} | grep '"ACTIVE"' | wc -l`
stoppedlicenses=`cat ${licenseslist} | grep '"STOPPED"' | wc -l`

cp ${licenseslist} licenseslist-${CURDATE}.txt
zip -9 licenseslist-${CURDATE}.zip licenseslist-${CURDATE}.txt
mv -f licenseslist-${CURDATE}.zip ${licenseslistfolder}/
rm -f licenseslist-${CURDATE}.txt


echo "FortiFlex licenses counts by ${curdatetime}" > ${reporttoday}
echo "Total licenses: ${totallicenses}"           >> ${reporttoday}
echo "Activated licenses: ${activelicenses}"      >> ${reporttoday}
echo "Stopped licenses: ${stoppedlicenses}"       >> ${reporttoday}

cat ${reporttoday}


# if today is Friday, sending report via email:
if [ ${DOWTODAY} = ${DOWEMAILSEND} ]
then
  subj="Fortiflex licenses deployment report, ${curdatetime}:  ${activelicenses}/${totallicenses}"
  message="Hi!\n"`cat ${reporttoday}`
  uuid=`uuidgen`
  echo -n "/usr/local/bin/mailsend-go -smtp ${SMTPSERVER} -port ${SMTPPORT} -t ${TO} -cc ${CC} -bcc ${BCC} -f ${FROM} -fname \"${ROBOTNAME}\" -sub \"${subj}\" body -msg \"${message}\" auth -user ${SMTPUSER} -pass ${SMTPPASS} header -name Message-ID -value \"<${uuid}@${MESSIDDOMAIN}\" -log mailsend.log" > mailcmd.sh
  /bin/sh mailcmd.sh
  rm -f mailcmd.sh
fi


date
echo "============================"

