export PATH=~/opt/desktop/bin:$PATH
xrdb ~/.Xresources
eval $( ssh-agent -s )
ssh-add ~/.ssh/id_ed25519_sk
i3
eval $( ssh-agent -k )
