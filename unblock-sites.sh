#!/bin/bash
if [ -f /etc/hosts.bak ]; then
    sudo cp /etc/hosts.bak /etc/hosts
    sudo dscacheutil -flushcache
    sudo killall -HUP mDNSResponder
fi