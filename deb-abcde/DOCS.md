# abcde

The abcde app provides a CD-ripping terminal for Home Assistant. It inherits the Debian shell and Web UI terminal from [Debian Base Terminal](../deb/DOCS.md).

## Installation and access

Install **abcde** from your Home Assistant app repository, start it, then open **Web UI**. The terminal starts abcde with the app's configuration file. To use SSH, configure a host port for TCP port 22.

## abcde configuration

The app stores its abcde configuration and sample at:

```text
/config/addons_config/abcde/abcde.conf
/config/addons_config/abcde/abcde_sample.conf
```

Edit `abcde.conf` to configure CD reading, output formats, and tagging. The default file is copied into place the first time the app starts.

## App options

The options below are applied at startup. Restart the app after changing them.

### WebSocket ping interval

`ttyd_ping_interval` controls how often ttyd sends a WebSocket keepalive ping, in seconds. The default is `30`; allowed values are `1` to `300`.

```yaml
ttyd_ping_interval: 30
```

### Debian packages and startup commands

`packages` lists additional Debian packages to install at startup. `init_commands` lists shell commands to run each time the app starts.

```yaml
packages: []
init_commands: []
```

### Mounts, directories, and links

These options are inherited from Debian Base Terminal:

- `mounts`: mount command arguments to run at startup.
- `dirs`: directories to create at startup.
- `links`: symbolic links to create, using `link` for the link path and `dest` for its target.

```yaml
mounts: []
dirs: []
links: []
```

See [Debian Base Terminal configuration](../deb/DOCS.md#configuration) for examples. The app has elevated host access, so use mount options appropriate for your Home Assistant system.

## Support

Report issues at [GitHub Issues](https://github.com/pssc/ha-addon-deb/issues).
