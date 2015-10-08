#! /bin/bash

function usage() {
  echo "asellitt's dotfiles install script"
  echo ""
  echo "usage: install [-b|--banner bannerFile]"
  echo "               [-h|--help]"
  echo "               [-u|--update]"
  echo "               [-l|--license]"
  echo ""
}

function parse_commandline_arguments() {
  while [ "$1" != "" ]; do
    case $1 in
      -b|--banner)
        BANNER=true
        BANNER_FILE=$2
        shift
        ;;
      -u|--update)
        UPDATE=true
        ;;
      -l|--license)
        LICENSE=true
        ;;
      -h|--help)
        usage
        exit
        ;;
      *)
        echo "ERROR: unknown parameter: ${1}"
        usage
        exit 1
        ;;
    esac
    shift
  done
}

function ensure_secret_dir_exists() {
  log "Ensuring secrets directory exist"
  mkdir -p "${DIR}/secret"
}

function agree_to_xcode_license() {
  local license=$1

  if [[ $license == true ]]; then
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
  local update=$1

  if [[ $update == true ]]; then
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
    if ! hash brew 2>/dev/null; then
      log 'Install brew first: http://brew.sh'
    else
      log 'Brew detected, installing required packages'
      package 'autojump'
      package 'gh'
      package 'lastpass-cli'
      package 'the_silver_searcher'
    fi
  fi
}

function install_banner() {
  local banner=$1
  local banner_file=$2

  if [[ $banner == true ]]; then
    local banner_dir="$DIR/bash/header"
    if [[ ! -f "${banner_dir}/${banner_file}" ]]; then
      log "Banner ${banner_file} doesnt exist, available banners:"
      ls ${banner_dir}
    else
      log "Installing banner: ${banner_file}"
      link "${HOME}/.bash_header" "${banner_dir}/${banner_file}"
    fi
  fi
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

