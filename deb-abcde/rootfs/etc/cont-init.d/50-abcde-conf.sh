#!/usr/bin/with-contenv bashio
# ==============================================================================
# Community Hass.io Add-ons: deb
# ==============================================================================

set -xe
CDEST=/config/addons_config/${HAA_NAME}

mkdir -p ${CDEST}

if [ ! -r ${CDEST}/abcde.conf ];then
  cp -v /etc/abcde.conf ${CDEST}/abcde_sample.conf
  cp -v /usr/local/etc/abcde.conf ${CDEST}/abcde.conf
fi
