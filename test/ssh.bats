#!/usr/bin/env bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

setup() {
  source "${BATS_TEST_DIRNAME}/../lib/log.sh"
  source "${BATS_TEST_DIRNAME}/../lib/platform.sh"
  source "${BATS_TEST_DIRNAME}/../lib/link.sh"

  TEST_TMPDIR="$(mktemp -d)"
  HOME="$TEST_TMPDIR"
  DOTFILES_DIR="${BATS_TEST_DIRNAME}/.."

  mkdir -p "$TEST_TMPDIR/.ssh"
}

teardown() {
  rm -rf "$TEST_TMPDIR"
}

@test "module_install creates ~/.ssh/config if it does not exist" {
  source "${BATS_TEST_DIRNAME}/../modules/ssh/config.sh"
  run module_install
  assert_success
  assert [ -f "$TEST_TMPDIR/.ssh/config" ]
}

@test "module_install appends Include directive when config is empty" {
  source "${BATS_TEST_DIRNAME}/../modules/ssh/config.sh"
  run module_install
  assert_success
  grep -q "Include ~/.ssh/machinespecific.config" "$TEST_TMPDIR/.ssh/config"
}

@test "module_install does not duplicate Include if already present" {
  echo "Include ~/.ssh/machinespecific.config" > "$TEST_TMPDIR/.ssh/config"
  source "${BATS_TEST_DIRNAME}/../modules/ssh/config.sh"
  run module_install
  assert_success
  assert_equal "$(grep -c 'Include ~/.ssh/machinespecific.config' "$TEST_TMPDIR/.ssh/config")" "1"
}

@test "module_install preserves existing config content" {
  echo "Host myserver" > "$TEST_TMPDIR/.ssh/config"
  echo "  User admin" >> "$TEST_TMPDIR/.ssh/config"
  source "${BATS_TEST_DIRNAME}/../modules/ssh/config.sh"
  run module_install
  assert_success
  grep -q "Host myserver" "$TEST_TMPDIR/.ssh/config"
}

@test "module_supported returns true" {
  source "${BATS_TEST_DIRNAME}/../modules/ssh/config.sh"
  run module_supported
  assert_success
}
