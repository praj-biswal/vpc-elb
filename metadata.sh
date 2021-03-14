#!/bin/bash

# assign variables
ACTION=${1}
VERSION='0.1.0'

function show_version(){
echo $VERSION
}

function create_file() {
touch "${1}-rds-message.txt"
touch "${1}-ecoweb1-identity.json"
nc -vz ecotech-db-1.cz5tx5g2vuqh.us-east-1.rds.amazonaws.com 3306 >> rds-message.txt
curl http://169.254.169.254/latest/dynamic/instance-identity/document/ >> ecoweb1-identity.json
}

function display_help(){

cat << EOF
Usage: ${0} {-c|--create|-h|--help|-v|--version} <metadata.sh>
OPTIONS:
       -c | --create Create a new file
       -h | --help Display the command help
       -v | --version It shows the current version
       
Examples:
        Create a new file:
               $ ${0} -c 
        Display help:
               $ ${0} -h
	Show version:
	       $ ${0} -v
        	
EOF
}

case "$ACTION" in
        -h|--help)
                display_help
                ;;
        -c|--create)
                create_file "${2:-server}"
                ;;
	-v|--version)
		show_version
		;;
         *)
         echo "Usage ${0} {-c|-h|-v}"
         exit 1
esac


