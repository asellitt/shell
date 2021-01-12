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

function brew_install() {
  local package=$1

  if hash boxen 2>/dev/null; then
    log "  Boxen detected, skipping ${package} installation"
  else
    if hash brew 2>/dev/null; then
      log "  Brew detected, installing ${package}"
      if brew list $package &>/dev/null; then
        log "     ${package} installed, skipping"
      else
        log "     ${package} not installed, installing"
        brew install $package
      fi
    fi
  fi
}

function cask_install() {
  local package=$1

  if hash boxen 2>/dev/null; then
    log "  Boxen detected, skipping ${package} installation"
  else
    if hash brew 2>/dev/null; then
      log "  Brew detected, installing ${package}"
      if brew list --cask $package &>/dev/null; then
        log "     ${package} installed, skipping"
      else
        log "     ${package} not installed, installing"
        brew install --cask $package
      fi
    fi
  fi
}

function mas_install() {
  local identifier=$1
  local application=$2

  if hash mas 2>/dev/null; then
    log "  Mas detected, installing ${application}"
    mas install $identifier
  fi
}

function post_install_message() {
  local post_install_message=$1

  if [ -z "$POST_INSTALL_MESSAGES" ] ; then
    POST_INSTALL_MESSAGES=()
  fi

  POST_INSTALL_MESSAGES[${#POST_INSTALL_MESSAGES[@]}]=$post_install_message
}

function print_post_install_messages() {
  PREFIX="POSTINSTAL"

  echo ""
  echo ""
  log "Post install messages:"
  echo ""
  printf '%s\n' "${POST_INSTALL_MESSAGES[@]}"
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

