# usage

## configure bash/shell environment
```
ansible-playbook site.yml
```

## configure desktop environment
```
ansible-playbook site.yml -t desktop
```

## add the "install" tag to install packages
```
ansible-playbook -K site.yml -t install             # cli packages
ansible-playbook -K site.yml -t desktop,install     # desktop packages
```
