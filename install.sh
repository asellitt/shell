#! /bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${DIR}/install/util_functions.sh"
source "${DIR}/install/install_functions.sh"

PREFIX="INSTALL"
SWITCHES=$@

parse_commandline_arguments $SWITCHES

log "Linking dotfiles"
create_symlinked_executable
ensure_secret_dir_exists
agree_to_xcode_license $LICENSE
update_packages $UPDATE
install_required_packages
log_into_lastpass
install_banner $BANNER $BANNER_FILE
install_modules
