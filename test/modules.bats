#!/usr/bin/env bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

setup() {
  source "${BATS_TEST_DIRNAME}/../lib/log.sh"
  source "${BATS_TEST_DIRNAME}/../lib/platform.sh"
  source "${BATS_TEST_DIRNAME}/../lib/link.sh"
  source "${BATS_TEST_DIRNAME}/../install/modules.sh"

  TEST_TMPDIR="$(mktemp -d)"

  # Stub app_install so modules don't try to invoke brew/apt
  app_install() { echo "app_install $*"; }
  app_update()  { echo "app_update $*";  }
  export -f app_install app_update
}

teardown() {
  rm -rf "$TEST_TMPDIR"
}

# --- run_module ---

@test "run_module sources the module's config.sh" {
  local mod_dir="$TEST_TMPDIR/testmod"
  mkdir -p "$mod_dir"
  cat > "$mod_dir/config.sh" <<'EOF'
module_supported() { return 0; }
module_install()   { echo "testmod installed"; }
EOF

  run run_module "$mod_dir" "$TEST_TMPDIR" "macos" "PERSONAL" "false" "false"
  assert_success
  assert_output --partial "testmod installed"
}

@test "run_module skips module when module_supported returns false" {
  local mod_dir="$TEST_TMPDIR/skipmod"
  mkdir -p "$mod_dir"
  cat > "$mod_dir/config.sh" <<'EOF'
module_supported() { return 1; }
module_install()   { echo "should not run"; }
EOF

  run run_module "$mod_dir" "$TEST_TMPDIR" "ubuntu" "PERSONAL" "false" "false"
  assert_success
  refute_output --partial "should not run"
}

@test "run_module passes DOTFILES_DIR to the module" {
  local mod_dir="$TEST_TMPDIR/ctxmod"
  mkdir -p "$mod_dir"
  cat > "$mod_dir/config.sh" <<'EOF'
module_supported() { return 0; }
module_install()   { echo "dotfiles=$DOTFILES_DIR"; }
EOF

  run run_module "$mod_dir" "$TEST_TMPDIR" "macos" "PERSONAL" "false" "false"
  assert_success
  assert_output --partial "dotfiles=$TEST_TMPDIR"
}

@test "run_module passes OS to the module" {
  local mod_dir="$TEST_TMPDIR/osmod"
  mkdir -p "$mod_dir"
  cat > "$mod_dir/config.sh" <<'EOF'
module_supported() { return 0; }
module_install()   { echo "os=$OS"; }
EOF

  run run_module "$mod_dir" "$TEST_TMPDIR" "ubuntu" "PERSONAL" "false" "false"
  assert_success
  assert_output --partial "os=ubuntu"
}

@test "run_module passes MODE to the module" {
  local mod_dir="$TEST_TMPDIR/modemod"
  mkdir -p "$mod_dir"
  cat > "$mod_dir/config.sh" <<'EOF'
module_supported() { return 0; }
module_install()   { echo "mode=$MODE"; }
EOF

  run run_module "$mod_dir" "$TEST_TMPDIR" "macos" "WORK" "false" "false"
  assert_success
  assert_output --partial "mode=WORK"
}

@test "run_module passes UPDATE to the module" {
  local mod_dir="$TEST_TMPDIR/updatemod"
  mkdir -p "$mod_dir"
  cat > "$mod_dir/config.sh" <<'EOF'
module_supported() { return 0; }
module_install()   { echo "update=$UPDATE"; }
EOF

  run run_module "$mod_dir" "$TEST_TMPDIR" "macos" "PERSONAL" "true" "false"
  assert_success
  assert_output --partial "update=true"
}

@test "run_module fails if config.sh does not exist" {
  run run_module "$TEST_TMPDIR/nonexistent" "$TEST_TMPDIR" "macos" "PERSONAL" "false" "false"
  assert_failure
}

# --- install_modules ---

@test "install_modules runs all modules that have a config.sh" {
  local dotfiles="$TEST_TMPDIR/dotfiles"
  mkdir -p "$dotfiles/modules/mod_a" "$dotfiles/modules/mod_b"

  cat > "$dotfiles/modules/mod_a/config.sh" <<'EOF'
module_supported() { return 0; }
module_install()   { echo "mod_a ran"; }
EOF
  cat > "$dotfiles/modules/mod_b/config.sh" <<'EOF'
module_supported() { return 0; }
module_install()   { echo "mod_b ran"; }
EOF

  run install_modules "$dotfiles" "macos" "PERSONAL" "false" "false"
  assert_success
  assert_output --partial "mod_a ran"
  assert_output --partial "mod_b ran"
}

@test "install_modules skips dirs without config.sh" {
  local dotfiles="$TEST_TMPDIR/dotfiles"
  mkdir -p "$dotfiles/modules/noconfig"

  run install_modules "$dotfiles" "macos" "PERSONAL" "false" "false"
  assert_success
}

@test "run_module passes INSTALL to the module" {
  local mod_dir="$TEST_TMPDIR/installmod"
  mkdir -p "$mod_dir"
  cat > "$mod_dir/config.sh" <<'EOF'
module_supported() { return 0; }
module_install()   { echo "install=$INSTALL"; }
EOF

  run run_module "$mod_dir" "$TEST_TMPDIR" "macos" "PERSONAL" "false" "true"
  assert_success
  assert_output --partial "install=true"
}
