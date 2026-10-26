# Debian Base Terminal

Debian Base Terminal provides an interactive shell in Home Assistant. Open the app's **Web UI** to use the terminal through Ingress. SSH is also available when a host port is configured for TCP port 22.

## Installation

Install **Debian Base Terminal** from your Home Assistant app repository, then start it and open **Web UI**.

## Configuration

The options below are applied when the app starts. Restart the app after changing them.

### WebSocket ping interval

`ttyd_ping_interval` controls how often ttyd sends a WebSocket keepalive ping, in seconds. This can help keep idle terminal sessions connected through Ingress. The default is `30`; allowed values are `1` to `300`.

```yaml
ttyd_ping_interval: 30
```

### Debian packages

`packages` is a list of Debian package names to install at startup.

```yaml
packages:
  - rsync
```

Installing additional packages can increase startup time.

### Startup commands

`init_commands` is a list of shell commands run each time the app starts.

```yaml
init_commands:
  - /config/deb/scripts/fixups.sh
```

### Mounts

`mounts` is a list of mount command arguments. The app has elevated host access, so use mount options appropriate for your Home Assistant system.

```yaml
mounts:
  - '-t nfs storage-music.lan:/srv/store/music /data/mnt/music'
```

### Directories

`dirs` is a list of directories to create at startup. The app assigns them to its configured shell user.

```yaml
dirs:
  - /data/mnt/music
```

### Symbolic links

`links` is a list of symbolic links to create. `link` is the path of the link; `dest` is its target.

```yaml
links:
  - link: /var/music
    dest: /data/mnt/music
```

### Persistent storage

Home Assistant provides the configured paths under `/config`, `/share`, `/backup`, `/media`, and `/addons`. Data stored outside mapped paths or designated persistent directories may not survive app recreation. User data in `/data/music`, `/data/mount`, `/data/mnt`, `/data/nobackup`, and `/data/force_build` is excluded from app backups.

## Related apps

- [Debian User Terminal](../deb-user/README.md) adds user-focused development tools.
- [abcde](../deb-abcde/README.md) provides a CD-ripping terminal based on this image.

## Support

Report issues at [GitHub Issues](https://github.com/pssc/ha-addon-deb/issues).
