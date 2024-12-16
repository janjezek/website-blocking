#!/bin/bash

# Check if backup exists and restore it
if [ -f /etc/hosts.bak ]; then
    sudo cp /etc/hosts.bak /etc/hosts
    sudo dscacheutil -flushcache
    sudo killall -HUP mDNSResponder
    echo "Websites have been unblocked successfully!"
else
    echo "No backup file found. Nothing to restore."
fi 