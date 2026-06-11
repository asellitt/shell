#!/usr/bin/env bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

setup() {
  source "${BATS_TEST_DIRNAME}/../lib/platform.sh"
  source "${BATS_TEST_DIRNAME}/../lib/manifest.sh"
  FIXTURE_DIR="${BATS_TEST_DIRNAME}/fixtures"
}

@test "resolve_app_name returns brew name for macos" {
  UNAME_CMD="echo Darwin"
  run resolve_app_name "the-silver-searcher" "$FIXTURE_DIR/apps_test.conf"
  assert_success
  assert_output "the-silver-searcher"
}

@test "resolve_app_name returns apt override for ubuntu" {
  UNAME_CMD="echo Linux"
  OS_RELEASE_ID="ubuntu"
  run resolve_app_name "the-silver-searcher" "$FIXTURE_DIR/apps_test.conf"
  assert_success
  assert_output "silversearcher-ag"
}

@test "resolve_app_name returns brew name when no apt override for ubuntu" {
  UNAME_CMD="echo Linux"
  OS_RELEASE_ID="ubuntu"
  run resolve_app_name "firefox" "$FIXTURE_DIR/apps_test.conf"
  assert_success
  assert_output "firefox"
}

@test "resolve_app_name returns flatpak id for steamos" {
  UNAME_CMD="echo Linux"
  OS_RELEASE_ID="steamos"
  run resolve_app_name "firefox" "$FIXTURE_DIR/apps_test.conf"
  assert_success
  assert_output "org.mozilla.firefox"
}

@test "resolve_app_name returns '-' when no flatpak id and on steamos" {
  UNAME_CMD="echo Linux"
  OS_RELEASE_ID="steamos"
  run resolve_app_name "the-silver-searcher" "$FIXTURE_DIR/apps_test.conf"
  assert_success
  assert_equal "$output" "-"
}

@test "resolve_app_name returns empty string for unknown package" {
  UNAME_CMD="echo Darwin"
  run resolve_app_name "nonexistent-package" "$FIXTURE_DIR/apps_test.conf"
  assert_success
  assert_output ""
}
