#!/bin/bash
BLOCKED_SITES=(
    "127.0.0.1   facebook.com"
    "127.0.0.1   www.facebook.com"
    "127.0.0.1   youtube.com"
    "127.0.0.1   www.youtube.com"
)

# Backup the current /etc/hosts file
sudo cp /etc/hosts /etc/hosts.bak

# Add blocked sites if not already present
for SITE in "${BLOCKED_SITES[@]}"; do
    if ! grep -q "$SITE" /etc/hosts; then
        echo "$SITE" | sudo tee -a /etc/hosts > /dev/null
    fi
done

# Flush DNS cache
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder