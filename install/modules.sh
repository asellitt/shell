#!/usr/bin/env bash

run_module() {
  local mod_dir="$1"
  local dotfiles_dir="$2"
  local os="$3"
  local mode="$4"
  local update="$5"
  local install="$6"
  local dry_run="$7"

  local config="${mod_dir}/config.sh"
  local mod_name
  mod_name="$(basename "$mod_dir")"

  if [[ ! -f "$config" ]]; then
    log_error "modules" "no config.sh found in $mod_dir"
    return 1
  fi

  # Expose context as locals the module can read
  local DOTFILES_DIR="$dotfiles_dir"
  local OS="$os"
  local MODE="$mode"
  local UPDATE="$update"
  local INSTALL="$install"
  local DRY_RUN="$dry_run"

  # Source the module — it must define module_supported and module_install
  source "$config"

  if ! module_supported; then
    log "modules" "skip: $mod_name (not supported on $os)"
    return 0
  fi

  log "modules" "installing: $mod_name"
  module_install
}

install_modules() {
  local dotfiles_dir="$1"
  local os="$2"
  local mode="$3"
  local update="$4"
  local install="$5"
  local dry_run="$6"

  for mod_dir in "$dotfiles_dir"/modules/*/; do
    mod_dir="${mod_dir%/}"
    [[ -f "${mod_dir}/config.sh" ]] || continue
    run_module "$mod_dir" "$dotfiles_dir" "$os" "$mode" "$update" "$install" "$dry_run"
  done
}
