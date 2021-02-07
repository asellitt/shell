#! /bin/bash

PREFIX="ZSH"
log "Begin Zsh config"

if [[ -z $ZSH_VERSION ]]; then
  log "Zsh not in use, skipping config"
else
  log "Installing Zzh config"
  log "Installing ohmyzsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
