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

    # slate
    echo 'Installing Slate config'
    rm ~/.slate 2>/dev/null
    ln -s $DIR/slate/slate ~/.slate

    # sublime
    echo 'Installing Sublime config'
    rm ~/Library/Application\ Support/Sublime\ Text\ 2/Packages/User/Default\ \(OSX\).sublime-keymap 2>/dev/null
    ln -s $DIR/sublime/keymap ~/Library/Application\ Support/Sublime\ Text\ 2/Packages/User/Default\ \(OSX\).sublime-keymap
    rm ~/Library/Application\ Support/Sublime\ Text\ 2/Packages/User/Preferences.sublime-settings 2>/dev/null
    ln -s $DIR/sublime/settings ~/Library/Application\ Support/Sublime\ Text\ 2/Packages/User/Preferences.sublime-settings
    rm ~/Library/Application\ Support/Sublime\ Text\ 2/Packages/User/Ruby.sublime-settings 2>/dev/null
    ln -s $DIR/sublime/ruby.settings ~/Library/Application\ Support/Sublime\ Text\ 2/Packages/User/Ruby.sublime-settings
    rm ~/Library/Application\ Support/Sublime\ Text\ 2/Packages/Color\ Scheme\ -\ Default/Blackbolt.tmTheme* 2>/dev/null
    ln -s $DIR/sublime/theme ~/Library/Application\ Support/Sublime\ Text\ 2/Packages/Color\ Scheme\ -\ Default/Blackbolt.tmTheme
    rm ~/Library/Application\ Support/Sublime\ Text\ 2/Packages/User/syntax_highlighting.py* 2>/dev/null
    ln -s $DIR/sublime/syntax_highlighting.py ~/Library/Application\ Support/Sublime\ Text\ 2/Packages/User/syntax_highlighting.py
    rm ~/Library/Application\ Support/Sublime\ Text\ 2/Packages/User/pry_binding.sublime-macro* 2>/dev/null
    ln -s $DIR/sublime/pry_binding.sublime-macro ~/Library/Application\ Support/Sublime\ Text\ 2/Packages/User/pry_binding.sublime-macro

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
