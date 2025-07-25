#!/bin/bash

###################################################################
# Script Name	: Nagios - Check_service                                                                                              
# Description	: Check the status of a specified service in Linux
# Creation Date :
# Args          :                                                                                           
# Author       	: Tino                                                
# Email        	:                                      
###################################################################

### VARIABLES NAGIOS
OK=0
WARNING=1
CRITICAL=2
UNKNOWN=3

PROGNAME=`basename $0 .sh`
VERSION="Version 1.0"

print_version() {
    echo "$VERSION"
}

print_help() {
    print_version $PROGNAME $VERSION
    echo ""
    echo "$PROGNAME is a Nagios plugin to check a specific service using systemctl."
    echo ""
    echo "$PROGNAME -s <service_name>"
    exit $UNKNOWN
}

if test -z "$1"
then
        print_help
        exit $CRITICAL
fi

while test -n "$1"; do
    case "$1" in
        --help|-h)
            print_help
            exit $UNKNOWN
            ;;
        --version|-v)
            print_version $PROGNAME $VERSION
            exit $UNKNOWN
            ;;
        --service|-s)
            SERVICE=$2
            shift
            ;;
        *)
            echo "Unknown argument: $1"
            print_help
            exit $UNKNOWN
            ;;
        esac
    shift
done

if systemctl is-active $SERVICE >/dev/null 2>&1
then
    echo -e "OK: Service $SERVICE is running!"
    exit $OK
else
    echo -e "CRITICAL: Service $SERVICE is not running!"
    exit $CRITICAL
fi
