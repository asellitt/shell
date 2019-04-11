#! /bin/bash

PREFIX="NODE"
log "Begin Node config"

log "Installing required node version manager"
brew_install 'n'

log "Installing yarn"
brew_install 'yarn'

NODE_DIR="${HOME}"
NODE_MODULE_DIR="${DOTFILES_DIR}/node"

if [[ $UPDATE == true ]]; then
  local node_version=$(cat "${NODE_MODULE_DIR}/version")

  if hash n 2>/dev/null; then
    log "Installing latest node: ${node_version}"
    N_PREFIX=${NODE_DIR} n ${node_version}
  fi
fi

link "${NODE_DIR}/.nvmrc" "${NODE_MODULE_DIR}/version"

log "Installing handy packages"
if hash npm 2>/dev/null; then
  log "  npm detected, installing packages"
  npm install nativefier -g
  npm install prettier -g
  npm install create-react-app -g
  npm install git-mob -g
fi
