#!/usr/bin/env bash

_intellij_config_dirs() {
  ls -d "${INTELLIJ_SUPPORT_DIR:-${HOME}/Library/Application Support/JetBrains}/IntelliJIdea"* 2>/dev/null
}

module_supported() {
  is_macos && [[ -n "$(_intellij_config_dirs)" ]]
}

module_install() {
  log "intellij" "Installing IntelliJ config"

  local mod="${DOTFILES_DIR}/modules/intellij"
  local config

  while IFS= read -r config; do
    log "intellij" "Using config dir: ${config}"
    mkdir -p "${config}/colors" "${config}/keymaps"
    link "${config}/colors/$(whoami).icls" "${mod}/colors.icls"
    link "${config}/keymaps/$(whoami).xml" "${mod}/keymap.xml"
  done < <(_intellij_config_dirs)
}
