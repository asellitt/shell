#!/usr/bin/env bash

_vscode_user_dir() {
  case "$OS" in
    macos)   echo "${HOME}/Library/Application Support/Code/User" ;;
    ubuntu)  echo "${HOME}/.config/Code/User" ;;
    steamos) echo "${HOME}/.config/Code/User" ;;
  esac
}

module_supported() {
  local user_dir
  user_dir="$(_vscode_user_dir)"
  [[ -d "$user_dir" ]]
}

module_install() {
  log "vscode" "Installing VSCode config"

  local user_dir
  user_dir="$(_vscode_user_dir)"
  link "${user_dir}/settings.json" "${DOTFILES_DIR}/modules/vscode/settings.json"
}
