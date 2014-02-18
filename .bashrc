os=$(uname -s)

if [ ${os} == "Linux" ]; then
    source ${HOME}/.bashrc_debian
fi

source ${HOME}/.git-completion.bash
if [ -f ${HOME}/.venvburrito/startup.sh ]; then
    source ${HOME}/.venvburrito/startup.sh
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

export PATH=${HOME}/local/bin:${PATH}

if [ ${os} == "Linux" ]; then
    source ${HOME}/.bashrc_debian_custom
elif [ ${os} == "Darwin" ]; then
    source ${HOME}/.bashrc_osx_custom
fi
