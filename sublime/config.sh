#! /bin/bash

PREFIX="SUBLIME"
log "Begin Sublime config"

if [ `uname` != 'Darwin' ]; then
  log "This isn't OSX! Skipping config"
else
  SUBLIME_MODULE_DIR="${DOTFILES_DIR}/sublime"
  SUBLIME_INSTALL_DIR="${HOME}/Library/Application Support"
  log "OSX detected"

  SUBLIME_INSTALL_DIR="${HOME}/Library/Application Support"
  if [ -d "${SUBLIME_INSTALL_DIR}/Sublime Text 3" ]; then
    log "   Found Sublime Text 3"
    SUBLIME_INSTALL_DIR="${SUBLIME_INSTALL_DIR}/Sublime Text 3"
  elif [ -d "${SUBLIME_INSTALL_DIR}/Sublime Text 2" ]; then
    log "   Found Sublime Text 2"
    SUBLIME_INSTALL_DIR="${SUBLIME_INSTALL_DIR}/Sublime Text 2"
  fi

  if [ ! -d "${SUBLIME_INSTALL_DIR}" ]; then
    log "Looks like Sublime is not installed. Skipping config"
  else
    log "Installing Sublime config"

    log "Installing 'sublime' command"
    ln -sF "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" "${DOTFILES_DIR}/bash/path/sublime"

    log "Installing User Packages"
    SUBLIME_USER_PACKAGE_DIR="${SUBLIME_INSTALL_DIR}/Packages/User"

    log "   Installing User Key Bindings"
    link "${SUBLIME_USER_PACKAGE_DIR}/Default (OSX).sublime-keymap" "${SUBLIME_MODULE_DIR}/Default (OSX).sublime-keymap"

    log "   Installing User Builds"
    link "${SUBLIME_USER_PACKAGE_DIR}/buildkite.sublime-build" "${SUBLIME_MODULE_DIR}/buildkite.sublime-build"

    log "   Installing User Package Settings"
    link "${SUBLIME_USER_PACKAGE_DIR}/AlignTab.sublime-settings" "${SUBLIME_MODULE_DIR}/AlignTab.sublime-settings"
    link "${SUBLIME_USER_PACKAGE_DIR}/Babel.sublime-settings" "${SUBLIME_MODULE_DIR}/Babel.sublime-settings"
    link "${SUBLIME_USER_PACKAGE_DIR}/Base File.sublime-settings" "${SUBLIME_MODULE_DIR}/Base File.sublime-settings"
    link "${SUBLIME_USER_PACKAGE_DIR}/JsPrettier.sublime-settings" "${SUBLIME_MODULE_DIR}/JsPrettier.sublime-settings"
    link "${SUBLIME_USER_PACKAGE_DIR}/Package Control.sublime-settings" "${SUBLIME_MODULE_DIR}/Package Control.sublime-settings"
    link "${SUBLIME_USER_PACKAGE_DIR}/Preferences.sublime-settings" "${SUBLIME_MODULE_DIR}/Preferences.sublime-settings"
    link "${SUBLIME_INSTALL_DIR}/Packages/Babel/JavaScript (Babel).sublime-syntax" "${SUBLIME_MODULE_DIR}/JavaScript (Babel).sublime-syntax"

    log "   Installing User Language Settings"
    link "${SUBLIME_USER_PACKAGE_DIR}/JavaScript (Babel).sublime-settings" "${SUBLIME_MODULE_DIR}/JavaScript (Babel).sublime-settings"
    link "${SUBLIME_USER_PACKAGE_DIR}/JavaScript.sublime-settings" "${SUBLIME_MODULE_DIR}/JavaScript.sublime-settings"
    link "${SUBLIME_USER_PACKAGE_DIR}/JSON.sublime-settings" "${SUBLIME_MODULE_DIR}/JSON.sublime-settings"
    link "${SUBLIME_USER_PACKAGE_DIR}/Markdown (Standard).sublime-settings" "${SUBLIME_MODULE_DIR}/Markdown (Standard).sublime-settings"
    link "${SUBLIME_USER_PACKAGE_DIR}/Markdown.sublime-settings" "${SUBLIME_MODULE_DIR}/Markdown.sublime-settings"
    link "${SUBLIME_USER_PACKAGE_DIR}/Shell-Unix-Generic.sublime-settings" "${SUBLIME_MODULE_DIR}/Shell-Unix-Generic.sublime-settings"

    log "   Installing User Macros"
    link "${SUBLIME_USER_PACKAGE_DIR}/binding_pry.sublime-macro" "${SUBLIME_MODULE_DIR}/binding_pry.sublime-macro"
    link "${SUBLIME_USER_PACKAGE_DIR}/binding_remote_pry.sublime-macro" "${SUBLIME_MODULE_DIR}/binding_remote_pry.sublime-macro"
    link "${SUBLIME_USER_PACKAGE_DIR}/show_me_the_page.sublime-macro" "${SUBLIME_MODULE_DIR}/show_me_the_page.sublime-macro"

    log "   Installing User Snippets"
    link "${SUBLIME_USER_PACKAGE_DIR}/ruby_do_end.sublime-snippet" "${SUBLIME_MODULE_DIR}/ruby_do_end.sublime-snippet"
    link "${SUBLIME_USER_PACKAGE_DIR}/ruby_do_variable_end.sublime-snippet" "${SUBLIME_MODULE_DIR}/ruby_do_variable_end.sublime-snippet"

    log "   Installing User Context Menu"
    link "${SUBLIME_USER_PACKAGE_DIR}/Context.sublime-menu" "${SUBLIME_MODULE_DIR}/Context.sublime-menu"

    log "   Installing Theme"
    link "${SUBLIME_USER_PACKAGE_DIR}/theme.tmTheme" "${SUBLIME_MODULE_DIR}/theme"

    log "   Installing Sublime Dev Branch fuckup fixes"
    link "${SUBLIME_USER_PACKAGE_DIR}/deselect_command_palette_text.py" "${SUBLIME_MODULE_DIR}/deselect_command_palette_text.py"

    post_install_message "SUBLIME: If this is the first run, visit https://packagecontrol.io/installation to install Package Control"
  fi
fi
