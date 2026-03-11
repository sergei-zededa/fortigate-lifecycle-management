#!/usr/bin/python3

import os
import sys
import time
from datetime import datetime

descrbase = "20250620 - Ansible - XYZ - 30 items; batch"


batches = 167
pauselen = 2
tplfile = "create_vm.yaml.tpl"
ymlfile = "create_vm.yaml"
myplaybook = "run_playbook.sh"

current_datetime = datetime.now()
print("==========================")
print(current_datetime)

for i in range(0, batches):

    curbatch= i+1
    mydescr = f"{descrbase} {curbatch}"

    with open(tplfile, "r") as f:
        content = f.read()

    content = content.replace("mydescriptiontemplate", mydescr)

    with open(ymlfile, "w") as f:
        f.write(content)

    oscmd = f"bash {myplaybook}"

    print(f"batch {curbatch}: {oscmd}") 
    os.system(oscmd)

    time.sleep(pauselen)

current_datetime = datetime.now()
print(current_datetime)
print("==========================")
