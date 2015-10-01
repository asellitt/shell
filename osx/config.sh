#! /bin/bash

PREFIX="[OSX]"
echo "${PREFIX} Begin OSX config"

if [ `uname` != 'Darwin' ]; then
  echo "${PREFIX} This isn't OSX! Skipping config"
else
  echo "${PREFIX} OSX detected"

  echo "${PREFIX} Setting Global preferences"
  echo "${PREFIX}    Make the Library visible"
  chflags nohidden ~/Library
  echo "${PREFIX}    Enable the dark theme"
  defaults write NSGlobalDomain AppleInterfaceStyle Dark
  echo "${PREFIX}    Expand the print panel by default"
  defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
  echo "${PREFIX}    Expand save panel by default"
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
  echo "${PREFIX}    Always show scrollbars"
  defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
  echo "${PREFIX}    Increase window resize speed for Cocoa applications"
  defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
  echo "${PREFIX}    Save to disk (not to iCloud) by default"
  defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
  echo "${PREFIX}    Display ASCII control characters using caret notation in standard text views"
  defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true
  echo "${PREFIX}    Show all filename extensions"
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true

  echo "${PREFIX} Setting Keyboard/Mouse/Trackpad preferences"
  echo "${PREFIX}    Require Fn + fkey for functions"
  defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true
  echo "${PREFIX}    Disable the character picker and repeat the held key"
  defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
  echo "${PREFIX}    Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)"
  defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
  echo "${PREFIX}    Set a shorter Delay until key repeat"
  defaults write NSGlobalDomain InitialKeyRepeat -int 35
  echo "${PREFIX}    Set a Superman speed keyboard repeat rate"
  defaults write NSGlobalDomain KeyRepeat -int 0
  echo "${PREFIX}    Disable “natural” scrolling"
  defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
  echo "${PREFIX}    Enable tap to click for this user and for the login screen"
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
  defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
  defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
  echo "${PREFIX}    Enable bottom right corner to right-click"
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
  defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
  defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true
  echo "${PREFIX}    Enable swipe between pages with three fingers"
  defaults write NSGlobalDomain AppleEnableSwipeNavigateWithScrolls -bool true
  defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerHorizSwipeGesture -int 1
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 1

  echo "${PREFIX} Setting Dock preferences"
  echo "${PREFIX}    Enable 2D dock"
  defaults write com.apple.dock no-glass -bool true
  echo "${PREFIX}    Enable autohide"
  defaults write com.apple.dock autohide  -bool true
  echo "${PREFIX}    Add Launchpad to the dock"
  defaults write com.apple.dock checked-for-launchpad -bool true
  echo "${PREFIX}    Remove all default app icons from dock"
  defaults write com.apple.dock persistent-apps '()'
  echo "${PREFIX}    Remove all process running indicators from dock"
  defaults write com.apple.dock show-process-indicators -bool false
  echo "${PREFIX}    Tiny tiles"
  defaults write com.apple.dock tilesize -int 36
  echo "${PREFIX}    Don't show Dashboard as a Space"
  defaults write com.apple.dock dashboard-in-overlay -bool true
  echo "${PREFIX}    Don't automatically rearrange Spaces based on most recent use"
  defaults write com.apple.dock mru-spaces -bool false

  echo "${PREFIX} Setting Finder preferences"
  echo "${PREFIX}    Show external hard drives on the desktop"
  defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
  echo "${PREFIX}    Show hard drives on the desktop"
  defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
  echo "${PREFIX}    Show mounted servers on the desktop"
  defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
  echo "${PREFIX}    Show removable media on the desktop"
  defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
  echo "${PREFIX}    Securely empty the trash"
  defaults write com.apple.finder EmptyTrashSecurely -bool true
  echo "${PREFIX}    Disable the warning before emptying the Trash"
  defaults write com.apple.finder WarnOnEmptyTrash -bool false
  echo "${PREFIX}    Show hidden files by default"
  defaults write com.apple.finder AppleShowAllFiles -bool true
  echo "${PREFIX}    Show status bar"
  defaults write com.apple.finder ShowStatusBar -bool true
  echo "${PREFIX}    Allow text selection in Quick Look"
  defaults write com.apple.finder QLEnableTextSelection -bool true
  echo "${PREFIX}    Display full POSIX path as Finder window title"
  defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
  echo "${PREFIX}    When performing a search, search the current folder by default"
  defaults write com.apple.finder FXDefaultSearchScope -string “SCcf”
  echo "${PREFIX}    Disable the warning when changing a file extension"
  defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
  echo "${PREFIX}    Use column view in all Finder windows by default"
  defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

  echo "${PREFIX} Setting Screensaver preferences"
  echo "${PREFIX}   Require password immediately after sleep or screen saver begins"
  defaults write com.apple.screensaver askForPassword -int 1
  defaults write com.apple.screensaver askForPasswordDelay -int 0
  echo "${PREFIX}   Set Flurry as active screensaver"
  defaults -currentHost write com.apple.screensaver moduleDict -dict moduleName 'Flurry'
  defaults -currentHost write com.apple.screensaver moduleDict -dict path '/System/Library/Screen Savers/Flurry.saver'
  defaults -currentHost write com.apple.screensaver showClock -bool true

  echo "${PREFIX} Setting Misc preferences"
  echo "${PREFIX}   Use scroll gesture with the Ctrl (^) modifier key to zoom"
  defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
  defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144
  echo "${PREFIX}   Disable the “Are you sure you want to open this application?” dialog"
  defaults write com.apple.LaunchServices  LSQuarantine -bool false
  echo "${PREFIX}   Automatically quit printer app once the print jobs complete"
  defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true
  echo "${PREFIX}   Disable the crash reporter"
  defaults write com.apple.CrashReporter DialogType -string "none"
  echo "${PREFIX}   Avoid creating .DS_Store files on network volumes"
  defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
  echo "${PREFIX}   Disable useless Dashboard"
  defaults write com.apple.dashboard mcx-disabled -bool true
  echo  "${PREFIX}   Disable that weird arse dictionary popup crap (cmd+ctrl+D)"
  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 70 '<dict><key>enabled</key><false/></dict>'

  # PREFDIR="$HOME/Library/Preferences"
  # rm "$PREFDIR"/com.apple.symbolichotkeys.plist 2>/dev/null
  # ln -s $DIR/osx/com.apple.symbolichotkeys.plist "$PREFDIR"/

  echo "${PREFIX} Fixing HOME/END key behaviour"
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

  echo "${PREFIX} Restarting Apps"
  killall Finder /dev/null 2>&1
  killall SystemUIServer /dev/null 2>&1
  killall Dock /dev/null 2>&1
fi
