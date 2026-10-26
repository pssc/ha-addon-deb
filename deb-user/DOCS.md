# Debian User Terminal

Debian User Terminal is a Home Assistant terminal with additional tools for development and system administration. It inherits the Debian shell and Web UI terminal from [Debian Base Terminal](../deb/DOCS.md).

## Installation and access

Install **Debian User Terminal** from your Home Assistant app repository, start it, then open **Web UI**. To use SSH, configure a host port for TCP port 22.

## Included tools

The image includes GitHub CLI (`gh`), Docker CLI, and Python development tools. Python packages installed with `pip` are available system-wide; use `pipx` for isolated command-line applications where appropriate.

### GitHub CLI

Authenticate interactively with:

```sh
gh auth login
```

Check the active account with:

```sh
gh auth status
```

## Configuration

The options below are applied at startup. Restart the app after changing them.

### WebSocket ping interval

`ttyd_ping_interval` controls how often ttyd sends a WebSocket keepalive ping, in seconds. The default is `30`; allowed values are `1` to `300`.

```yaml
ttyd_ping_interval: 30
```

### Debian packages

`packages` is a list of Debian package names to install at startup. Installing additional packages can increase startup time.

```yaml
packages:
  - rsync
```

### Startup commands

`init_commands` is a list of shell commands run each time the app starts.

```yaml
init_commands:
  - mkdir -p /etc/my.cnf.d
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
