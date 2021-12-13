#! /bin/zsh

PREFIX="BASH"
log "Begin Bash config"

BASH_DIR="${HOME}"
BASH_MODULE_DIR="${DOTFILES_DIR}/bash"
local shell_version=$($SHELL --version)

if [[ "${shell_version}" != *"bash"* ]]; then
  log "Bash not in use, skipping config"
else
  log "Installing Bash config"
  link "${BASH_DIR}/.bashrc" "${BASH_MODULE_DIR}/rc"
  link "${BASH_DIR}/.bash_profile" "${BASH_MODULE_DIR}/profile"
  link "${BASH_DIR}/.bash_include" "${BASH_MODULE_DIR}/include"
  link "${BASH_DIR}/.bash_aliases" "${BASH_MODULE_DIR}/aliases"
  link "${BASH_DIR}/.bash_functions" "${BASH_MODULE_DIR}/functions"
  link "${BASH_DIR}/.bash_logout" "${BASH_MODULE_DIR}/logout"
fi
