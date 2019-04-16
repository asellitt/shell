#! /bin/bash

PREFIX="NODE"
log "Begin Node config"

log "Installing required node version manager"
brew_install 'n'

# fuck me. n_prefix didnt work, so sudo all the things.
# once again, the js ecosystem doesnt fail to deliver on their fuckery.
post_install_message "NODE: If this is the first run, ensure you own the n and node usr local directories"
post_install_message "     sudo mkdir -p /usr/local/n"
post_install_message "     sudo chown -R $(whoami) /usr/local/n"
post_install_message "     sudo chown -R $(whoami) /usr/local/bin /usr/local/lib /usr/local/include /usr/local/share"
post_install_message ""

log "Installing yarn"
brew_install 'yarn'

NODE_DIR="${HOME}"
NODE_MODULE_DIR="${DOTFILES_DIR}/node"

if [[ $UPDATE == true ]]; then
  local node_version=$(cat "${NODE_MODULE_DIR}/version")

  if hash n 2>/dev/null; then
    log "Installing latest node: ${node_version}"
    n ${node_version}
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
