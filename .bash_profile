if [ -r /etc/bashrc ]; then
    . /etc/bashrc 
fi

. ~/.bashrc

export PATH=$HOME/.rbenv/bin:$PATH
export CC=/usr/local/bin/gcc-4.2
export CLICOLOR=1
eval "$(rbenv init -)"

export PS1="$CYAN\u$CLEAR@$MAGENTA\h$CLEAR [ $GREEN\$(current-branch)$CLEAR] : $RED\w\n$BLUE\d \@$CLEAR \$ > "

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
  complete -o default -o nospace -F _git g
fi
