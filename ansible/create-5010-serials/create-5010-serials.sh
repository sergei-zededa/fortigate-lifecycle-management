#!/bin/sh


# edit 'descrbase' in create-5010-serials.py, and run this create-5010-serials.sh

python3 create-5010-serials.py 2>&1 | tee -a create-5010-serials.log
