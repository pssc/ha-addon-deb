#!/usr/bin/with-contenv bashio
# ==============================================================================
# Community Hass.io Add-ons: deb
# ==============================================================================

set -xe
CDEST=/homeassistant/addons_config/${HAA_NAME}
LEGACY_CDEST=/config/addons_config

mkdir -p ${CDEST}
mkdir -p "$(dirname "${LEGACY_CDEST}")"

# Keep the former Home Assistant config path available to existing commands
# and user scripts. The canonical location is now /homeassistant.
if [ ! -e "${LEGACY_CDEST}" ] && [ ! -L "${LEGACY_CDEST}" ]; then
  ln -s /homeassistant/addons_config "${LEGACY_CDEST}"
elif [ "${LEGACY_CDEST}" -ef /homeassistant/addons_config ]; then
  :
else
  bashio::log.warning "Keeping existing ${LEGACY_CDEST}; legacy path is not linked to /homeassistant/addons_config"
fi

if [ ! -r ${CDEST}/abcde.conf ];then
  cp -v /etc/abcde.conf ${CDEST}/abcde_sample.conf
  cp -v /usr/local/etc/abcde.conf ${CDEST}/abcde.conf
fi
