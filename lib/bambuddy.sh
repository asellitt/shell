#!/usr/bin/env bash

# Prints the path to a local copy of the CA. Reuses a cache fetched in the
# last 5 minutes so both slicer modules share one fetch per install run.
_bambuddy_fetch_ca() {
  local bambuddy_bw_item="f33c48f6-df15-4bbd-acf5-b4c00021c8ab"
  local cache="/tmp/.bambuddy-ca-cache.crt"

  if [[ -f "$cache" && $(( $(date +%s) - $(stat -f%m "$cache") )) -lt 300 ]]; then
    echo "$cache"
    return 0
  fi

  if [[ -z "$BW_SESSION" ]]; then
    log_error "bambuddy" "no Bitwarden session — cannot fetch API key" >&2
    return 1
  fi

  local api_key
  api_key="$(bw get notes "$bambuddy_bw_item" --session "$BW_SESSION" | jq -r '.key')" || {
    log_error "bambuddy" "failed to fetch API key from Bitwarden item '$bambuddy_bw_item'" >&2
    return 1
  }

  local bambuddy_url
  bambuddy_url="$(bw get notes "$bambuddy_bw_item" --session "$BW_SESSION" | jq -r '.host')" || {
    log_error "bambuddy" "failed to fetch url from Bitwarden item '$bambuddy_bw_item'" >&2
    return 1
  }

  local response
  if ! response="$(curl -fsS --connect-timeout 5 -H "X-API-Key: ${api_key}" \
      "${bambuddy_url}/api/v1/virtual-printers/ca-certificate")"; then
    log_error "bambuddy" "fetch failed — check the API key and ${bambuddy_url}" >&2
    return 1
  fi

  printf '%s' "$response" | jq -r '.pem // empty' > "$cache"
  if [[ ! -s "$cache" ]]; then
    log_error "bambuddy" "response has no 'pem' field — got: ${response:0:120}" >&2
    rm -f "$cache"
    return 1
  fi

  echo "$cache"
}

# Appends the Bambuddy CA to ${cert_dir}/printer.cer. Idempotent; warns and
# returns 0 on any problem so an unreachable Bambuddy never fails the install.
bambuddy_trust_ca() {
  local slicer_name="$1"
  local cert_dir="$2"
  local cert_path="${cert_dir}/printer.cer"

  if [[ ! -f "$cert_path" ]]; then
    log_warn "bambuddy" "${slicer_name}: no printer.cer in ${cert_dir} — skipping"
    return 0
  fi

  if [[ "$DRY_RUN" == "true" ]]; then
    log "bambuddy" "dry-run: would append Bambuddy CA to ${cert_path}"
    return 0
  fi

  local ca_file
  ca_file="$(_bambuddy_fetch_ca)" || {
    log_warn "bambuddy" "${slicer_name}: could not fetch Bambuddy CA — skipping"
    return 0
  }

  # First base64 line of the CA is enough to detect a prior append
  local marker
  marker="$(grep -m1 -A1 'BEGIN CERTIFICATE' "$ca_file" | tail -n1)"
  if [[ -z "$marker" ]]; then
    log_warn "bambuddy" "fetched CA is not a PEM certificate — skipping"
    return 0
  fi
  if grep -qF "$marker" "$cert_path"; then
    log "bambuddy" "${slicer_name}: Bambuddy CA already present"
    return 0
  fi

  # File is clean, so this backup is the pristine original
  cp "$cert_path" "${cert_path}.bak"

  # Ensure trailing newline before appending
  [[ -n "$(tail -c1 "$cert_path")" ]] && echo >> "$cert_path"
  cat "$ca_file" >> "$cert_path"

  log "bambuddy" "${slicer_name}: appended Bambuddy CA ($(grep -c 'BEGIN CERTIFICATE' "$cert_path") certs in bundle) — fully quit and relaunch it"
}
