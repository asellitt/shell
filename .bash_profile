if [ -r /etc/bashrc ]; then
    . /etc/bashrc 
fi

. .bashrc

export PATH=$HOME/.rbenv/bin:$PATH
export CC=/usr/local/bin/gcc-4.2
export CLICOLOR=1
eval "$(rbenv init -)"


function current-branch {
    git branch 2> /dev/null | grep -e '\* ' | sed 's/^..\(.*\)/\1 /'
}

export PS1="$CYAN\u$CLEAR@$MAGENTA\h$CLEAR [ $GREEN\$(current-branch)$CLEAR] : $RED\w\n$BLUE\d \@$CLEAR \$ > "

# git checkout fuzzy
function gcf {
    branch="$(git branch | cut -b3- | grep "$1")"
    if [[ -n "$branch" ]]; then
        git checkout "$branch"
    else
        echo "Couldn't find branch matching $1." >&2
    fi
}

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi
