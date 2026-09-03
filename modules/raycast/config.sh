#!/usr/bin/env bash

module_supported() { 
  is_macos && [[ -d "/Applications/Raycast.app" ]]
 }

module_install() {
  log "raycast" "Installing Raycast config"

  local mod="${DOTFILES_DIR}/modules/raycast"
  
  link "${HOME}/.raycast-scripts" "${mod}/scripts"
}