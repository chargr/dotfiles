# usage

## configure bash/shell environment
```
ansible-playbook site.yml
```

## YouCompleteMe
```
ansible-playbook site.yml -t ycm                    # checkout and build
ansible-playbook site.yml -t ycm,install            # install build dependencies
```

## configure desktop environment
```
ansible-playbook site.yml -t desktop
```

## add the "install" tag to install packages
```
ansible-playbook -K site.yml -t install             # cli packages
ansible-playbook -K site.yml -t desktop,install     # cli + desktop packages
```
