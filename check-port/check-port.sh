#!/bin/bash
#
# Simple check for port connectivity
#

# First check
[[ -z "$1" ]] && echo "No options given! Please specify [HOST] [PORT] <SOURCE IP>" && exit 1

# Validate and set vars
HOST=$(echo "$1" | egrep '^[a-zA-Z1-9.]*[a-zA-Z]$|^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$')
PORT=$(echo "$2" | egrep '^0*(([1-9])|([1-9][0-9])|([1-9][0-9][0-9])|([1-9][0-9][0-9][0-9])|([1-5][0-9][0-9][0-9][0-9])|(6[0-4][0-9][0-9][0-9])|(65[0-4][0-9][0-9])|(655[0-2][0-9])|(6553[0-5]))$')
SOURCE=$(echo "$3" | egrep '^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$')
TIMEOUT=2

# final validation

[[ -z "$HOST" ]] && echo "Not a valid host!" && exit 1
[[ -z "$PORT" ]] && echo "Not a valid port!" && exit 1

# Check if we need to use the source.
if [[ -n "$SOURCE" ]]; then
# Use the source, Luke!
 nc -w $TIMEOUT -z -s $SOURCE $HOST $PORT > /dev/null 2>&1
 [[ $? -eq 0 ]] && echo 1 || echo 0
else
# The source is not strong in this one,
 nc -w $TIMEOUT -z $HOST $PORT > /dev/null 2>&1
 [[ $? -eq 0 ]] && echo 1 || echo 0
fi

