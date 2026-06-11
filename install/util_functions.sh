#!/usr/bin/env bash

usage() {
  echo "asellitt's dotfiles install script"
  echo ""
  echo "usage: dotfiles [-b|--banner <bannerFile>]  Sets up a terminal banner"
  echo "                [-b|--banner --list]               Lists available banners"
  echo "                [-b|--banner --preview]            Previews all banners"
  echo "                [-b|--banner --preview <name>]     Previews a specific banner"
  echo "                [-h|--help]                 Prints this message"
  echo "                [-u|--update]               Updates dependencies"
  echo "                [-i|--install]              Installs apps"
  echo "                [-d|--dry-run]              Show what would be installed/updated without doing it"
  echo "                [-l|--license]              Open the apple license dialog"
  echo "                [-m|--mode <WORK|PERSONAL>] Sets install mode"
  echo ""
}

parse_commandline_arguments() {
  while [[ "$1" != "" ]]; do
    case $1 in
      -b|--banner)
        if [[ "$2" == "--list" ]]; then
          BANNER=list
        elif [[ "$2" == "--preview" ]]; then
          BANNER=preview
          if [[ -n "$3" && "$3" != -* ]]; then BANNER_FILE=$3; shift; fi
        else
          BANNER=true; BANNER_FILE=$2
        fi
        shift ;;
      -u|--update)   UPDATE=true ;;
      -i|--install)  INSTALL=true ;;
      -d|--dry-run)  DRY_RUN=true ;;
      -l|--license) LICENSE=true ;;
      -m|--mode)    MODE=$2; shift ;;
      -h|--help)    usage; exit ;;
      *)            log_error "install" "unknown parameter: $1"; usage; exit 1 ;;
    esac
    shift
  done

  if [[ "$INSTALL" == "true" && -z "$MODE" ]]; then
    log_error "install" "-i|--install requires -m|--mode <WORK|PERSONAL>"
    usage
    exit 1
  fi
}

create_symlinked_executable() {
  log "install" "Creating dotfiles executable"
  link "${DOTFILES_DIR}/modules/shell/path/dotfiles" "${DOTFILES_DIR}/install.sh"
}

ensure_secret_dir_exists() {
  log "install" "Ensuring secrets directory exists"
  mkdir -p "${DOTFILES_DIR}/secret"
}

agree_to_xcode_license() {
  local license=$1
  if [[ "$license" == "true" ]] && is_macos; then
    log "install" "Agreeing to Xcode license"
    sudo xcode-select --reset
    sudo xcode-select --install
    sudo xcodebuild -license
  fi
}

log_into_password_manager() {
  if ! hash bw 2>/dev/null || ! hash jq 2>/dev/null; then
    return 0
  fi
  local status
  status="$(bw status | jq -r '.status')"
  case "$status" in
    unauthenticated) log "bitwarden" "Logging in";  bw login ;;
    locked)          log "bitwarden" "Unlocking";   bw unlock ;;
    unlocked)        log "bitwarden" "Already unlocked" ;;
    *)               log_warn "bitwarden" "Unexpected status: $status" ;;
  esac
  bw sync
}

install_banner() {
  local banner=$1
  local banner_file=$2
  local banner_dir="${DOTFILES_DIR}/modules/shell/header"

  if [[ "$banner" == "list" ]]; then
    log "install" "Available banners:"
    ls "$banner_dir"
    return 0
  fi

  if [[ "$banner" == "preview" ]]; then
    local files
    if [[ -n "$banner_file" ]]; then
      files=("${banner_dir}/${banner_file}")
      if [[ ! -f "${files[0]}" ]]; then
        log_error "install" "Banner '${banner_file}' not found. Available:"
        ls "$banner_dir"
        return 1
      fi
    else
      files=("$banner_dir"/*)
    fi
    for f in "${files[@]}"; do
      echo "--- $(basename "$f") ---"
      if grep -q 'echo' "$f"; then
        clear() { :; }
        source "$f"
        unset -f clear
        echo ""
      else
        cat "$f"
      fi
      echo ""
    done
    return 0
  fi

  if [[ "$banner" != "true" ]]; then return 0; fi

  if [[ ! -f "${banner_dir}/${banner_file}" ]]; then
    log_error "install" "Banner '${banner_file}' not found. Available:"
    ls "${banner_dir}"
    return 1
  fi
  log "install" "Installing banner: ${banner_file}"
  link "${HOME}/.header" "${banner_dir}/${banner_file}"
}

_post_install_messages=()

post_install_message() {
  local module="$1"
  local message="$2"
  _post_install_messages+=("${module}|${message}")
}

print_post_install_messages() {
  if [[ ${#_post_install_messages[@]} -eq 0 ]]; then return 0; fi
  echo ""
  log "install" "Post-install notes:"
  echo ""
  local entry
  for entry in "${_post_install_messages[@]}"; do
    local module="${entry%%|*}"
    local message="${entry#*|}"
    log "$module" "$message"
  done
}
