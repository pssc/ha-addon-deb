## [12.5.12] 2024-05-19
 - Bump base to 7.8.3

## [12.5.12] 2024-05-19

### Changes
 - Allow use of "/config/addons_config/deb/apt" for caching if it exists

### Fixes
 - Fix match for hostname for naming addon for path pre/post fixes HAA_NAME

## [12.5.11] 2024-05-16

### Fixes
 - Fix mysql startup to cope with debian

## [12.5.10] 2024-05-15

### Fixes
 - Fix mqtt startup to cope with involatile homedirs

## [12.5.9] 2024-05-01

### Changes
 - Bump to debian base 7.3.3

## [12.5.8] 2024-04-20

### Changes
 - Bump to debian 12.5

### Fixes
 - mouse issue under chrome
 - xclip usage with no x available.

## [12.2.0] 2023-11-08

### Changes
 - Bump to debian base 7.2 and debian 12.2
 - expose original /run from HA as /run-orig

## [12.1.3] 2023-08-16

### Fixes
 - Stdin service
 - s6 halt

## [12.1.2] 2023-08-05

### Changes
 - Move more out of base and into Debian User Terminal
 - Add davfs2 for nextcloud support.

### Fixes
 - docker repo to bookrworm.

## [12.1.0] 2023-08-04

### Changes
 - Debian Base upgrade to 7.1.0

## [12.0.17] 2023-07-17

### Changes
 - Debian Base upgrade to 7.0.0
 - ttyd 1.7.3
 - ha cli 4.27.0

## [11.12.17] 2022-08-20

### Changes
 - Debian Base upgrade to 5.3.1
 - ttyd 1.7.2
 - ha cli 4.19.0

### Added
 - oh my bash

### Fixes
 - Fix hass-cli to 0.9.3 as 0.9.4 borks
