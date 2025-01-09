## Install ArchLinux Guide

### How to Make A Bootable UEFI USB  Device

**Linux or macOS**
```bash
fdisk -l                    # for checking the disks on my computer
sudo umount /dev/sdx   # umount the device
sudo dd bs=4M if=/path/to/the/system/iso of=/dev/sdx status=progress     #write the image to the disk
```

### Install ArchLinux

#### Boot the ArchLinux by USB Device

#### Terminal Font Size
ArchLinux wiki installation guide [link](https://wiki.archlinux.org/title/Installation_guide).
```bash
setfont ter-132b
```

#### Forbid the reflector
```bash
systemctl stop reflector.service
```

#### Connect to the Internet
```bash
iwctl  # login into IWD service control panel
device list # show all aviable device on the computer
station wlan0 scan # wireless network scan all the wifi signal environment
station wlan0 connect YOUR-WIFI
exit
```

than check the internet work status
```bash
ping baidu.com
```

#### Update system time&date
```bash
timedatectl set-ntp true # sync the sytem time and internet time
timedatectl status # check timedate status
```

#### Partion disk
```bash
fdisk -l # list the disk on your computer
fdisk /dev/sdx # partion disk
```

When enter the fdisk control command panel, use `g` create a `GPT` partion, use `n` command create a `new partion`, for example use `+800M ` to create a 800M size section.

```
/dev/sda1 800M for /efi
/dev/sda2 100G for /
/dev/sda3 left all size for /home
```

**format the table**
```bash
mkfs.ext4 /dev/sda2 # format /
mkfs.ext4 /dev/sda3 # format /home

mkfs.vfat /dev/sda1 # format /efi
```

#### Mount disk
```bash
mount /dev/sda2 /mnt
mkdir /mnt/home
mount /dev/sda3 /mnt/home
mkdir /mnt/efi
mount /dev/sda1 /mnt/efi
```

#### Make the China mirror source on the top of Mirrorlist
```bash
vim /etc/pacman.d/mirrorlist
```

**move USTC and Tsinghua source to top**
```
Server = https://mirrors.ustc.edu.cn/archlinux/$arch
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch
```

#### Install ArchLinux System
Install the base system on computer. `base`, `base-devel`, `linux` etc.

```bash
pacstrap /mnt base base-devel linux linux-headers linux-firmware
```

Install nesscary softwares.
```bash
pacstrap /mnt dhcpcd iwd vim bash-completion
```

#### Generate fastab file
```bash
genfstab -U /mnt >> /mnt/etc/fstab
```

Recheck the fstab file content.
```bash
cat /mnt/etc/fstab
```

#### Config system


##### login to local ArchLinux system
```bash
arch-chroot /mnt
```

##### Set timezone
```bash
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime # set timezone to Shanghai
hwclock --systohc  # sync time
```

##### locale time
```bash
vim /etc/locale.gen # remove `#` en_US.UTF-8 and zh_CN.UTF-8
locale-gen
echo 'LANG=en_US.UTF-8' > /etc/locale.conf
```

##### Set System Name
```bash
vim /etc/hostname
# then edit /etc/hostname, set your computer name to xinyu or other names

vim /etc/hosts

```

etc `/etc/hosts` content
```
127.0.0.1  localhost
::1            localhost
127.0.0.1  xinyu
```

##### Change root password
```bash
passwd root
```

##### Install Intel or AMD ucode
```bash
pacman -S intel-ucode # for Intel cpu
pacman -S amd-ucode # for AMD cpu
```

##### Install Boot Program
```bash
pacman -S grub efibootmgr 
grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB
```

```bash
vim /etc/default/grub
```

Remove `quiet` in `GRUB_CMDLINE_LINUX_DEFAULT` and change `log level` from `3` to `5`, add `nowatchdog` parameter.


##### Complete installation
```bash
exit
umount -R /mnt
reboot
```

### Config ArchLinux

Connect internet.
```bash
sytemctl start dhcpcd
sytemctl start iwd
iwctl # same way to connect internet when I was installing the archlinux
```


#### Update System
```bash
pacman -Syyu # update the system to-up-date
```

#### Create A New User
```bash
useradd -m -G wheel -s /bin/bash xinyu
passwd xinyu # change xinyu's(new user) password
EDITOR=vim visudo
```

remove `#` on `#%wheel ALL=(ALL:ALL) ALL`

#### Swap zone
```bash
dd if=/dev/zero of=/swapfile bs=1M count=4096 status=progress # create a 4GB swap zone
chmod 600 /swapfile
mkswap /swapfile # format swap partion
swapon /swapfile # turn on swap partion
```

write swapfile to `fstab`
```bash
vim /etc/fstab
```

```
/swapfile none swap defaults 0 0
```

#### pacman support 32 repo
```bash
vim /etc/pacman.conf
```

remove `multilib` `#`
```bash
pacman -Syyu
```

























