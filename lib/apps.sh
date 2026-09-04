#!/usr/bin/env bash

install_from_manifest() {
  local manifest="$1"
  [[ -f "$manifest" ]] || return 0
  while IFS= read -r line; do
    [[ "$line" =~ ^[[:space:]]*# ]] && continue
    [[ -z "${line// }" ]]           && continue
    local name
    name="$(echo "$line" | awk '{print $1}')"
    app_install "$name" "$manifest"
  done < "$manifest"
}

brew_preclean_python() {
  local prefix outdated formula version site_dir
  prefix="$(brew --prefix)"
  outdated="$(brew outdated --formula --quiet | grep '^python@' || true)"
  [[ -z "$outdated" ]] && return 0

  for formula in $outdated; do
    version="${formula#python@}"
    site_dir="${prefix}/lib/python${version}/site-packages"
    [[ -d "$site_dir" ]] || continue
    log "apps" "Pre-cleaning ${site_dir} for fast ${formula} upgrade"
    rm -rf "$site_dir"/pip "$site_dir"/pip-*.dist-info \
           "$site_dir"/wheel "$site_dir"/wheel-*.dist-info \
           "$site_dir"/setuptools "$site_dir"/setuptools-*.dist-info \
           "$site_dir"/pkg_resources "$site_dir"/_distutils_hack \
           "$site_dir"/distutils-precedence.pth
  done
}

app_install() {
  local app="$1"
  local manifest="${2:-${DOTFILES_DIR}/modules/apps/common.conf}"
  local os resolved

  os="$(detect_os)"
  resolved="$(resolve_app_name "$app" "$manifest")"

  if [[ -z "$resolved" ]]; then
    log_error "apps" "unknown app: $app"
    return 1
  fi

  if [[ "$resolved" == "-" ]]; then
    log "apps" "skip: $app (not available on $os)"
    return 0
  fi

  if [[ "$DRY_RUN" == "true" ]]; then
    log "apps" "dry-run: would install $resolved"
    return 0
  fi

  case "$os" in
    macos)   brew_install "$resolved" ;;
    ubuntu)  apt install -y "$resolved" ;;
    steamos) flatpak install -y flathub "$resolved" ;;
    *)
      log_error "apps" "unsupported platform: $os"
      return 1
      ;;
  esac
}

brew_install() {
  local output
  output="$(brew install "$1" 2>&1)"
  local rc=$?

  if echo "$output" | grep -q 'brew trust --formula'; then
    local trust_cmds
    trust_cmds="$(echo "$output" | grep 'brew trust --formula' | grep -v '<')"
    while IFS= read -r cmd; do
      [[ -z "$cmd" ]] && continue
      cmd="${cmd#"${cmd%%[![:space:]]*}"}"
      log "apps" "Running: $cmd"
      eval "$cmd"
    done <<< "$trust_cmds"
  fi

  if [[ $rc -ne 0 ]]; then
    echo "$output" >&2
    return $rc
  else
    echo "$output"
  fi
}

app_update() {
  local os
  os="$(detect_os)"

  if [[ "$DRY_RUN" == "true" ]]; then
    log "apps" "dry-run: would run update on $os"
    return 0
  fi

  case "$os" in
    macos)  
      log "apps" "Updating Homebrew (this may take a while)"
      brew update
      brew_preclean_python
      log "apps" "Upgrading Homebrew (this may take a while)"
      brew upgrade -v
      ;;
    ubuntu)  apt upgrade -y ;;
    steamos) flatpak update -y ;;
    *)
      log_error "apps" "unsupported platform: $os"
      return 1
      ;;
  esac
}
