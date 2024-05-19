#!/usr/bin/with-contenv bashio
# ==============================================================================
# Install user configured/requested packages
# ==============================================================================

#if bashio::config.true 'upgrade_packages'; then
#if bashio::config.true 'cache_packages'; then
#if bashio::config.has_value 'packages'; then
APTCACHEDIR="/config/addons_config/${HAA_NAME}/apt"

if [ -r "${APTCACHEDIR}" ];then
        bashio::log.info "Using addon cachedir ${APTCACHEDIR} for /var/cache/apt"
        rm /etc/apt/apt.conf.d/docker-clean
	cat >/etc/apt/apt.conf.d/keep <<EOF
APT::Keep-Downloaded-Packages "true";
EOF

	rm -rf /var/cache/apt
	ln -s "${APTCACHEDIR}" /var/cache/apt
fi

exit 0
