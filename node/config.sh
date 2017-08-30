#! /bin/bash

PREFIX="NODE"
log "Begin Node config"

log "Installing required node version manager"
package 'nvm'
package 'yarn --without-node'

log "Ensuring local nvm directory exists"
mkdir ~/.nvm 2>/dev/null

log "Installing latest node"
unset PREFIX
. $(brew --prefix nvm)/nvm.sh
nvm install --lts
nvm use --lts
PREFIX="NODE"

log "Installing handy packages"
if hash npm 2>/dev/null; then
  log "  npm detected, installing packages"
  npm install nativefier -g
fi
