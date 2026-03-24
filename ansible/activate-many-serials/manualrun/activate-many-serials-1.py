#!/usr/bin/python3

# check if serialsfile correct!

import os
import sys
import time
import csv
from datetime import datetime


serialsfile = "serials.txt"

tplfile     = "vms_update.yaml.tpl"
ymlfile     = "vms_update.yaml"
myplaybook  = "run_playbook.sh"
ColNum      = 0
pauselen    = 0


current_datetime = datetime.now()
print("==========================")
print(current_datetime)
print(f"Activating several serials from {serialsfile}")
print("----")


with open(serialsfile, "r") as serials:
    reader = csv.reader(serials)

    totalcount=0
    for row in reader:
        current_datetime = datetime.now()
        print(current_datetime)

        totalcount=totalcount+1
        serial=row[ColNum]

        with open(tplfile, "r") as f:
            content = f.read()
        content = content.replace("fortigateserial", serial)
        with open(ymlfile, "w") as f:
            f.write(content)

        oscmd = f"bash {myplaybook}"

        print(f"count={totalcount}, serial={serial}")
        os.system(oscmd)

        #time.sleep(pauselen)

print("----")
print("Done.")
current_datetime = datetime.now()
print(current_datetime)
print("==========================")
