#! /bin/bash

PREFIX="ZSH"
log "Begin Zsh config"

local shell_version=$($SHELL --version)

if [[ "${shell_version}" != *"zsh"* ]]; then
  log "Zsh not in use, skipping config"
else
  log "Installing Zsh config"
  log "Installing ohmyzsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
