#! /bin/bash

exec_loc=$(readlink $0 || realpath $0)
DOTFILES_DIR=$(dirname $exec_loc)
if [ -z "$DOTFILES_DIR" ] ; then
  DOTFILES_DIR="`dirname \"$0\"`"
  DOTFILES_DIR="`( cd \"$DOTFILES_DIR\" && pwd )`"
  if [ -z "$DOTFILES_DIR" ] ; then
    echo "Could not determine script location"
    exit 1
  fi
fi

source "${DOTFILES_DIR}/install/util_functions.sh"
source "${DOTFILES_DIR}/install/install_functions.sh"

PREFIX="INSTALL"

parse_commandline_arguments $@

log "Linking dotfiles"

create_symlinked_executable
ensure_secret_dir_exists
agree_to_xcode_license $LICENSE
update_packages $UPDATE
install_banner $BANNER $BANNER_FILE
install_modules
log_into_lastpass
print_post_install_messages

exit 0
