# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color)
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    ;;
*)
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    ;;
esac

# Comment in the above and uncomment this below for a color prompt
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# My stuff starts here [EL]

source ${HOME}/.git-completion.bash

export PYTHONSTARTUP=${HOME}/.pythonrc.py
export PATH=${PATH}:${HOME}/scripts

alias l='ls --color -l'
alias a='l -a'

# screen
alias sS='screen -S'
alias sls='screen -ls'
alias sdr='screen -dr'

alias t='python ~/src/t/t.py --task-dir ~/tasks --list tasks'

LANG=en_US.UTF-8
export LANG

LC_CTYPE=en_US.UTF-8
export LC_CTYPE

EDITOR=vim
export EDITOR

#PS1="\[\033[1;30m\][\[\033[1;34m\]\u\[\033[1;30m\]@\[\033[0;35m\]\h\[\033[1;30m\]] \[\033[0;37m\]\W \[\033[1;30m\]\$\[\033[0m\] "
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUPSTREAM="verbose"
#PS1='[\[\033[1;35m\]\W$(__git_ps1 " \[\033[1;34m\](%s)")\[\033[0m\]]\$ '
PS1='[\h \[\033[1;35m\]\W$(__git_ps1 " \[\033[1;34m\](%s)")\[\033[0m\]]\$ '
export PS1

LESS="-RXF"
export LESS

function svndiff () {
    if [ "$1" != "" ]; then
        svn diff $@ | colordiff;
    else
        svn diff | colordiff;
    fi
}

function svnaddremove () {
    for f in $(svn status | grep '^\?' | nawk '{print $2}'); do
        svn add $f;
    done
    for f in $(svn status | grep '^\!' | nawk '{print $2}'); do
        svn rm $f;
    done
}

if [ -f /usr/local/bin/virtualenvwrapper.sh ]
then
    export WORKON=~/.virtualenvs
    source /usr/local/bin/virtualenvwrapper.sh
fi
