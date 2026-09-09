#!/usr/bin/env bash

module_supported() { is_personal; }

module_install() {
  log "bambustudio" "Installing Bambu Studio"
  install_from_manifest "${DOTFILES_DIR}/modules/bambustudio/install.conf"

  if is_macos; then
    log "bambustudio" "Trusting Bambuddy CA in Bambu Studio"
    bambuddy_trust_ca "Bambu Studio" "/Applications/BambuStudio.app/Contents/Resources/cert"
  fi
}
