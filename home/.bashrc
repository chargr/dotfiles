#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# color prompt and display exit code
PS1='\[\e[0;33m\][\[\e[1;34m\]$?\[\e[0;33m\]]\n\[\e[1;34m\][\[\e[1;37m\]\u\[\e[1;34m\]@\[\e[1;37m\]\h\[\e[1;34m\]:\[\e[0;33m\]\W\[\e[1;34m\]]\[\e[0;33m\]\$ \[\e[0m\]' 

# use vim for things
export EDITOR=vim
alias vi='vim'

# color mode aliases commands
alias ls='ls --color=auto'
alias grep='grep --color=auto'
