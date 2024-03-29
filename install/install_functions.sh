#! /bin/zsh

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
      -i|--install)
        INSTALL=true
        ;;
      -m|--mode)
        MODE=$2
        shift
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

function create_symlinked_executable() {
  local dotfiles_dir="${DOTFILES_DIR}"
  local executable_dir="${DOTFILES_DIR}/shell/path"

  log "Creating executable"
  link "${executable_dir}/dotfiles" "${dotfiles_dir}/install.sh"
}

function ensure_secret_dir_exists() {
  log "Ensuring secrets directory exist"
  mkdir -p "${DOTFILES_DIR}/secret"
}

function agree_to_xcode_license() {
  local license=$1

  if [[ $license == true ]]; then
    if [ `uname`=="Darwin" ]; then
      log "OSX detected"
      log "Agreeing to xcode license"
      sudo xcode-select --reset
      sudo xcode-select --install
      sudo xcodebuild -license
    fi
  fi
}

function log_into_password_manager() {
  PREFIX="BITWARDEN"
  if hash bw 2>/dev/null && hash jq 2>/dev/null; then
    case $(bw status | jq -r ".status") in
      "unauthenticated")
        log "Bitwarden installed, logging in"
        bw login
        ;;
      "locked")
        log "Bitwarden installed, unlocking"
        bw unlock
        ;;
      "unlocked")
        log "Bitwarden logged in"
        ;;
      *)
        log 'Bitwarden status returned an unexpected state'
    esac
    log "Syncing bitwarden vault"
    bw sync
  fi
}

function update_packages() {
  local update=$1

  if [[ $update == true ]]; then
    if hash brew 2>/dev/null; then
      log "Brew installed, updating brew"
      brew update -v
      brew upgrade -v
    else
      log "Brew not installed, installing brew"
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    if [[ -f "~/.zshrc" ]]; then
      source ~/.zshrc
    fi
    if [[ -f "~/.bashrc" ]]; then
      source ~/.bashrc
    fi
  fi
}

function install_banner() {
  local banner=$1
  local banner_file=$2

  if [[ $banner == true ]]; then
    local banner_dir="${DOTFILES_DIR}/shell/header"
    if [[ ! -f "${banner_dir}/${banner_file}" ]]; then
      log "Banner ${banner_file} doesnt exist, available banners:"
      ls ${banner_dir}
    else
      log "Installing banner: ${banner_file}"
      link "${HOME}/.header" "${banner_dir}/${banner_file}"
    fi
  fi
}

function install_modules() {
  log "Finding compatible modules in: ${DOTFILES_DIR}"

  for shell_modules in ${DOTFILES_DIR}/*/ ; do
    local shell_module="${shell_modules%/}"
    local module_config="${shell_module}/config.sh"

    if [ -f "$module_config" ]; then
      PREFIX="INSTALL"
      log "Installing '${shell_module}' config"
      source $module_config
    fi
  done
}
