#!/usr/bin/with-contenv bashio
# Keep the old mount paths available for user scripts after moving to the
# current Home Assistant app mount names.

link_legacy_path() {
  local legacy_path="$1"
  local current_path="$2"

  if [ -L "${legacy_path}" ]; then
    return 0
  fi

  if [ -d "${legacy_path}" ] && [ -z "$(ls -A "${legacy_path}")" ]; then
    rmdir "${legacy_path}"
  fi

  if [ -e "${legacy_path}" ]; then
    bashio::log.warning "Keeping existing ${legacy_path}; compatibility link to ${current_path} was not created"
    return 0
  fi

  ln -s "${current_path}" "${legacy_path}"
}

link_legacy_path /addons /local_apps
link_legacy_path /addon_configs /app_configs
