# Home Assistant Add-on: abcde Debian Shell (Unoffical)

## Installation

Follow these steps to get the add-on installed on your system:

1. Navigate in your Home Assistant frontend to **Supervisor** -> **Add-on Store**.
2. Find the "Debian" add-on and click it.
3. Click on the "INSTALL" button.

## How to use

Fire up the addon answer the prompt at the terminal

## Add-on Configuration

Smaple and Reference config files supplied.

default locations
 - /config/addon_config/deb_abcde

Addional software:-
 - osync
 - rsync
 - squeezy

Example basic config:-

```yaml
          "mounts": [],
          "dirs": [],
          "links": [],
          "init_commands": [],
          "packages": []
```

---

### Option group `Environment`

Flexible disk layout options, additional customisation of packages and startup to allow migration of existing setups.  As well as the installation of plugins.

---

### Option: `mounts` (required may be empty)

Note these paths are not backed up ```[ "/data/music", "/data/mount", "/data/mnt" ]```,

```yaml
mounts:
  - '-t nfs storage-music.lan:/srv/store/music /data/mnt/music'
```

### Option: `dirs` (required may be empty)

Directories to create.

```yanml
dirs:
  - /data/mnt/music
```

### Option: `links` (required may be empty)

Links to create.

```yanml
links:
  - dest: /data/mnt/music
    link: /var/music
```

#### Option: `packages` (required may be empty)

Allows you to specify additional [Debian packages][debian-packages] to be
installed in your environment (e.g., Python, Joe, Irssi).

**Note**: _Adding many packages will result in a longer start-up
time for the add-on._

```yaml
packages:
  - rsync
```
#### Option: `init_commands` (required may be empty)

Customize your environment even more with the `init_commands` option.
Add one or more shell commands to the list, and they will be executed every
single time this add-on starts. Before LMS starts

```yaml
init_commands:
  - /config/deb/scripts/fixups.sh
```

### Option group `ssh`

Options affecting the ssh server

---

### Option: `options`

Additional options string to run server with.

```yaml
options: '--debug'
```

## Support

Got questions?

You have several options to get them answered:

- The [Home Assistant Discord Chat Server][discord].
- The Home Assistant [Community Forum][forum].
- Join the [Reddit subreddit][reddit] in [/r/homeassistant][reddit]

In case you've found a bug, please [open an issue on our GitHub][issue].

[discord]: https://discord.gg/c5DvZ4e
[forum]: https://community.home-assistant.io
[issue]: https://github.com/pssc/ha-addon-deb/issues
[reddit]: https://reddit.com/r/homeassistant
[repository]: https://github.com/pssc/ha-addon-deb
[debian-packages]: https://packages.debian.org/
