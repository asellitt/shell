#!/usr/bin/env bash

_log_color() {
  local module="$1"
  local hash=5381
  local i
  for (( i=0; i<${#module}; i++ )); do
    hash=$(( (hash * 33) ^ $(printf "%d" "'${module:$i:1}") ))
  done
  # avoid dark/unreadable colours (0-15 and 232-243)
  echo "\033[38;5;$(( 16 + (hash < 0 ? -hash : hash) % 200 ))m"
}

log() {
  local module="$1"
  local message="$2"
  local col reset
  col="$(_log_color "$module")"
  reset="\033[1;0m"
  printf "${reset}[${col}%-7s${reset}] %s\n" "$module" "$message"
}

log_warn() {
  local module="$1"
  local message="$2"
  log "$module" "WARN: $message"
}

log_error() {
  local module="$1"
  local message="$2"
  log "$module" "ERROR: $message"
}
