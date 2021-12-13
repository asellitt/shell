#! /bin/zsh

PREFIX="APPS"
log "Begin Apps config"

if hash brew 2>/dev/null; then
  log "  Brew detected, tapping additional casks"
  brew tap homebrew/cask-fonts
  brew tap homebrew/cask-drivers
  if [[ $UPDATE == true ]]; then
    log "  Upgrading casks"
    brew upgrade --cask -v
  else
    log "  skipping brew upgrade"
  fi
else
  log "  Brew not detected, skipping tap"
fi

if hash mas 2>/dev/null; then
  if [[ $UPDATE == true ]]; then
    log "  Mas detected, upgrading apps"
    mas upgrade
  else
    log "  skipping mas upgrade"
  fi
fi

if [[ ! $INSTALL == true ]]; then
  log "Skipping app installation"
else
  log "Installing casks"
  cask_install "1password"
  cask_install "authy"
  cask_install "aws-vault"
  cask_install "box-sync"
  cask_install "bitwarden"
  cask_install "caffeine"
  cask_install "calibre"
  cask_install "coconutbattery"
  cask_install "discord"
  cask_install "dropbox"
  cask_install "firefox"
  cask_install "font-fira-code"
  cask_install "gimp"
  cask_install "google-chrome"
  cask_install "huiontablet"
  cask_install "imageoptim"
  cask_install "iterm2"
  cask_install "kensingtonworks" # pretty sure this will fail, but we need this app for big turd
  cask_install "krita"
  cask_install "licecap"
  cask_install "logitech-myharmony"
  cask_install "macdown"
  cask_install "psequel"
  cask_install "screen"
  cask_install "sequel-pro"
  cask_install "sigil"
  cask_install "signal"
  cask_install "slack"
  cask_install "sourcetree"
  cask_install "tripmode"
  cask_install "visual-studio-code"
  cask_install "vlc"
  cask_install "whatsapp"
  cask_install "zsa-wally"
  # cask_install "sublime-text" yes, true. but im on the dev channel

  log "Installing packages"
  brew_install "autojump"
  brew_install "bitwarden-cli"
  brew_install "coreutils"
  brew_install "direnv"
  brew_install "heroku"
  brew_install "hub"
  brew_install "jq"
  brew_install "mas"
  brew_install "redis"
  brew_install "the_silver_searcher"
  brew_install "watch"

  log "Installing App Store applications"
  mas_install "CCMenu" "603117688"
  mas_install "Disk Care" "913724705"
  mas_install "IP Camera Viewer 2" "595565459"
  mas_install "Magnet" "441258766"
  mas_install "Mic Drop" "1489816366"
  mas_install "Monosnap" "540348655"
  mas_install "Pages" "409201541"
  mas_install "Ring" "1142753258"
  mas_install "The Unarchiver" "425424353"
  # mas_install "497799835" "Xcode" yup, but this is required before mas can be installed
fi
