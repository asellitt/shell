#!/usr/bin/env bash

# Detect the current OS. Respects UNAME_CMD and OS_RELEASE_ID for test injection.
detect_os() {
  local kernel
  kernel="$(${UNAME_CMD:-uname})"

  case "$kernel" in
    Darwin)
      echo "macos"
      ;;
    Linux)
      local id="${OS_RELEASE_ID:-$(grep '^ID=' /etc/os-release 2>/dev/null | cut -d= -f2 | tr -d '"')}"
      case "$id" in
        ubuntu)  echo "ubuntu"  ;;
        steamos) echo "steamos" ;;
        *)       echo "unknown" ;;
      esac
      ;;
    *)
      echo "unknown"
      ;;
  esac
}

is_macos()    { [[ "$(detect_os)" == "macos"   ]]; }
is_ubuntu()   { [[ "$(detect_os)" == "ubuntu"  ]]; }
is_steamos()  { [[ "$(detect_os)" == "steamos" ]]; }
is_personal() { [[ "$MODE" == "PERSONAL" ]]; }
is_work()     { [[ "$MODE" == "WORK"     ]]; }
