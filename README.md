# introduction

documenting the linux install of my new laptop

# prep


## make usb boot (from another linux host)

download latest [archlinux iso](https://mirrors.edge.kernel.org/archlinux/iso/latest/archlinux-x86_64.iso)

insert usb

check dmesg for drive letter
```
[1831048.139921] scsi 8:0:0:0: Direct-Access     SanDisk  Ultra USB 3.0    1.00 PQ: 0 ANSI: 6
[1831048.140584] sd 8:0:0:0: [sdg] 60062500 512-byte logical blocks: (30.8 GB/28.6 GiB)
[1831048.141241] sd 8:0:0:0: [sdg] Write Protect is off
[1831048.141243] sd 8:0:0:0: [sdg] Mode Sense: 43 00 00 00
[1831048.141541] sd 8:0:0:0: [sdg] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[1831048.148139]  sdg: sdg1
[1831048.148307] sd 8:0:0:0: [sdg] Attached SCSI removable disk
```

or lsblk or similar.  just get the right disk for dd.
```
$ lsblk
NAME            MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
sda               8:0    0   3.6T  0 disk
sdb               8:16   0   3.6T  0 disk
sdc               8:32   0   3.6T  0 disk
sdd               8:48   0   3.6T  0 disk /data
sde               8:64   0   3.6T  0 disk
sdf               8:80   0   3.6T  0 disk
sdg               8:96   1  28.6G  0 disk
`-sdg1            8:97   1  28.6G  0 part
nvme0n1         259:0    0 465.8G  0 disk
|-nvme0n1p1     259:1    0   488M  0 part /efi
`-nvme0n1p2     259:2    0 465.3G  0 part
  |-vol0-root   254:0    0    64G  0 lvm  /
  |-vol0-home   254:1    0   256G  0 lvm  /home
  `-vol0-docker 254:2    0    64G  0 lvm  /docker
```

dd the image (be careful on drive letter!)
```
$ sudo dd if=archlinux-x86_64.iso of=/dev/sdg bs=4M
201+1 records in
201+1 records out
843395072 bytes (843 MB, 804 MiB) copied, 10.0531 s, 83.9 MB/s
# dont forget to eject (reclaims "g" for re-use)
$ sudo eject /dev/sdg
```

### disk blocked by security policy?
disable secure boot /shrug


# installation
https://wiki.archlinux.org/title/installation_guide

## get on the wifi
```
iwctl --passphrase wifipassword station wlan0 connect ownish
```

## setup disk

### repartition
```
parted /dev/nvme0n1
# delete all the things (DESTROY ALL THE THINGS)
rm 4
rm 3
rm 2
rm 1
# create new stuff
mkpart primary 2048s 512MB fat32
align-check opt 1
# because these were the flags before we deleted it
set 1 msftdata off
set 1 boot on
set 1 esp on
# this was sloppy
mkpart primary 512MB -1
check-align opt 2
```

### create some volume groups

```
pvcreate /dev/nvme0n1
vgcreate vol0 /dev/nvme0n1
lvcreate -n swap -L8G vol0
lvcreate -n root -L64G vol0
lvcreate -n home -L128G vol0
```

### format new partitions
```
mkfs.ext4 /dev/vol0/root
# no root resevation for /home
mkfs.ext4 -m 0 /dev/vol0/home
mkswap /dev/vol0/swap

```

### mount
```
mount /dev/vol0/root /mnt
mount --mkdir /dev/nvme0n1p1 /mnt/boot
mount --mkdir /dev/vol0/home /mnt/home
swapon /dev/vol0/swap
```

### install base OS
pacstrap all the tools we need for the rest of these setup steps and first boot

```
pacstrap /mnt base linux linux-firmware grub efibootmgr vim lvm2 iwd
```

rest of arch install documentation... timezone/lang/locale/etc...

### bootloader
```
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
```

### enable lvm
```
# add lvm2 to hooks
vim /etc/mkinitcpio.conf
mkinitcpio -P

# add lvm to preload modules
vim /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
```

### reboot

```
# exit chroot
umount -R /mnt
reboot
```