#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: lms
# Set up env from ha
# ==============================================================================

echo -n ${HAA_NAME:-$(hostname -s|sed 's/^[a-zA-Z0-9]*-//')} >/run/s6/container_environment/HAA_NAME

exit 0
