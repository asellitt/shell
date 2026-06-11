#!/usr/bin/env bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

setup() {
  source "${BATS_TEST_DIRNAME}/../lib/log.sh"
  source "${BATS_TEST_DIRNAME}/../lib/platform.sh"
  source "${BATS_TEST_DIRNAME}/../lib/link.sh"
  source "${BATS_TEST_DIRNAME}/../lib/manifest.sh"
  source "${BATS_TEST_DIRNAME}/../lib/apps.sh"

  TEST_TMPDIR="$(mktemp -d)"
  DOTFILES_DIR="${BATS_TEST_DIRNAME}/.."

  brew()        { echo "brew $*"; }
  apt()         { echo "apt $*"; }
  curl()        { echo "curl $*" >&2; cat /dev/null; }
  sudo()        { echo "sudo $*"; }
  lsb_release() { echo "jammy"; }
  export -f brew apt curl sudo lsb_release
}

teardown() {
  rm -rf "$TEST_TMPDIR"
}

@test "module_supported returns true on macos in personal mode" {
  UNAME_CMD="echo Darwin"
  MODE="PERSONAL"
  source "${BATS_TEST_DIRNAME}/../modules/tailscale/config.sh"
  run module_supported
  assert_success
}

@test "module_supported returns false on macos in work mode" {
  UNAME_CMD="echo Darwin"
  MODE="WORK"
  source "${BATS_TEST_DIRNAME}/../modules/tailscale/config.sh"
  run module_supported
  assert_failure
}

@test "module_supported returns true on ubuntu in personal mode" {
  UNAME_CMD="echo Linux"
  OS_RELEASE_ID="ubuntu"
  MODE="PERSONAL"
  source "${BATS_TEST_DIRNAME}/../modules/tailscale/config.sh"
  run module_supported
  assert_success
}

@test "module_supported returns false on ubuntu in work mode" {
  UNAME_CMD="echo Linux"
  OS_RELEASE_ID="ubuntu"
  MODE="WORK"
  source "${BATS_TEST_DIRNAME}/../modules/tailscale/config.sh"
  run module_supported
  assert_failure
}

@test "module_supported returns false on steamos" {
  UNAME_CMD="echo Linux"
  OS_RELEASE_ID="steamos"
  MODE="PERSONAL"
  source "${BATS_TEST_DIRNAME}/../modules/tailscale/config.sh"
  run module_supported
  assert_failure
}

@test "module_install uses brew on macos" {
  UNAME_CMD="echo Darwin"
  source "${BATS_TEST_DIRNAME}/../modules/tailscale/config.sh"
  run module_install
  assert_success
  assert_output --partial "brew install tailscale"
}

@test "module_install adds repo and installs on ubuntu when repo absent" {
  UNAME_CMD="echo Linux"
  OS_RELEASE_ID="ubuntu"
  source "${BATS_TEST_DIRNAME}/../modules/tailscale/config.sh"
  run module_install
  assert_success
  assert_output --partial "jammy"
  assert_output --partial "sudo tee"
  assert_output --partial "apt install -y tailscale"
}

@test "module_install skips repo setup on ubuntu when repo already present" {
  UNAME_CMD="echo Linux"
  OS_RELEASE_ID="ubuntu"
  touch "$TEST_TMPDIR/tailscale.list"
  TAILSCALE_SOURCES_LIST="$TEST_TMPDIR/tailscale.list"
  source "${BATS_TEST_DIRNAME}/../modules/tailscale/config.sh"
  run module_install
  assert_success
  refute_output --partial "sudo tee"
  assert_output --partial "apt install -y tailscale"
}
