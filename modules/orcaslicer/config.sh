#!/usr/bin/env bash

module_supported() { is_macos && is_personal; }

module_install() {
  log "orcaslicer" "Installing OrcaSlicer"
  install_from_manifest "${DOTFILES_DIR}/modules/orcaslicer/install.conf"

  log "orcaslicer" "Trusting Bambuddy CA in OrcaSlicer"
  bambuddy_trust_ca "OrcaSlicer" "/Applications/OrcaSlicer.app/Contents/Resources/cert"
}
