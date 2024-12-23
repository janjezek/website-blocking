# Website Blocker for macOS

A simple set of Shell scripts to block distracting websites on macOS.

## Features

- Block websites permanently
- On-demand website blocking
- Support for both with and without 'www' subdomain

## How It Works

The blocking mechanism works by redirecting website domains to your local machine (127.0.0.1) through the `/etc/hosts` file. When you try to access a blocked website, your computer redirects the request to itself instead of the actual website server.

## Permanent Website Blocking

You can block websites by editing the hosts file manually:

1. Open Terminal and edit the hosts file:

```bash
sudo nano /etc/hosts
```

2. Add the websites you want to block by adding these lines:

```bash
127.0.0.1   facebook.com
127.0.0.1   www.facebook.com
127.0.0.1   youtube.com
127.0.0.1   www.youtube.com
```

3. Save the file:

   - Press `Control + O` to save
   - Press `Enter` to confirm
   - Press `Control + X` to exit

4. Flush the DNS cache:

```bash
sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder
```

## On-Demand Website Blocking

This feature allows you to manually block and unblock websites as needed using shell scripts. It provides flexibility to control access to specific websites temporarily without making permanent changes to the `/etc/hosts` file.

1. Create two scripts:

First, create `block-sites.sh` ([source](https://github.com/janjezek/website-blocking/blob/main/block-sites.sh)):

```bash
nano ~/block-sites.sh
```

Add this content:

```bash
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
```

Then create `unblock-sites.sh` ([source](https://github.com/janjezek/website-blocking/blob/main/unblock-sites.sh)):

```bash
nano ~/unblock-sites.sh
```

Add this content:

```bash
#!/bin/bash

# Check if backup exists and restore it
if [ -f /etc/hosts.bak ]; then
    sudo cp /etc/hosts.bak /etc/hosts
    sudo dscacheutil -flushcache
    sudo killall -HUP mDNSResponder
fi
```

2. Make the scripts executable:

```bash
chmod +x ~/block-sites.sh ~/unblock-sites.sh
```

3. You can run these scripts manually at any time:

```bash
bash ~/block-sites.sh    # To block websites
bash ~/unblock-sites.sh  # To unblock websites
```

## Troubleshooting

If websites are still accessible after blocking:

1. Clear your browser cache
2. Restart your browser
3. Verify hosts file content:

```bash
cat /etc/hosts
```

4. Refresh DNS cache:

```bash
sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder
```

## License

[MIT License](LICENSE)
