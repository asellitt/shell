#!/usr/bin/env bash

module_supported() { return 0; }

module_install() {
  log "ssh" "Installing ssh config"

  local ssh_config="${HOME}/.ssh/config"
  local include_line="Include ~/.ssh/machinespecific.config"

  touch "$ssh_config"
  chmod 600 "$ssh_config"

  if ! grep -qF "$include_line" "$ssh_config"; then
    echo "$include_line" >> "$ssh_config"
  fi
}
