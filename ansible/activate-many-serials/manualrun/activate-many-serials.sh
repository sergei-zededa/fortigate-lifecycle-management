#!/bin/sh

# specify correct serialsfile in activate-many-serials.py, and run this!


startdatetime=`date +%Y%m%d-%H%M%S`

python3 activate-many-serials-1.py 2>&1 | tee -a activate-many-serials-${startdatetime}.log
