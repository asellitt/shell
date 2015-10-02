#! /bin/bash

PREFIX="[SLATE]"
echo "${PREFIX} Begin Slate config"

if [ `uname` != 'Darwin' ]; then
  echo "${PREFIX} This isn't OSX! Skipping config"
else
  echo "${PREFIX} OSX detected"

  if [ ! -d "/Applications/Slate.app" ]; then
      echo "${PREFIX} Looks like Slate is not installed. Skipping config"
  else
      echo "${PREFIX}    Found Slate"

      echo "${PREFIX} Installing Slate config"
      rm ~/.slate 2>/dev/null
      ln -s "${DIR}"/slate/slate ~/.slate
  fi
fi
