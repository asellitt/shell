#! /bin/bash
PREFIX="INSTALL"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${DIR}/install/functions.sh"

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


log "Linking dotfiles"

ensure_secret_dir_exists
agree_to_xcode_license $LICENSE
update_packages $UPDATE
install_required_packages
log_into_lastpass

source $DIR/install/modules.sh

install_banner $BANNER $BANNER_FILE
