#!/usr/bin/env bash

module_supported() { [[ "$INSTALL" == "true" ]]; }

module_install() {
  log "apps" "Installing apps"

  if [[ "$UPDATE" == "true" ]]; then
    log "apps" "Updating installed apps"
    app_update
  fi

  local apps_dir="${DOTFILES_DIR}/modules/apps"
  local mode_lower
  mode_lower="$(echo "$MODE" | tr '[:upper:]' '[:lower:]')"

  install_from_manifest "${apps_dir}/common.conf"
  install_from_manifest "${apps_dir}/${mode_lower}.conf"
}
