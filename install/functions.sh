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
