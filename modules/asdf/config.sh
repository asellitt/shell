#!/usr/bin/env bash

module_supported() { return 0; }

module_install() {
  log "asdf" "Installing asdf"
  install_from_manifest "${DOTFILES_DIR}/modules/asdf/install.conf"

  if is_macos; then
    local asdf_sh
    asdf_sh="$(brew --prefix asdf 2>/dev/null)/libexec/asdf.sh"
    [[ -f "$asdf_sh" ]] && source "$asdf_sh"
  fi

  link "${HOME}/.tool-versions" "${DOTFILES_DIR}/modules/asdf/tool-versions"
  link "${HOME}/.asdfrc"        "${DOTFILES_DIR}/modules/asdf/rc"

  if ! hash asdf 2>/dev/null; then
    log_warn "asdf" "asdf not found after install, skipping plugins"
    return 0
  fi

  log "asdf" "Installing asdf plugins"
  asdf plugin add ruby    https://github.com/asdf-vm/asdf-ruby.git    2>/dev/null || true
  asdf plugin add erlang  https://github.com/asdf-vm/asdf-erlang.git  2>/dev/null || true
  asdf plugin add elixir  https://github.com/asdf-vm/asdf-elixir.git  2>/dev/null || true

  if [[ "$MODE" == "PERSONAL" ]]; then
    asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git 2>/dev/null || true
    asdf plugin add yarn                                               2>/dev/null || true
    asdf plugin add python                                             2>/dev/null || true
    asdf plugin add bun                                                2>/dev/null || true
  fi

  if [[ "$UPDATE" == "true" ]]; then
    log "asdf" "Updating asdf plugins and versions"
    asdf plugin update --all
    asdf install
  fi
}
