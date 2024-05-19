# ~/.bashrc

# exit if not running interactively
[[ $- != *i* ]] && return

# prompt
PS1='\[\e[0;33m\][\[\e[1;34m\]$?\[\e[0;33m\]]\n\[\e[1;34m\][\[\e[1;37m\]\u\[\e[1;34m\]@\[\e[1;37m\]\h\[\e[1;34m\]:\[\e[0;33m\]\W\[\e[1;34m\]]\[\e[0;33m\]\$ \[\e[0m\]'

# editor
export EDITOR=vim

# aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vi='vim'

# end
