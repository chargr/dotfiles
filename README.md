# usage

## configure bash/shell environment
```
ansible-playbook site.yml
```

## configure desktop environment
```
ansible-playbook site.yml -t desktop
```

## install required packages for archlinux
```
ansible-playbook -K site.yml -t install
```
