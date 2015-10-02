#! /bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#
# default action: install environment
#
if [[ -z "$1" ]]; then
    . $DIR/install/modules.sh

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
    ln -s $DIR/bash/path ~/path

    # vim
    echo 'Installing Vim config'
    rm ~/.vim* 2>/dev/null
    ln -s $DIR/vim/rc ~/.vimrc
    #ln -s $DIR/vim/vim/ ~/test/.vim

    # rbenv
    echo 'Installing rbenv config'
    rm ~/.rbenv* 2>/dev/null
    ln -s $DIR/rbenv/version ~/.rbenv-version

    # gem
    echo 'Installing Gem config'
    rm ~/.gem* 2>/dev/null
    ln -s $DIR/gem/rc ~/.gemrc

    # default gems
    echo 'Installing handy gems'
    if ! gem spec bundler > /dev/null 2>&1; then
        echo '  Installing bundler'
        gem install bundler
    fi
    if ! gem spec jazz_hands > /dev/null 2>&1; then
        echo '  Installing jazz_hands'
        gem install jazz_hands
    fi

    # pow
    echo 'Installing Pow config'
    rm ~/.pow* 2>/dev/null
    ln -s $DIR/pow/config ~/.powconfig

    # pry
    echo 'Installing Pry config'
    rm ~/.pry* 2>/dev/null
    ln -s $DIR/pry/rc ~/.pryrc


#
# header: install a bash header
#
elif [[ "$1" == "header" ]]; then
    HEADDIR="$DIR/bash/header"
    if [[ -z "$2" ]]; then
        echo 'Install which header?'
    else
        if [[ -f "${HEADDIR}/${2}" ]]; then
            echo "Installing header: ${HEADDIR}/${2}"
            rm ~/.bash_header 2>/dev/null
            ln -s $HEADDIR/$2 ~/.bash_header
        else
            echo "${HEADDIR}/${2} doesnt exist..."
        fi
    fi


#
# non-boxen: install binaries on a non-boxenated system
#
elif [[ "$1" == "nonboxen" ]]; then
    if hash brew 2>/dev/null; then
        echo 'Brew installed'
        echo '  Installing gh...'
        brew install gh
        echo '  Installing autojump...'
        brew install autojump
        echo '  Installing the_silver_searcher...'
        brew install the_silver_searcher
    else
        echo 'Install brew first: http://brew.sh'
    fi


else
    echo "Dont know what ${1} means"
fi
