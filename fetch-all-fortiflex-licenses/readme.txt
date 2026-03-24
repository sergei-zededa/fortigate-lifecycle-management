
There are two scripts to fetch all the fortiflex licenses for a particular configuration number:

list_entitlements_per_configuration.sh - fetches as CSV
list_entitlements_per_configuration_json.sh - fetches as json

both scripts need variables defined in list_entitlements_per_configuration.config.sh




Remarks from the original python script creator:

https://github.com/40net-cloud/fortiflex/tree/main/python
 
Create an API user: https://docs.fortinet.com/document/flex-vm/23.2.0/administration-guide/463716/fortiflex-api
Get your python env ready: Provide 3 environment variables FORTIFLEX_API_USER, FORTIFLEX_API_PASSWORD, FORTIFLEX_PROGRAM_SN

Run the list_entitlements_per_configuration.py providing the configuration id (--id)
export FORTIFLEX_API_PASSWORD=XYZ123
export FORTIFLEX_PROGRAM_SN=ELAVMS124
export FORTIFLEX_API_USER=USER123

python3 list_entitlements_per_configuration.py --id 4818

Python Requirements:
Requests==2.31.0
