#! /bin/bash

PREFIX="GIT"
log "Begin Git config"

log "Installing Git config"
GIT_DIR="${HOME}"
GIT_MODULE_DIR="${DOTFILES_DIR}/git"

link "${GIT_DIR}/.gitconfig" "${GIT_MODULE_DIR}/config"
log "Fetching git.config.secret"
lpass show --notes git.config.secret > "${DOTFILES_DIR}/secret/git.config.secret"
git config --global include.path "${DOTFILES_DIR}/secret/git.config.secret"

link "${GIT_DIR}/.gitignore" "${GIT_MODULE_DIR}/ignore"
git config --global core.excludesfile "${GIT_DIR}/.gitignore"

link "${GIT_DIR}/.git-completion.bash" "${GIT_MODULE_DIR}/completion.bash"
link "${GIT_DIR}/.gitattributes" "${GIT_MODULE_DIR}/attributes"
link "${GIT_DIR}/.git-commands" "${GIT_MODULE_DIR}/commands"
chmod -RH u+x "${GIT_DIR}/.git-commands"
