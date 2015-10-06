#! /bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#
# default action: install environment
#
if [[ -z "$1" ]]; then
    . $DIR/install/modules.sh

    echo "Working directory: ${DIR}"

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
