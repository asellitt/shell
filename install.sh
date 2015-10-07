#! /bin/bash
PREFIX="INSTALL"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SWITCHES=$@
source "${DIR}/install/functions.sh"

log "Linking dotfiles"
parse_commandline_arguments $SWITCHES
ensure_secret_dir_exists
agree_to_xcode_license $LICENSE
update_packages $UPDATE
install_required_packages
log_into_lastpass

source $DIR/install/modules.sh

install_banner $BANNER $BANNER_FILE
