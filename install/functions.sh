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

function ensure_lastpass_installed() {
  if hash lpass 2>/dev/null; then
    log_into_lastpass
  else
    install_lastpass
  fi
}

function log_into_lastpass() {
  log "lastpass-cli installed, username:"
  read username
  lpass login $username
}

function install_lastpass() {
  # lastpass-cli is a dependency for secrets, so ensure its available
  if hash boxen 2>/dev/null; then
      log "Boxen detected, ensuring up to date"
      boxen
  else
      log "Non-boxened machine detected"
      if hash brew 2>/dev/null; then
          log "Brew installed, ensuring up to date"
          brew update

          log "Installing lastpass-cli"
          brew install lastpass-cli
      else
          log "I cant install lastpass-cli, so your secrets wont work at all"
      fi
  fi
}
