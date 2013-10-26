#! /bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#
# default action: install environment
#
if [[ -z "$1" ]]; then
    echo "Working directory: ${DIR}"



    # bash
    echo 'Installing Bash config'
    rm ~/.bash* 2>/dev/null
    ln -s $DIR/bash/rc ~/.bashrc
    ln -s $DIR/bash/profile ~/.bash_profile
    ln -s $DIR/bash/include ~/.bash_include
    ln -s $DIR/bash/aliases ~/.bash_aliases
    ln -s $DIR/bash/functions ~/.bash_functions
    ln -s $DIR/bash/logout ~/.bash_logout



    # vim
    echo 'Installing Vim config'
    rm ~/.vim* 2>/dev/null
    ln -s $DIR/vim/rc ~/.vimrc
    #ln -s $DIR/vim/vim/ ~/test/.vim



    # git
    echo 'Installing Git config'
    rm ~/.git* 2>/dev/null
    ln -s $DIR/git/config ~/.gitconfig
    ln -s $DIR/git/ignore ~/.gitignore
    ln -s $DIR/git/completion.bash ~/.git-completion.bash
    ln -s $DIR/git/commands ~/.git-commands
    chmod -RH u+x ~/.git-commands



    # gem
    echo 'Installing Gem config'
    rm ~/.gem* 2>/dev/null
    ln -s $DIR/gem/rc ~/.gemrc



    # pow
    echo 'Installing Pow config'
    rm ~/.pow* 2>/dev/null
    ln -s $DIR/pow/config ~/.powconfig



    # pry
    echo 'Installing Pry config'
    rm ~/.pry* 2>/dev/null
    ln -s $DIR/pry/rc ~/.pryrc



    # OSX specific stuffs
    if [ `uname` == 'Darwin' ]; then
        echo 'Installing OSX Specific config'



        # preferences
        echo '  Setting OSX preferences'
        chflags nohidden ~/Library
        defaults write NSGlobalDomain            ApplePressAndHoldEnabled                       -bool FALSE
        defaults write NSGlobalDomain            AppleKeyboardUIMode                            -int  3
        defaults write NSGlobalDomain            PMPrintingExpandedStateForPrint                -bool TRUE
        defaults write NSGlobalDomain            NSNavPanelExpandedStateForSaveMode             -bool TRUE
        defaults write NSGlobalDomain            InitialKeyRepeat                               -int  35
        defaults write NSGlobalDomain            KeyRepeat                                      -int  0
        defaults write NSGlobalDomain            com.apple.swipescrolldirection                 -bool FALSE
        defaults write NSGlobalDomain            com.apple.keyboard.fnState                     -bool TRUE
        defaults write com.apple.dock            no-glass                                       -bool TRUE
        defaults write com.apple.dock            autohide                                       -bool TRUE
        defaults write com.apple.dock            checked-for-launchpad                          -bool TRUE
        defaults write com.apple.dock            persistent-apps                                '()'
        defaults write com.apple.dock            show-process-indicators                        -bool FALSE
        defaults write com.apple.dock            tilesize                                       -int  36
        defaults write com.apple.finder          ShowExternalHardDrivesOnDesktop                -bool TRUE
        defaults write com.apple.finder          ShowHardDrivesOnDesktop                        -bool TRUE
        defaults write com.apple.finder          ShowMountedServersOnDesktop                    -bool TRUE
        defaults write com.apple.finder          ShowRemovableMediaOnDesktop                    -bool TRUE
        defaults write com.apple.finder          EmptyTrashSecurely                             -bool TRUE
        defaults write com.apple.universalaccess HIDScrollZoomModifierMask                      -int  262144
        defaults write com.apple.LaunchServices  LSQuarantine                                   -bool FALSE
        defaults write com.apple.desktopservices DSDontWriteNetworkStores                       -bool TRUE
        defaults write com.apple.dashboard       mcx-disabled                                   -bool TRUE
        defaults -currentHost write com.apple.screensaver     moduleDict                        -dict moduleName 'Flurry'
        defaults -currentHost write com.apple.screensaver     moduleDict                        -dict path '/System/Library/Screen Savers/Flurry.saver'
        defaults -currentHost write com.apple.screensaver     showClock                         -bool TRUE



        PREFDIR="$HOME/Library/Preferences"
        rm "$PREFDIR"/com.apple.symbolichotkeys.plist 2>/dev/null
        ln -s $DIR/osx/com.apple.symbolichotkeys.plist "$PREFDIR"/



        echo '  Restarting Apps'
        killall Dock
        killall Finder



        # slate
        echo '  Installing Slate config'
        rm ~/.slate 2>/dev/null
        ln -s $DIR/slate/slate ~/.slate



        # sublime
        echo '  Installing Sublime config'
        SUBLDIR="$HOME/Library/Application Support/Sublime Text 2/Packages"
        rm "$SUBLDIR"/User/*-keymap   2>/dev/null
        ln -s $DIR/sublime/*-keymap   "$SUBLDIR"/User/
        rm "$SUBLDIR"/User/*-settings 2>/dev/null
        ln -s $DIR/sublime/*-settings "$SUBLDIR"/User/
        rm "$SUBLDIR"/User/*-macro    2>/dev/null
        ln -s $DIR/sublime/*-macro    "$SUBLDIR"/User/
        rm "$SUBLDIR"/User/*-snippet  2>/dev/null
        ln -s $DIR/sublime/*-snippet  "$SUBLDIR"/User/
        rm "$SUBLDIR"/Color\ Scheme\ -\ Default/Blackbolt.tmTheme* 2>/dev/null
        ln -s $DIR/sublime/theme "$SUBLDIR"/Color\ Scheme\ -\ Default/Blackbolt.tmTheme
        rm "$SUBLDIR"/User/syntax_highlighting.py* 2>/dev/null
        ln -s $DIR/sublime/syntax_highlighting.py "$SUBLDIR"/User/syntax_highlighting.py
        SUBLDIR="$HOME/Library/Application Support/Sublime Text 2/Installed Packages"
        rm "$SUBLDIR"/*-package   2>/dev/null
        ln -s $DIR/sublime/*-package   "$SUBLDIR"/



        # alfred
        echo '  Installing Alfred config'
        rm "$PREFDIR"/com.runningwithcrayons.Alfred-* 2>/dev/null
        ln -s $DIR/alfred/*.plist "$PREFDIR"/
        ALFDIR="$HOME/Library/Application Support/Alfred 2/Alfred.alfredpreferences"
        rm -rf "$ALFDIR"/preferences #2>/dev/null
        ln -s $DIR/alfred/preferences "$ALFDIR"
    fi


#
# header: install a bash header
#
elif [[ "$1" == "header" ]]; then
    if [[ -z "$2" ]]; then
        echo 'Install which header?'
    else
        if [[ -f $2 ]]; then
            echo "Installing header: ${DIR}/${2}"
            rm ~/.bash_header 2>/dev/null
            ln -s $DIR/$2 ~/.bash_header
        else
            echo "${DIR}/${2} doesnt exist..."
        fi
    fi
else
    echo "Dont know what ${1} means"
fi
