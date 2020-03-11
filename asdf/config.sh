#! /bin/bash

PREFIX="ASDF"
log "Begin asdf config"

log "Installing asdf"
brew_install "asdf"

if [ -f $(brew --prefix asdf)/asdf.sh ]; then
  . $(brew --prefix asdf)/asdf.sh
  . $(brew --prefix asdf)/etc/bash_completion.d/asdf.bash
fi

ASDF_HOME_DIR="${HOME}"
ASDF_MODULE_DIR="${DOTFILES_DIR}/asdf"
ilink "${ASDF_HOME_DIR}/.tool-versions" "${ASDF_MODULE_DIR}/tool-versions"
link "${ASDF_HOME_DIR}/.asdfrc" "${RUBY_MODULE_DIR}/rc"

if hash asdf 2>/dev/null; then
  log "  asdf detected, installing version managers"

  # log "  Installing required ruby version manager"
  # asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git

  # log "  Installing required nodejs version manager"
  # asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git

  log "  Installing required erlang version manager"
  asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git

  log "  Installing required elixir version manager"
  asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git

  if [[ $UPDATE == true ]]; then
    log "    Updating asdf managed versions"
    asdf plugin update --all
    asdf install
  fi
fi
