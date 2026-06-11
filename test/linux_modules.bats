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

  # Stub external commands
  flatpak()    { echo "flatpak $*"; }
  add-apt-repository() { echo "add-apt-repository $*"; }
  apt-key()    { echo "apt-key $*"; }
  curl()       { echo "curl $*"; }
  export -f flatpak add-apt-repository apt-key curl
}

teardown() {
  rm -rf "$TEST_TMPDIR"
}

# --- ubuntu module_supported ---

@test "ubuntu module_supported returns true on ubuntu" {
  UNAME_CMD="echo Linux"
  OS_RELEASE_ID="ubuntu"
  source "${BATS_TEST_DIRNAME}/../modules/ubuntu/config.sh"
  run module_supported
  assert_success
}

@test "ubuntu module_supported returns false on macos" {
  UNAME_CMD="echo Darwin"
  source "${BATS_TEST_DIRNAME}/../modules/ubuntu/config.sh"
  run module_supported
  assert_failure
}

@test "ubuntu module_supported returns false on steamos" {
  UNAME_CMD="echo Linux"
  OS_RELEASE_ID="steamos"
  source "${BATS_TEST_DIRNAME}/../modules/ubuntu/config.sh"
  run module_supported
  assert_failure
}

# --- steamos module_supported ---

@test "steamos module_supported returns true on steamos" {
  UNAME_CMD="echo Linux"
  OS_RELEASE_ID="steamos"
  source "${BATS_TEST_DIRNAME}/../modules/steamos/config.sh"
  run module_supported
  assert_success
}

@test "steamos module_supported returns false on macos" {
  UNAME_CMD="echo Darwin"
  source "${BATS_TEST_DIRNAME}/../modules/steamos/config.sh"
  run module_supported
  assert_failure
}

@test "steamos module_supported returns false on ubuntu" {
  UNAME_CMD="echo Linux"
  OS_RELEASE_ID="ubuntu"
  source "${BATS_TEST_DIRNAME}/../modules/steamos/config.sh"
  run module_supported
  assert_failure
}

# --- steamos module_install ---

@test "steamos module_install adds flathub remote" {
  UNAME_CMD="echo Linux"
  OS_RELEASE_ID="steamos"
  DOTFILES_DIR="$TEST_TMPDIR"
  source "${BATS_TEST_DIRNAME}/../modules/steamos/config.sh"
  run module_install
  assert_success
  assert_output --partial "flathub"
}

# --- apps/config.sh loads platform manifest ---

@test "apps module_supported returns false when INSTALL is not true" {
  INSTALL="false"
  source "${BATS_TEST_DIRNAME}/../modules/apps/config.sh"
  run module_supported
  assert_failure
}

@test "apps module_supported returns true when INSTALL is true" {
  INSTALL="true"
  source "${BATS_TEST_DIRNAME}/../modules/apps/config.sh"
  run module_supported
  assert_success
}

@test "apps module_install loads macos platform manifest on macos" {
  UNAME_CMD="echo Darwin"
  OS_RELEASE_ID=""
  DOTFILES_DIR="$TEST_TMPDIR"

  mkdir -p "$TEST_TMPDIR/modules/apps"
  echo "# common" > "$TEST_TMPDIR/modules/apps/common.conf"
  cat > "$TEST_TMPDIR/modules/apps/macos.conf" <<'EOF'
macos-only-app    -    -
EOF

  app_install() { echo "app_install $*"; }
  app_update()  { echo "app_update $*"; }
  export -f app_install app_update

  source "${BATS_TEST_DIRNAME}/../modules/apps/config.sh"
  UPDATE="false" MODE="PERSONAL" run module_install
  assert_output --partial "macos-only-app"
}

@test "apps module_install loads ubuntu platform manifest on ubuntu" {
  UNAME_CMD="echo Linux"
  OS_RELEASE_ID="ubuntu"
  DOTFILES_DIR="$TEST_TMPDIR"

  mkdir -p "$TEST_TMPDIR/modules/apps"
  echo "# common" > "$TEST_TMPDIR/modules/apps/common.conf"
  cat > "$TEST_TMPDIR/modules/apps/ubuntu.conf" <<'EOF'
ubuntu-only-app    ubuntu-only-app    -
EOF

  app_install() { echo "app_install $*"; }
  app_update()  { echo "app_update $*"; }
  export -f app_install app_update

  source "${BATS_TEST_DIRNAME}/../modules/apps/config.sh"
  UPDATE="false" MODE="PERSONAL" run module_install
  assert_output --partial "ubuntu-only-app"
}
