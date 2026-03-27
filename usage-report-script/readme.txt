
usage-report


The script usage-report5.sh invokes the script list_entitlements_per_configuration_new.sh to fetch curent list of Fortiflex licenses
and count s amunt of activated an stopped licenses.
Result is written ti the logfile and is sent via email according to values in usage-report5-config.sh

Possible string to daily run for cron:
00 18 * * *  root  cd /fgt/automat/usage-report-script && /fgt/automat/usage-report-script/usage-report5.sh 2>&1 | tee -a /fgt/automat/usage-report-script/usage-report.sh.log


Requirements:

apt install zip
pip3 install requests

