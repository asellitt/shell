#! /bin/zsh

PREFIX="ZSH"
log "Begin Zsh config"

ZSH_DIR="${HOME}"
ZSH_MODULE_DIR="${DOTFILES_DIR}/zsh"
local shell_version=$($SHELL --version)

if [[ "${shell_version}" != *"zsh"* ]]; then
  log "Zsh not in use, skipping config"
else
  log "Installing Zsh config"

  if [[ ! -d "${ZSH_DIR}/.oh-my-zsh" ]]; then
    log "  Oh My Zsh not installed, installing"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  else
    log "  Oh My Zsh installed"
    if [[ $UPDATE == true ]]; then
      log "  Updating Oh My Zsh"
      exec ${ZSH_DIR}/.oh-my-zsh/tools/upgrade.sh
    fi

    link "${ZSH_DIR}/.oh-my-zsh/themes/asellitt.zsh-theme" "${ZSH_MODULE_DIR}/zsh-theme"
  fi

  link "${ZSH_DIR}/.zshrc" "${ZSH_MODULE_DIR}/rc"
fi
