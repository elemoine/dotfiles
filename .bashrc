#
# ~/.bashrc - startup file for Bash interactive shell
#
# References:
# - https://github.com/mloskot/archlinux-config/blob/master/home/mloskot/.bashrc
# - https://wiki.archlinux.org/index.php/Color_Bash_Prompt
#
if [[ $- != *i* ]]; then
    # Running non-interactively, don't do anything
    return
fi

echo "Sourcing ${HOME}/.bashrc..."

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# ensure $SSH_AUTH_SOCK is available at /tmp/ssh-agent-$USER-screen
# see http://blog.onetechnical.com/2009/09/15/reconnect-ssh-agent-in-screen/
if test $SSH_AUTH_SOCK && [ $SSH_AUTH_SOCK != "/tmp/ssh-agent-$USER-screen" ]
then
    rm -f /tmp/ssh-agent-$USER-screen
    ln -sf "$SSH_AUTH_SOCK" "/tmp/ssh-agent-$USER-screen"
fi

# Create symlink ~/.ssh/ssh_auth_sock to the ssh-agent socket. This is
# used for tmux sessions.
#
# See these links for more information:
#
# https://gist.github.com/bcomnes/e756624dc1d126ba2eb6
# http://techblog.appnexus.com/2011/managing-ssh-sockets-in-gnu-screen/
# https://gist.github.com/martijnvermaat/8070533
# http://stackoverflow.com/questions/21378569/how-to-auto-update-ssh-agent-environment-variables-when-attaching-to-existing-tm
if [[ -S $SSH_AUTH_SOCK && ! -h $SSH_AUTH_SOCK ]]; then
    ln -sf $SSH_AUTH_SOCK ~/.ssh/ssh_auth_sock
fi

if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
fi

source ${HOME}/.git-completion.bash
source ${HOME}/.git-prompt.sh

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUPSTREAM="verbose"

# set prompt
case "$TERM" in
xterm*|screen*)
    PS1='[\u@\h \[\033[1;35m\]\W$(__git_ps1 " \[\033[1;34m\](%s)")\[\033[0m\]]\$ '
    ;;
*)
    PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
    ;;
esac


# virtualenvwrapper
if [ -f ${HOME}/.local/bin/virtualenvwrapper.sh ]; then
    export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
    export VIRTUALENVWRAPPER_VIRTUALENV=${HOME}/.local/bin/virtualenv
    export WORKON_HOME=${HOME}/.virtualenvs
    export PROJECT_HOME=${HOME}/src
    source ${HOME}/.local/bin/virtualenvwrapper.sh
fi

# vex
# https://github.com/sashahart/vex
if [ -n "$VIRTUAL_ENV" ]; then
    PS1="($(basename $VIRTUAL_ENV)) $PS1"
fi

export PYTHONSTARTUP=${HOME}/.pythonrc.py
export EDITOR=nvim

export CDPATH=.:${HOME}/src

export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

export LESS="-RXF"

# fzf
# https://github.com/junegunn/fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='
--color fg:242,bg:236,hl:65,fg+:15,bg+:239,hl+:108
--color info:108,prompt:109,spinner:108,pointer:168,marker:168
'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

if [ -f /etc/profile.d/autojump.bash ]; then
    source /etc/profile.d/autojump.bash
fi
