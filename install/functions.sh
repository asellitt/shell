#! /bin/bash

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
  if [[ $LICENSE == true ]]; then
    if [ `uname` == 'Darwin' ]; then
      log "OSX detected"
      log "Agreeing to xcode license, because fuck you OSX"
      sudo xcodebuild -license
    fi
  fi
}

function ensure_lastpass_installed() {
  if hash lpass 2>/dev/null; then
    log_into_lastpass
  else
    install_lastpass
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

function install_lastpass() {
  # lastpass-cli is a dependency for secrets, so ensure its available
  if hash boxen 2>/dev/null; then
    log "Boxen detected"

    if [[ $UPDATE == true ]]; then
      log "update requested: Updating boxen"
      boxen
    fi
  else
    log "Non-boxened machine detected"
    if hash brew 2>/dev/null; then
      log "Brew installed"

      if [[ $UPDATE == true ]]; then
        log "update requested: Updating brew"
        brew update
      fi

      log "Installing lastpass-cli"
      brew install lastpass-cli
    else
      log "I cant install lastpass-cli, so your secrets wont work at all"
    fi
  fi
}
