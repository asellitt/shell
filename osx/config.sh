#! /bin/bash

PREFIX="OSX"
log "Begin OSX config"

if [ `uname` != 'Darwin' ]; then
  log "This isn't OSX! Skipping config"
else
  log "OSX detected"

  log "Setting Global preferences"
  log "   Make the Library visible"
  chflags nohidden ~/Library
  log "   Enable the dark theme"
  defaults write NSGlobalDomain AppleInterfaceStyle Dark
  log "   Expand the print panel by default"
  defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
  log "   Expand save panel by default"
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
  log "   Always show scrollbars"
  defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
  log "   Increase window resize speed for Cocoa applications"
  defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
  log "   Save to disk (not to iCloud) by default"
  defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
  log "   Display ASCII control characters using caret notation in standard text views"
  defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true
  log "   Show all filename extensions"
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true

  log "Setting Keyboard/Mouse/Trackpad preferences"
  log "   Require Fn + fkey for functions"
  defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true
  log "   Disable the character picker and repeat the held key"
  defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
  log "   Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)"
  defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
  log "   Set a shorter Delay until key repeat"
  defaults write NSGlobalDomain InitialKeyRepeat -int 35
  log "   Set a Superman speed keyboard repeat rate"
  defaults write NSGlobalDomain KeyRepeat -int 0
  log "   Disable “natural” scrolling"
  defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
  log "   Enable tap to click for this user and for the login screen"
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
  defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
  defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
  log "   Enable bottom right corner to right-click"
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
  defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
  defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true
  log "   Enable swipe between pages with three fingers"
  defaults write NSGlobalDomain AppleEnableSwipeNavigateWithScrolls -bool true
  defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerHorizSwipeGesture -int 1
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 1

  log "Setting Dock preferences"
  log "   Enable 2D dock"
  defaults write com.apple.dock no-glass -bool true
  log "   Enable autohide"
  defaults write com.apple.dock autohide  -bool true
  log "   Add Launchpad to the dock"
  defaults write com.apple.dock checked-for-launchpad -bool true
  log "   Remove all default app icons from dock"
  defaults write com.apple.dock persistent-apps '()'
  log "   Remove all process running indicators from dock"
  defaults write com.apple.dock show-process-indicators -bool false
  log "   Tiny tiles"
  defaults write com.apple.dock tilesize -int 36
  log "   Don't show Dashboard as a Space"
  defaults write com.apple.dock dashboard-in-overlay -bool true
  log "   Don't automatically rearrange Spaces based on most recent use"
  defaults write com.apple.dock mru-spaces -bool false

  log "Setting Finder preferences"
  log "   Show external hard drives on the desktop"
  defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
  log "   Show hard drives on the desktop"
  defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
  log "   Show mounted servers on the desktop"
  defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
  log "   Show removable media on the desktop"
  defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
  log "   Securely empty the trash"
  defaults write com.apple.finder EmptyTrashSecurely -bool true
  log "   Disable the warning before emptying the Trash"
  defaults write com.apple.finder WarnOnEmptyTrash -bool false
  log "   Show hidden files by default"
  defaults write com.apple.finder AppleShowAllFiles -bool true
  log "   Show status bar"
  defaults write com.apple.finder ShowStatusBar -bool true
  log "   Allow text selection in Quick Look"
  defaults write com.apple.finder QLEnableTextSelection -bool true
  log "   Display full POSIX path as Finder window title"
  defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
  log "   When performing a search, search the current folder by default"
  defaults write com.apple.finder FXDefaultSearchScope -string “SCcf”
  log "   Disable the warning when changing a file extension"
  defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
  log "   Use column view in all Finder windows by default"
  defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

  log "Setting Screensaver preferences"
  log "   Require password immediately after sleep or screen saver begins"
  defaults write com.apple.screensaver askForPassword -int 1
  defaults write com.apple.screensaver askForPasswordDelay -int 0
  log "   Set Flurry as active screensaver"
  defaults -currentHost write com.apple.screensaver moduleDict -dict moduleName 'Flurry'
  defaults -currentHost write com.apple.screensaver moduleDict -dict path '/System/Library/Screen Savers/Flurry.saver'
  defaults -currentHost write com.apple.screensaver showClock -bool true

  log "Setting Misc preferences"
  log "   Use scroll gesture with the Ctrl (^) modifier key to zoom"
  defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
  defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144
  log "   Disable the “Are you sure you want to open this application?” dialog"
  defaults write com.apple.LaunchServices  LSQuarantine -bool false
  log "   Automatically quit printer app once the print jobs complete"
  defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true
  log "   Disable the crash reporter"
  defaults write com.apple.CrashReporter DialogType -string "none"
  log "   Avoid creating .DS_Store files on network volumes"
  defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
  log "   Disable useless Dashboard"
  defaults write com.apple.dashboard mcx-disabled -bool true
  log "   Disable that weird arse dictionary popup crap (cmd+ctrl+D)"
  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 70 '<dict><key>enabled</key><false/></dict>'

  # PREFDIR="$HOME/Library/Preferences"
  # rm "$PREFDIR"/com.apple.symbolichotkeys.plist 2>/dev/null
  # ln -s $DIR/osx/com.apple.symbolichotkeys.plist "$PREFDIR"/

  log "Fixing HOME/END key behaviour"
  KEYDIR="$HOME/Library/KeyBindings"
  mkdir $KEYDIR 2>/dev/null
  echo "
      {
          /* Remap Home / End keys to be correct */
          \"\UF729\" = \"moveToBeginningOfLine:\"; /* Home */
          \"\UF72B\" = \"moveToEndOfLine:\"; /* End */
          \"$\UF729\" = \"moveToBeginningOfLineAndModifySelection:\"; /* Shift + Home */
          \"$\UF72B\" = \"moveToEndOfLineAndModifySelection:\"; /* Shift + End */
          \"^\UF729\" = \"moveToBeginningOfDocument:\"; /* Ctrl + Home */
          \"^\UF72B\" = \"moveToEndOfDocument:\"; /* Ctrl + End */
          \"$^\UF729\" = \"moveToBeginningOfDocumentAndModifySelection:\"; /* Shift + Ctrl + Home */
          \"$^\UF72B\" = \"moveToEndOfDocumentAndModifySelection:\"; /* Shift + Ctrl + End */
      }
  " > $KEYDIR/DefaultKeyBinding.dict

  log "Restarting Apps"
  killall Finder /dev/null 2>&1
  killall SystemUIServer /dev/null 2>&1
  killall Dock /dev/null 2>&1
fi
