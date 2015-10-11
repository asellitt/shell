#! /bin/bash
exec_loc=$(readlink $0 || realpath $0)
DOTFILES_DIR=$(dirname $exec_loc)
source "${DOTFILES_DIR}/install/util_functions.sh"
source "${DOTFILES_DIR}/install/install_functions.sh"

PREFIX="INSTALL"

parse_commandline_arguments $@

log "Linking dotfiles"

create_symlinked_executable
ensure_secret_dir_exists
agree_to_xcode_license $LICENSE
update_packages $UPDATE
install_required_packages
log_into_lastpass
install_banner $BANNER $BANNER_FILE
install_modules
