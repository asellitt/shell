#!/usr/bin/env bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

setup() {
  source "${BATS_TEST_DIRNAME}/../lib/log.sh"
  source "${BATS_TEST_DIRNAME}/../lib/link.sh"
  TEST_TMPDIR="$(mktemp -d)"
}

teardown() {
  rm -rf "$TEST_TMPDIR"
}

# --- link ---

@test "link creates a symlink at the target path" {
  local src="$TEST_TMPDIR/source_file"
  local target="$TEST_TMPDIR/target_link"
  echo "content" > "$src"

  run link "$target" "$src"
  assert_success
  [ -L "$target" ]
}

@test "link points the symlink to the correct source" {
  local src="$TEST_TMPDIR/source_file"
  local target="$TEST_TMPDIR/target_link"
  echo "content" > "$src"

  link "$target" "$src"
  assert_equal "$(readlink "$target")" "$src"
}

@test "link replaces an existing symlink" {
  local src1="$TEST_TMPDIR/source1"
  local src2="$TEST_TMPDIR/source2"
  local target="$TEST_TMPDIR/target_link"
  echo "one" > "$src1"
  echo "two" > "$src2"

  link "$target" "$src1"
  link "$target" "$src2"

  assert_equal "$(readlink "$target")" "$src2"
}

@test "link replaces an existing regular file" {
  local src="$TEST_TMPDIR/source_file"
  local target="$TEST_TMPDIR/target_file"
  echo "content" > "$src"
  echo "old"     > "$target"

  run link "$target" "$src"
  assert_success
  [ -L "$target" ]
}

@test "link fails if source does not exist" {
  local src="$TEST_TMPDIR/nonexistent"
  local target="$TEST_TMPDIR/target_link"

  run link "$target" "$src"
  assert_failure
}
