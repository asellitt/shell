#! /bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo 'Working directory: $DIR'

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
echo 'Insalling Vim config'
rm ~/.vim* 2>/dev/null
ln -s $DIR/vim/rc ~/.vimrc
#ln -s $DIR/vim/vim/ ~/test/.vim

# git
echo 'Installing Git config'
rm ~/.git* 2>/dev/null
ln -s $DIR/git/config ~/.gitconfig
ln -s $DIR/git/completion.bash ~/.git-completion.bash

# gem
echo 'Installing Gem config'
rm ~/.gem* 2>/dev/null
ln -s $DIR/gem/rc ~/.gemrc

# pow
echo 'Installing Pow config'
rm ~/.pow* 2>/dev/null
ln -s $DIR/pow/config ~/.powconfig

