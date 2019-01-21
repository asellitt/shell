#! /bin/bash

PREFIX="NODE"
log "Begin Node config"

log "Installing required node version manager"
brew_install 'nvm'
brew_install 'yarn --without-node'

log "Ensuring local nvm directory exists"
mkdir ~/.nvm 2>/dev/null

if [[ $UPDATE == true ]]; then
  log "Installing latest node"
  unset PREFIX
  . $(brew --prefix nvm)/nvm.sh
  nvm install --lts
  nvm use --lts
  PREFIX="NODE"
fi

log "Installing handy packages"
if hash npm 2>/dev/null; then
  log "  npm detected, installing packages"
  npm install nativefier -g
  npm install prettier -g
  npm install create-react-app -g
  npm install git-mob -g
fi
