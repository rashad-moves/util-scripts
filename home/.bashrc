#!/bin/bash

# https://unix.stackexchange.com/questions/261687/is-it-possible-to-configure-bash-to-autocomplete-with-one-tab-like-zsh
bind 'set show-all-if-ambiguous on'
bind 'set completion-ignore-case on'

# https://stackoverflow.com/questions/1423352/source-all-files-in-a-directory-from-bash-profile#answer-42986004
#files_to_source=$(find ~/Documents/github/utility-scripts/aliases -maxdepth 1 -name "*.aliases.sh")
#for file in $files_to_source; do source $file; done

# https://gist.github.com/mwhite/6887990
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion                                                                                                                                                                
fi

function_exists() {
    declare -f -F $1 > /dev/null
    return $?
}

#https://stackoverflow.com/questions/54168718/ultimate-aliases-for-git-fails-git-aliases-command-seem-to-be-deprecated
for al in $(git config --get-regexp '^alias\.' | cut -f 1 -d ' ' | cut -f 2 -d '.'); do

  alias g${al}="git ${al}"

  complete_func=_git_$(__git_aliased_command ${al})
  function_exists ${complete_fnc} && __git_complete g${al} ${complete_func}
done
unset al

# https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM="auto verbose git"
GIT_PS1_SHOWCOLORHINTS=true

cd ~/github