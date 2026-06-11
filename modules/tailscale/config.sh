#!/usr/bin/env bash

module_supported() { ! is_steamos && is_personal; }

module_install() {
  log "tailscale" "Installing Tailscale"

  local sources_list="${TAILSCALE_SOURCES_LIST:-/etc/apt/sources.list.d/tailscale.list}"
  if is_ubuntu && [[ ! -f "$sources_list" ]]; then
    local codename
    codename="$(lsb_release -cs 2>/dev/null || (. /etc/os-release && echo "$VERSION_CODENAME"))"
    curl -fsSL "https://pkgs.tailscale.com/stable/ubuntu/${codename}.noarmor.gpg" | \
      sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg > /dev/null
    curl -fsSL "https://pkgs.tailscale.com/stable/ubuntu/${codename}.tailscale-keyring.list" | \
      sudo tee /etc/apt/sources.list.d/tailscale.list
    sudo apt update
  fi

  install_from_manifest "${DOTFILES_DIR}/modules/tailscale/install.conf"
}
