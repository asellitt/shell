#!/usr/bin/env bash

_parse_manifest_line() {
  local line="$1"
  [[ "$line" =~ ^[[:space:]]*# ]] && return 1
  [[ -z "${line// }" ]]           && return 1
  return 0
}

# Resolve the install name for the current platform from a manifest file.
# Returns '-' if the app is known but unavailable on this platform.
# Returns '' if the app is not in the manifest at all.
resolve_app_name() {
  local app="$1"
  local manifest="$2"
  local os
  os="$(detect_os)"

  while IFS= read -r raw_line; do
    _parse_manifest_line "$raw_line" || continue

    local name apt_name flatpak_id
    name="$(      echo "$raw_line" | awk '{print $1}')"
    apt_name="$(  echo "$raw_line" | awk '{print $2}')"
    flatpak_id="$(echo "$raw_line" | awk '{print $3}')"

    [[ "$name" != "$app" ]] && continue

    case "$os" in
      macos)
        echo "$name"
        ;;
      ubuntu)
        if [[ -n "$apt_name" && "$apt_name" != "-" ]]; then
          echo "$apt_name"
        else
          echo "-"
        fi
        ;;
      steamos)
        if [[ -n "$flatpak_id" && "$flatpak_id" != "-" ]]; then
          echo "$flatpak_id"
        else
          echo "-"
        fi
        ;;
    esac
    return 0
  done < "$manifest"

  echo ""
}
