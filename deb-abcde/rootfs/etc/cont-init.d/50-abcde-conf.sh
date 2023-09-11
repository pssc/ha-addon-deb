#!/usr/bin/with-contenv bashio
# ==============================================================================
# Community Hass.io Add-ons: deb
# ==============================================================================

set -xe
CDEST=/config/addons_config/abcde/

mkdir -p ${CDEST}

if [ ! -r /config/addons_config/abcde/abcde.conf ];then
  cp -v /etc/abcde.conf /config/addons_config/abcde/abcde_sample.conf
  cp -v /usr/local/etc/abcde.conf /config/addons_config/abcde/abcde.conf
fi
