#!/usr/bin/env bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

setup() {
  source "${BATS_TEST_DIRNAME}/../lib/log.sh"
}

# --- log ---

@test "log outputs the module name and message" {
  run log "git" "Installing config"
  assert_success
  assert_output --partial "git"
  assert_output --partial "Installing config"
}

@test "log outputs message in [module] format" {
  run log "shell" "Begin setup"
  assert_success
  assert_output --regexp "\[.*shell.*\].*Begin setup"
}

@test "log accepts any module name" {
  run log "osx" "some message"
  assert_success
  assert_output --partial "osx"
}

# --- log_warn ---

@test "log_warn includes a warning indicator" {
  run log_warn "git" "skipping config"
  assert_success
  assert_output --partial "WARN"
  assert_output --partial "skipping config"
}

# --- log_error ---

@test "log_error includes an error indicator" {
  run log_error "git" "something went wrong"
  assert_success
  assert_output --partial "ERROR"
  assert_output --partial "something went wrong"
}
