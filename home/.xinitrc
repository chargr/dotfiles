export PATH=~/opt/desktop/bin:$PATH
xrdb ~/.Xresources
eval $( ssh-agent -s -t 900 )
i3
eval $( ssh-agent -k )
