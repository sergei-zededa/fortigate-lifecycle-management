#!/bin/sh

# this script makes a json file

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


python3 ./list_entitlements_per_configuration_json.py --id 4818

# | head -4 > list_entitlements_per_configuration_json.json

