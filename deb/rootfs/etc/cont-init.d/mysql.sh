#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: SSH & Web Terminal
# Pre-configures the MySQL clients, if the service is available
# ==============================================================================
declare host
declare password
declare port
declare username

if bashio::services.available "mysql"; then
  host=$(bashio::services "mysql" "host")
  password=$(bashio::services "mysql" "password")
  port=$(bashio::services "mysql" "port")
  username=$(bashio::services "mysql" "username")

  mkdir -p /etc/mysql/conf.d
  {
    echo "[client]"
    echo "host=${host}"
    echo "password=\"${password}\""
    echo "port=${port}"
    echo "user=\"${username}\""
  } > /etc/mysql/conf.d/service.cnf
fi
