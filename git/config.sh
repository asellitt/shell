#! /bin/bash

PREFIX="GIT"
log "Begin Git config"

log "Installing Git config"
GIT_DIR="${HOME}"
GIT_MODULE_DIR="${DOTFILES_DIR}/git"

link "${GIT_DIR}/.gitconfig" "${GIT_MODULE_DIR}/config"
if hash bw 2>/dev/null && hash jq 2>/dev/null; then
  log "Fetching git.config.secret"
  bw get item git.config.secret | \
  jq -r ".notes" > \
    "${DOTFILES_DIR}/secret/git.config.secret"
fi
git config --global include.path "${DOTFILES_DIR}/secret/git.config.secret"

link "${GIT_DIR}/.gitignore" "${GIT_MODULE_DIR}/ignore"
git config --global core.excludesfile "${GIT_DIR}/.gitignore"

link "${GIT_DIR}/.git-completion.bash" "${GIT_MODULE_DIR}/completion.bash"
link "${GIT_DIR}/.gitattributes" "${GIT_MODULE_DIR}/attributes"
link "${GIT_DIR}/.git-commands" "${GIT_MODULE_DIR}/commands"
link "${GIT_DIR}/.git-coauthors" "${GIT_MODULE_DIR}/coauthors"
chmod -RH u+x "${GIT_DIR}/.git-commands"
