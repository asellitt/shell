#!/usr/bin/env bash

link() {
  local target="$1"
  local src="$2"

  if [[ ! -e "$src" ]]; then
    log_error "link" "source does not exist: $src"
    return 1
  fi

  rm -f "$target"
  ln -s "$src" "$target"
}
