#!/usr/bin/env bash

DOTFILES_DIR="$(cd "$(dirname "$(readlink -f "$0" 2>/dev/null || echo "$0")")" && pwd)"

source "${DOTFILES_DIR}/lib/log.sh"
source "${DOTFILES_DIR}/lib/platform.sh"
source "${DOTFILES_DIR}/lib/link.sh"
source "${DOTFILES_DIR}/lib/manifest.sh"
source "${DOTFILES_DIR}/lib/apps.sh"
source "${DOTFILES_DIR}/install/util_functions.sh"
source "${DOTFILES_DIR}/install/modules.sh"

OS="$(detect_os)"

parse_commandline_arguments "$@"

if [[ "$BANNER" == "true" || "$BANNER" == "list" || "$BANNER" == "preview" ]]; then
  install_banner "$BANNER" "$BANNER_FILE"
  exit 0
fi

log "install" "Detected OS: $OS"
log "install" "Linking dotfiles"
create_symlinked_executable

ensure_secret_dir_exists
agree_to_xcode_license "$LICENSE"
log_into_password_manager
install_modules "$DOTFILES_DIR" "$OS" "$MODE" "$UPDATE" "$INSTALL" "$DRY_RUN"
print_post_install_messages

exit 0
