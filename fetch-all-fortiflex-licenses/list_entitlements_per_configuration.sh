#!/bin/sh

#-----------------------------------------------------------
#reading variables:
VARFILE="./list_entitlements_per_configuration.config.sh"
if [ ! -f "$VARFILE" ]; then
    echo "Config file $VARFILE missing. Exiting right away."
    exit 1
fi
echo "Reading variables from ${VARFILE}"
. ${VARFILE}
#-----------------------------------------------------------


export FORTIFLEX_API_PASSWORD
export FORTIFLEX_PROGRAM_SN
export FORTIFLEX_API_USER

/usr/bin/python3 ./list_entitlements_per_configuration.py --id 4818

