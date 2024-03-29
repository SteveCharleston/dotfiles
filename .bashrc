# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# Source global definitions
if [ -f /etc/bash.bashrc ]; then
        . /etc/bash.bashrc
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

#export PS1="\[\e[00;37m\][\[\e[0m\]\[\e[00;32m\]\u@\h\[\e[0m\]\[\e[00;37m\] \[\e[0m\]\[\e[01;34m\]\w\[\e[0m\]\[\e[00;37m\]]\\$ \[\e[0m\]"
#export  PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h: \[\e[33m\]\w\[\e[0m\]\n\$ '
export PS1="\[\e[00;37m\]\n\[\e[0m\]\[\e[00;32m\]\u@\h:\[\e[0m\]\[\e[00;37m\] \[\e[0m\]\[\e[00;34m\]\w\[\e[0m\]\[\e[00;37m\]\n\[\e[0m\]\$ "

alias ls='ls --color=auto'
alias grep='grep --colour=auto'
alias fgrep='fgrep --colour=auto'
alias egrep='egrep --colour=auto'
alias ll='ls -lF'
alias la='ls -A'
alias l='ls -CF'
alias apt='sudo apt'
alias apt-get='sudo apt-get'

export PATH=$HOME/bin/vim/bin:$HOME/bin:/opt/android/sdk/tools:/opt/android/sdk/tools/bin:$PATH

command -v fortune > /dev/null 2>&1 && /usr/bin/env fortune
echo ""

export QSYS_ROOTDIR="/home/steven/bin/altera/15.0web/quartus/sopc_builder/bin"

export ALTERAOCLSDKROOT="/home/steven/bin/altera/15.0web/hld"

# Nativescript Dev
export ANDROID_HOME=$HOME/bin/android/sdk/
#export JAVA_HOME=$(update-alternatives --query javac | sed -n -e 's/Value: *\(.*\)\/bin\/javac/\1/p')
#function emulator { cd "$(dirname "$(which emulator)")" && ./emulator "$@"; }

###-tns-completion-start-###
if [ -f /home/steven/.tnsrc ]; then 
    source /home/steven/.tnsrc 
fi
###-tns-completion-end-###
if command -v ct &> /dev/null; then
    ssh() { /usr/bin/ssh $* | ct; }
fi

if [[ -e ~/.bashrc_custom ]]; then
    source ~/.bashrc_custom
fi
