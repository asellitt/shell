#!/usr/bin/env bash

module_supported() {
  [[ "$($SHELL --version 2>/dev/null)" == *"zsh"* ]]
}

module_install() {
  log "zsh" "Installing zsh config"

  link "${HOME}/.zshrc"    "${DOTFILES_DIR}/modules/zsh/rc"
  link "${HOME}/.zprofile" "${DOTFILES_DIR}/modules/zsh/profile"

  if [[ ! -d "${HOME}/.oh-my-zsh" ]]; then
    log "zsh" "Installing Oh My Zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  else
    if [[ "$UPDATE" == "true" ]]; then
      log "zsh" "Updating Oh My Zsh"
      "${HOME}/.oh-my-zsh/tools/upgrade.sh"
    fi
    link "${HOME}/.oh-my-zsh/themes/asellitt.zsh-theme" "${DOTFILES_DIR}/modules/zsh/zsh-theme"
  fi
}
