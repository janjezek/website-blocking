# Website Blocker for macOS

A simple set of bash scripts to block distracting websites on macOS. You can either block websites permanently or schedule blocking during specific hours.

## Features

- Block/unblock websites easily using terminal commands
- Schedule website blocking during specific hours (e.g., work hours)
- Backup of original hosts file
- Support for both with and without 'www' subdomain

## Prerequisites

- macOS operating system
- Administrative privileges

## Installation

1. Clone this repository:

```bash
git clone https://github.com/yourusername/website-blocker
cd website-blocker
```

2. Make the scripts executable:

```bash
chmod +x block-sites.sh unblock-sites.sh
```

## Usage

### Manual Blocking/Unblocking

1. To block websites:

```bash
./block-sites.sh
```

2. To unblock websites:

```bash
./unblock-sites.sh
```

### Scheduled Blocking (During Work Hours)

1. Open your crontab file:

```bash
export EDITOR=nano
crontab -e
```

2. Add the following lines to block during work hours (9 AM to 5 PM, Monday to Friday):

```bash
0 9 * * 1-5 /full/path/to/block-sites.sh
0 17 * * 1-5 /full/path/to/unblock-sites.sh
```

Note: Replace `/full/path/to/` with the actual path to your scripts.

### Customizing Blocked Websites

To modify the list of blocked websites, edit the `BLOCKED_SITES` array in `block-sites.sh`:

```bash
BLOCKED_SITES=(
    "127.0.0.1   facebook.com"
    "127.0.0.1   www.facebook.com"
    # Add more sites here
)
```

## How It Works

The scripts modify the `/etc/hosts` file to redirect specified domains to the localhost (127.0.0.1), effectively blocking access to these websites. The original hosts file is backed up before any modifications.

## Important Notes

- You need administrative privileges to run these scripts
- The first time you run the scripts, you'll be prompted for your password
- Changes might require a browser restart to take effect
- Some browsers might cache DNS entries; you might need to clear browser cache

## Troubleshooting

If websites are still accessible after blocking:

1. Clear your browser cache
2. Restart your browser
3. Check if the sites are properly added to `/etc/hosts`:
   ```bash
   cat /etc/hosts
   ```
4. Ensure DNS cache was flushed successfully:
   ```bash
   sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder
   ```

## Common Issues

1. **Permission Denied**: Make sure you run the scripts with proper permissions:

   ```bash
   sudo ./block-sites.sh
   ```

2. **Changes Not Taking Effect**: Try closing and reopening your browser, or clearing DNS cache:
   ```bash
   sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder
   ```

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Support

If you encounter any issues or have questions, please file an issue on the GitHub repository.
