#! /bin/bash

function usage() {
  echo "asellitt's dotfiles install script"
  echo ""
  echo "usage: install [-u|--update]"
  echo "               [-l|--license]"
  echo "               [-h|--help]"
  echo ""
}

function ensure_secret_dir_exists() {
  log "Ensuring secrets directory exist"
  mkdir -p "${DIR}/secret"
}

function agree_to_xcode_license() {
  LICENSE=$1

  if [[ $LICENSE == true ]]; then
    if [ `uname` == 'Darwin' ]; then
      log "OSX detected"
      log "Agreeing to xcode license, because fuck you OSX"
      sudo xcodebuild -license
    fi
  fi
}

function log_into_lastpass() {
  if [[ -f "${HOME}/.lpass/username" ]]; then
    log "lastpass-cli already logged in, continuing"
  else
    log "lastpass-cli installed, username:"
    read username
    lpass login $username
  fi
}

function update_packages() {
  UPDATE=$1

  if [[ $UPDATE == true ]]; then
    if hash boxen 2>/dev/null; then
      log "Boxen detected, updating boxen"
      boxen
    elif hash brew 2>/dev/null; then
      log "Brew installed, updating brew"
      brew update
      brew upgrade
    fi
  fi
}

function install_required_packages() {
  if hash boxen 2>/dev/null; then
    log 'Boxen detected, skipping package installation'
  else
    log 'Brew detected, installing required packages'
    package 'autojump'
    package 'gh'
    package 'lastpass-cli'
    package 'the_silver_searcher'
  fi
}

function log() {
  MESSAGE=$1

  echo "[${PREFIX}] ${MESSAGE}"
}

function link() {
  TO=$1
  FROM=$2

  log "   Removing ${TO}"
  rm "${TO}" 2>/dev/null
  log "   Linking ${FROM}"
  ln -s "${FROM}" "${TO}"
}

function package() {
  PACKAGE=$1

  if brew list $PACKAGE &>/dev/null; then
    log "${PACKAGE} installed, skipping"
  else
    log "${PACKAGE} not installed, installing"
    brew install $PACKAGE
  fi
}
