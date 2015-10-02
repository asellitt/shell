#! /bin/bash

PREFIX="[SUBLIME]"
echo "${PREFIX} Begin Sublime config"

if [ `uname` != 'Darwin' ]; then
  echo "${PREFIX} This isn't OSX! Skipping config"
else
  SUBLIME_MODULE_DIR="${DIR}/sublime"
  SUBLIME_INSTALL_DIR="${HOME}/Library/Application Support"
  echo "${PREFIX} OSX detected"

  SUBLIME_INSTALL_DIR="${HOME}/Library/Application Support"
  if [ -d "${SUBLIME_INSTALL_DIR}/Sublime Text 3" ]; then
      echo "${PREFIX}    Found Sublime Text 3"
      SUBLIME_INSTALL_DIR="${SUBLIME_INSTALL_DIR}/Sublime Text 3"
  elif [ -d "${SUBLIME_INSTALL_DIR}/Sublime Text 2" ]; then
      echo "${PREFIX}    Found Sublime Text 2"
      SUBLIME_INSTALL_DIR="${SUBLIME_INSTALL_DIR}/Sublime Text 2"
  fi

  if [ ! -d "${SUBLIME_INSTALL_DIR}" ]; then
      echo "${PREFIX} Looks like Sublime is not installed. Skipping config"
  else
      echo "${PREFIX} Installing Sublime config"

      echo "${PREFIX} Installing User Packages"
      SUBLIME_USER_PACKAGE_DIR="${SUBLIME_INSTALL_DIR}/Packages/User"
      echo "${PREFIX}    Installing User Key Bindings"
      rm "${SUBLIME_USER_PACKAGE_DIR}/Default (OSX).sublime-keymap" 2>/dev/null
      ln -s "${SUBLIME_MODULE_DIR}/Default (OSX).sublime-keymap" "${SUBLIME_USER_PACKAGE_DIR}"/
      echo "${PREFIX}    Installing User Settings"
      rm "${SUBLIME_USER_PACKAGE_DIR}"/*-settings 2>/dev/null
      ln -s "${SUBLIME_MODULE_DIR}"/*-settings "${SUBLIME_USER_PACKAGE_DIR}"/
      echo "${PREFIX}    Installing User Macros"
      rm "${SUBLIME_USER_PACKAGE_DIR}"/*-macro 2>/dev/null
      ln -s "${SUBLIME_MODULE_DIR}"/*-macro "${SUBLIME_USER_PACKAGE_DIR}"/
      echo "${PREFIX}    Installing User Snippets"
      rm "${SUBLIME_USER_PACKAGE_DIR}"/*-snippet 2>/dev/null
      ln -s "${SUBLIME_MODULE_DIR}"/*-snippet "${SUBLIME_USER_PACKAGE_DIR}"/
      echo "${PREFIX}    Installing Syntax Highlighter"
      rm "${SUBLIME_USER_PACKAGE_DIR}"/syntax_highlighting.py* 2>/dev/null
      ln -s "${SUBLIME_MODULE_DIR}/syntax_highlighting.py" "${SUBLIME_USER_PACKAGE_DIR}"/

      echo "${PREFIX} Installing Color Scheme"
      SUBLIME_COLOR_SCHEME_DIR="${SUBLIME_INSTALL_DIR}/Packages/Color Scheme - Default"
      mkdir "${SUBLIME_COLOR_SCHEME_DIR}" 2>/dev/null
      rm "${SUBLIME_COLOR_SCHEME_DIR}"/Blackbolt.tmTheme* 2>/dev/null
      ln -s "${SUBLIME_MODULE_DIR}"/theme "${SUBLIME_COLOR_SCHEME_DIR}"/Blackbolt.tmTheme
  fi
fi
