#!/usr/bin/env bash

module_supported() {
  is_macos && [[ -d "/Applications/Sublime Text.app" ]]
}

module_install() {
  log "sublime" "Installing Sublime Text config"

  local mod="${DOTFILES_DIR}/modules/sublime"
  local install="${HOME}/Library/Application Support/Sublime Text"
  local user="${install}/Packages/User"

  log "sublime" "Installing 'subl' command"
  ln -sF "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" \
    "${DOTFILES_DIR}/modules/shell/path/sublime"

  link "${user}/Default (OSX).sublime-keymap"       "${mod}/Default (OSX).sublime-keymap"
  link "${user}/buildkite.sublime-build"            "${mod}/buildkite.sublime-build"
  link "${user}/AlignTab.sublime-settings"          "${mod}/AlignTab.sublime-settings"
  link "${user}/Babel.sublime-settings"             "${mod}/Babel.sublime-settings"
  link "${user}/Base File.sublime-settings"         "${mod}/Base File.sublime-settings"
  link "${user}/JsPrettier.sublime-settings"        "${mod}/JsPrettier.sublime-settings"
  link "${user}/Package Control.sublime-settings"   "${mod}/Package Control.sublime-settings"
  link "${user}/Preferences.sublime-settings"       "${mod}/Preferences.sublime-settings"
  link "${install}/Packages/Babel/JavaScript (Babel).sublime-syntax" \
    "${mod}/JavaScript (Babel).sublime-syntax"
  link "${user}/JavaScript (Babel).sublime-settings" "${mod}/JavaScript (Babel).sublime-settings"
  link "${user}/JavaScript.sublime-settings"        "${mod}/JavaScript.sublime-settings"
  link "${user}/JSON.sublime-settings"              "${mod}/JSON.sublime-settings"
  link "${user}/Markdown (Standard).sublime-settings" "${mod}/Markdown (Standard).sublime-settings"
  link "${user}/Markdown.sublime-settings"          "${mod}/Markdown.sublime-settings"
  link "${user}/Shell-Unix-Generic.sublime-settings" "${mod}/Shell-Unix-Generic.sublime-settings"
  link "${user}/binding_pry.sublime-macro"          "${mod}/binding_pry.sublime-macro"
  link "${user}/binding_remote_pry.sublime-macro"   "${mod}/binding_remote_pry.sublime-macro"
  link "${user}/show_me_the_page.sublime-macro"     "${mod}/show_me_the_page.sublime-macro"
  link "${user}/ruby_do_end.sublime-snippet"        "${mod}/ruby_do_end.sublime-snippet"
  link "${user}/ruby_do_variable_end.sublime-snippet" "${mod}/ruby_do_variable_end.sublime-snippet"
  link "${user}/Context.sublime-menu"               "${mod}/Context.sublime-menu"
  link "${user}/theme.tmTheme"                      "${mod}/theme"
  link "${user}/deselect_command_palette_text.py"   "${mod}/deselect_command_palette_text.py"
}
