# Custom CLI Scripts

## saulo-ssh

SSH connection manager with automatic port forwarding.

### Setup

The script lives at `~/.dotfiles/bin/saulo-ssh` and is available in `$PATH` via `~/.dotfiles/bin`.

Configuration is stored at `~/.config/saulo-ssh/config`:

```
USER=sauloxd
IP=192.168.15.186
PORTS=5001,3035,8025
```

### Usage

```bash
# Connect with all configured port forwards
# Checks if host is reachable first, skips ports already forwarded by an existing tunnel
saulo-ssh

# List config, active tunnels, and listening ports
saulo-ssh ls

# Manage forwarded ports
saulo-ssh add 4000
saulo-ssh rm 4000

# Update host IP
saulo-ssh ip 192.168.15.100

# Help
saulo-ssh help
```

### How it works

1. Pings the configured IP to check reachability (prompts for a new IP if unreachable)
2. Checks each configured port — if already forwarded by an existing SSH tunnel, it skips it
3. Connects via `ssh -L` with the remaining ports
