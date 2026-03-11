#!/bin/sh

# Don't run it directly; it invoked by activate-many-serials.py
# Instead, run the activate-many-serials.sh

/usr/bin/ansible-playbook vms_update.yaml
