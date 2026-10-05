#!/usr/bin/env bash

link() {
  local target="$1"
  local src="$2"

  if [[ ! -e "$src" ]]; then
    log_error "link" "source does not exist: $src"
    return 1
  fi

  if [[ -e "$target" && ! -L "$target" ]]; then
    log_warn "link" "not a symlink, leaving in place: $target"
    return 0
  fi

  rm -f "$target"
  ln -s "$src" "$target"
}
