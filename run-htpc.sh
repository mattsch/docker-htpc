#!/usr/bin/env bash

# Check our uid/gid, change if env variables require it
if [ "$( id -u htpc )" -ne "${LUID}" ]; then
    usermod -o -u ${LUID} htpc
fi

if [ "$( id -g htpc )" -ne "${LGID}" ]; then
    groupmod -o -g ${LGID} htpc
fi

# Set permissions
chown -R htpc:htpc /config/ /opt/htpc

exec runuser -l htpc -c '/opt/app/Htpc.py --daemon'
