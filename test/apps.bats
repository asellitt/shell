#!/usr/bin/env bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

setup() {
  source "${BATS_TEST_DIRNAME}/../lib/log.sh"
  source "${BATS_TEST_DIRNAME}/../lib/platform.sh"
  source "${BATS_TEST_DIRNAME}/../lib/manifest.sh"
  source "${BATS_TEST_DIRNAME}/../lib/apps.sh"

  # Capture installer calls rather than running them
  brew()    { echo "brew $*";    }
  apt()     { echo "apt $*";     }
  flatpak() { echo "flatpak $*"; }
  export -f brew apt flatpak

  FIXTURE_DIR="${BATS_TEST_DIRNAME}/fixtures"
}

# --- app_install routing ---

@test "app_install calls brew on macos" {
  UNAME_CMD="echo Darwin"
  run app_install "firefox" "$FIXTURE_DIR/apps_test.conf"
  assert_success
  assert_output --partial "brew install firefox"
}

@test "app_install calls apt on ubuntu" {
  UNAME_CMD="echo Linux"
  OS_RELEASE_ID="ubuntu"
  run app_install "firefox" "$FIXTURE_DIR/apps_test.conf"
  assert_success
  assert_output --partial "apt install -y firefox"
}

@test "app_install calls flatpak on steamos" {
  UNAME_CMD="echo Linux"
  OS_RELEASE_ID="steamos"
  run app_install "firefox" "$FIXTURE_DIR/apps_test.conf"
  assert_success
  assert_output --partial "flatpak install -y flathub org.mozilla.firefox"
}

@test "app_install uses apt name override on ubuntu" {
  UNAME_CMD="echo Linux"
  OS_RELEASE_ID="ubuntu"
  run app_install "the-silver-searcher" "$FIXTURE_DIR/apps_test.conf"
  assert_success
  assert_output --partial "apt install -y silversearcher-ag"
}

@test "app_install skips silently when no flatpak id on steamos" {
  UNAME_CMD="echo Linux"
  OS_RELEASE_ID="steamos"
  run app_install "the-silver-searcher" "$FIXTURE_DIR/apps_test.conf"
  assert_success
  assert_output --partial "skip"
}

@test "app_install fails gracefully for unknown package" {
  UNAME_CMD="echo Darwin"
  run app_install "nonexistent-package" "$FIXTURE_DIR/apps_test.conf"
  assert_failure
  assert_output --partial "unknown app"
}

# --- app_update ---

@test "app_update calls brew upgrade on macos" {
  UNAME_CMD="echo Darwin"
  run app_update
  assert_success
  assert_output --partial "brew upgrade"
}

@test "app_update calls apt upgrade on ubuntu" {
  UNAME_CMD="echo Linux"
  OS_RELEASE_ID="ubuntu"
  run app_update
  assert_success
  assert_output --partial "apt upgrade"
}

@test "app_update calls flatpak update on steamos" {
  UNAME_CMD="echo Linux"
  OS_RELEASE_ID="steamos"
  run app_update
  assert_success
  assert_output --partial "flatpak update"
}
