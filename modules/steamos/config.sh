#!/usr/bin/env bash

module_supported() { is_steamos; }

module_install() {
  log "steamos" "Installing SteamOS config"

  log "steamos" "Ensuring Flathub remote is registered"
  flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
}
