export PATH=~/opt/desktop/bin:$PATH
xrdb ~/.Xresources
eval $( ssh-agent -t 600 -s )
i3
eval $( ssh-agent -k )
