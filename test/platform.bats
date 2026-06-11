#!/usr/bin/env bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

# Source the library under test, with uname injectable via UNAME_CMD
setup() {
  UNAME_CMD="uname"
  source "${BATS_TEST_DIRNAME}/../lib/platform.sh"
}

# --- detect_os ---

@test "detect_os returns 'macos' on Darwin" {
  UNAME_CMD="echo Darwin"
  run detect_os
  assert_success
  assert_output "macos"
}

@test "detect_os returns 'ubuntu' on Linux with Ubuntu ID" {
  UNAME_CMD="echo Linux"
  OS_RELEASE_ID="ubuntu"
  run detect_os
  assert_success
  assert_output "ubuntu"
}

@test "detect_os returns 'steamos' on Linux with SteamOS ID" {
  UNAME_CMD="echo Linux"
  OS_RELEASE_ID="steamos"
  run detect_os
  assert_success
  assert_output "steamos"
}

@test "detect_os returns 'unknown' for unrecognised Linux distro" {
  UNAME_CMD="echo Linux"
  OS_RELEASE_ID="arch"
  run detect_os
  assert_success
  assert_output "unknown"
}

@test "detect_os returns 'unknown' for unrecognised kernel" {
  UNAME_CMD="echo FreeBSD"
  run detect_os
  assert_success
  assert_output "unknown"
}

# --- is_macos / is_ubuntu / is_steamos ---

@test "is_macos returns true when OS is macos" {
  UNAME_CMD="echo Darwin"
  run is_macos
  assert_success
}

@test "is_macos returns false when OS is ubuntu" {
  UNAME_CMD="echo Linux"
  OS_RELEASE_ID="ubuntu"
  run is_macos
  assert_failure
}

@test "is_ubuntu returns true when OS is ubuntu" {
  UNAME_CMD="echo Linux"
  OS_RELEASE_ID="ubuntu"
  run is_ubuntu
  assert_success
}

@test "is_steamos returns true when OS is steamos" {
  UNAME_CMD="echo Linux"
  OS_RELEASE_ID="steamos"
  run is_steamos
  assert_success
}

# --- is_personal / is_work ---

@test "is_personal returns true when MODE is PERSONAL" {
  MODE="PERSONAL"
  run is_personal
  assert_success
}

@test "is_personal returns false when MODE is WORK" {
  MODE="WORK"
  run is_personal
  assert_failure
}

@test "is_work returns true when MODE is WORK" {
  MODE="WORK"
  run is_work
  assert_success
}

@test "is_work returns false when MODE is PERSONAL" {
  MODE="PERSONAL"
  run is_work
  assert_failure
}
