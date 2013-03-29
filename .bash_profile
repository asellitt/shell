if [ -r /etc/bashrc ]; then
    . /etc/bashrc 
fi

. ~/.bashrc

export PATH=$HOME/.rbenv/bin:$PATH
export CC=/usr/local/bin/gcc-4.2
export CLICOLOR=1
eval "$(rbenv init -)"

if type current-branch &>/dev/null; then
    echo 'errmahgerd'
fi

#export PS1="$CYAN\u$CLEAR@$MAGENTA\h$CLEAR [ $GREEN\$(current-branch)$CLEAR] : $RED\w\n$BLUE\d \@$CLEAR \$ > "

