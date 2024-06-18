#! /bin/zsh

PREFIX="PYTHON"
log "Begin Python config"

PYTHON_DIR="${HOME}"
PYTHON_MODULE_DIR="${DOTFILES_DIR}/python"

link "${PYTHON_DIR}/.default-python-packages" "${PYTHON_MODULE_DIR}/default-python-packages"