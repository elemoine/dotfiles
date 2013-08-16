source ${HOME}/.git-completion.bash

# startup virtualenv-burrito
if [ -f $HOME/.venvburrito/startup.sh ]; then
    . $HOME/.venvburrito/startup.sh
fi

alias g=git
alias l='ls -l'
alias sS='screen -S'
alias sls='screen -ls'
alias sdr='screen -dr'

# http://stackoverflow.com/questions/1550288/mac-os-x-terminal-colors
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

export EDITOR=vim

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUPSTREAM="verbose"
export PS1='[\h \[\033[1;35m\]\W$(__git_ps1 " \[\033[1;34m\](%s)")\[\033[0m\]]\$ '
