#! /bin/bash

function usage() {
  echo "asellitt's dotfiles install script"
  echo ""
  echo "usage: dotfiles [-b|--banner bannerFile]"
  echo "                [-h|--help]"
  echo "                [-u|--update]"
  echo "                [-l|--license]"
  echo ""
}

function log() {
  local prefix=$(printf "%10s" $PREFIX)
  local message=$1

  determine_color_code $prefix
  local erst="\033[1;0m"
  local ecol=$COLOR

  echo -en "${erst}"
  echo -n "[${col}"
  echo -en "${ecol}"
  echo -n "${prefix}"
  echo -en "${erst}"
  echo -n "] ${message}"
  echo -e "${erst}"
}

function link() {
  local to=$1
  local from=$2

  log "   Removing ${to}"
  rm "${to}" 2>/dev/null
  log "   Linking ${from}"
  ln -s "${from}" "${to}"
}

function package() {
  local package=$1

  if brew list $package &>/dev/null; then
    log "   ${package} installed, skipping"
  else
    log "   ${package} not installed, installing"
    brew install $package
  fi
}

function determine_color_code() {
  local prefix=$1
  local color_offset=0

  for (( i=0; i<${#prefix}; i++ )); do
    color_offset=$((color_offset + i * $(printf "%d" "'$i")))
  done
  color_offset=$((31 + color_offset % 6))

  COLOR="\033[0;${color_offset}m"
}
