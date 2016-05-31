os=$(uname -s)

if [ ${os} == "Linux" ]; then
    source ${HOME}/.bashrc_debian
fi

source ${HOME}/.git-completion.bash
source ${HOME}/.virsh-completion.bash

if [ -f ${HOME}/.local/bin/virtualenvwrapper.sh ]; then
    export WORKON_HOME=${HOME}/.virtualenvs
    export PROJECT_HOME=${HOME}/src
    source ${HOME}/.local/bin/virtualenvwrapper.sh
fi

export PYTHONSTARTUP=${HOME}/.pythonrc.py
export EDITOR=vim

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUPSTREAM="verbose"
export PS1='[\h \[\033[1;35m\]\W$(__git_ps1 " \[\033[1;34m\](%s)")\[\033[0m\]]\$ '

alias g=git
alias sS='screen -S'
alias sls='screen -ls'
alias sdr='screen -dr'
alias tl='tmux list-sessions'
alias tn='tmux new-session -s'
alias ta='tmux attach-session -t'
alias tk='tmux kill-session -t'
alias tb="nc termbin.com 9999"
alias firefox-lab="firefox -P lab -no-remote"

export PATH=${HOME}/.local/bin:${HOME}/local/bin:${PATH}

if [ ${os} == "Linux" ]; then
    source ${HOME}/.bashrc_debian_custom
elif [ ${os} == "Darwin" ]; then
    source ${HOME}/.bashrc_osx_custom
fi

export NVM_DIR="/home/elemoine/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

[[ -s "/home/elemoine/.gvm/scripts/gvm" ]] && source "/home/elemoine/.gvm/scripts/gvm"
