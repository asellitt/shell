#!/usr/bin/env bash

module_supported() { return 0; }

module_install() {
  log "git" "Installing git config"

  # Write ~/.gitconfig as a real file so git can freely append [maintenance]
  # and other machine-specific entries without dirtying this repo.
#   cat > "${HOME}/.gitconfig" <<EOF
# [include]
#   path = ${DOTFILES_DIR}/modules/git/config
#   path = ${DOTFILES_DIR}/secret/git.config.secret
# EOF
  git config --global --get include.path "${DOTFILES_DIR}/modules/git/config" &>/dev/null || \
    git config --global --add include.path "${DOTFILES_DIR}/modules/git/config"
  git config --global --get include.path "${DOTFILES_DIR}/secret/git.config.secret" &>/dev/null || \
    git config --global --add include.path "${DOTFILES_DIR}/secret/git.config.secret"

  link "${HOME}/.gitconfig.aliases"   "${DOTFILES_DIR}/modules/git/gitconfig/aliases"
  link "${HOME}/.gitconfig.commands"  "${DOTFILES_DIR}/modules/git/gitconfig/commands"
  link "${HOME}/.gitconfig.core"      "${DOTFILES_DIR}/modules/git/gitconfig/core"
  link "${HOME}/.gitconfig.diff"      "${DOTFILES_DIR}/modules/git/gitconfig/diff"
  link "${HOME}/.gitconfig.merge"     "${DOTFILES_DIR}/modules/git/gitconfig/merge"
  link "${HOME}/.gitconfig.user"      "${DOTFILES_DIR}/modules/git/gitconfig/user"
  link "${HOME}/.gitignore"           "${DOTFILES_DIR}/modules/git/ignore"
  link "${HOME}/.git-completion.bash" "${DOTFILES_DIR}/modules/git/completion.bash"
  link "${HOME}/.gitattributes"       "${DOTFILES_DIR}/modules/git/attributes"
  link "${HOME}/.git-commands"        "${DOTFILES_DIR}/modules/git/commands"
  link "${HOME}/.git-coauthors"       "${DOTFILES_DIR}/modules/git/coauthors"
  chmod -RH u+x "${HOME}/.git-commands"

  if hash bw 2>/dev/null && hash jq 2>/dev/null; then
    log "git" "Fetching git.config.secret from Bitwarden"
    bw get item git.config.secret | \
      jq -r ".notes" > "${DOTFILES_DIR}/secret/git.config.secret"
  fi
}
