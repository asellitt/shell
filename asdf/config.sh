#! /bin/bash

PREFIX="ASDF"
log "Begin asdf config"

log "Installing asdf"
brew_install "asdf"

ASDF_DIR="${HOME}"
ASDF_MODULE_DIR="${DOTFILES_DIR}/asdf"
link "${ASDF_DIR}/.tool-versions" "${ASDF_MODULE_DIR}/.tool-version"

log "Installing required erlang version manager"
asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git

log "Installing required elixir version manager"
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git

if [[ $UPDATE == true ]]; then
  asdf install
fi
