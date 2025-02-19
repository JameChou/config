## Install ArchLinux Guide

<!--ts-->
   * [Install ArchLinux Guide](#install-archlinux-guide)
      * [How to Make A Bootable UEFI USB  Device](#how-to-make-a-bootable-uefi-usb--device)
      * [Install ArchLinux](#install-archlinux)
         * [Boot the ArchLinux by USB Device](#boot-the-archlinux-by-usb-device)
         * [Terminal Font Size](#terminal-font-size)
         * [Forbid the reflector](#forbid-the-reflector)
         * [Connect to the Internet](#connect-to-the-internet)
         * [Update system time&amp;date](#update-system-timedate)
         * [Partion disk](#partion-disk)
         * [Mount disk](#mount-disk)
         * [Make the China mirror source on the top of Mirrorlist](#make-the-china-mirror-source-on-the-top-of-mirrorlist)
         * [Install ArchLinux System](#install-archlinux-system)
         * [Generate fastab file](#generate-fastab-file)
         * [Config system](#config-system)
            * [login to local ArchLinux system](#login-to-local-archlinux-system)
            * [Set timezone](#set-timezone)
            * [locale time](#locale-time)
            * [Set System Name](#set-system-name)
            * [Change root password](#change-root-password)
            * [Install Intel or AMD ucode](#install-intel-or-amd-ucode)
            * [Install Boot Program](#install-boot-program)
            * [Complete installation](#complete-installation)
      * [Config ArchLinux](#config-archlinux)
         * [Update System](#update-system)
         * [Create A New User](#create-a-new-user)
         * [Swap zone](#swap-zone)
         * [pacman support 32 repo](#pacman-support-32-repo)
      * [NetworkManager](#networkmanager)
      * [Install yay](#install-yay)
      * [Install Paru](#install-paru)
      * [Install google-chrome](#install-google-chrome)
      * [Install clash-verge](#install-clash-verge)
      * [Install jetbrains mono](#install-jetbrains-mono)
      * [Install GUI File Manager](#install-gui-file-manager)
      * [Fcitx5](#fcitx5)
         * [方法一](#方法一)
         * [方法二](#方法二)
         * [Config](#config)
      * [壁纸 可使用feh来设置壁纸](#壁纸-可使用feh来设置壁纸)
      * [亮度](#亮度)
      * [音量](#音量)
      * [安装系统剪切板](#安装系统剪切板)
      * [安装Wechat](#安装wechat)
      * [TTL Font &amp;&amp; Kbd](#ttl-font--kbd)
         * [临时设置](#临时设置)
         * [Always](#always)
      * [影音多媒体的一些软件](#影音多媒体的一些软件)
      * [Proxychains](#proxychains)
      * [Crash when updating the system](#crash-when-updating-the-system)
      * [USB自动挂起](#usb自动挂起)
      * [gnupg相关问题](#gnupg相关问题)
      * [更换Wifi6无线网卡](#更换wifi6无线网卡)
<!--te-->


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

```bash
# generate the grub configuration
grub-mkconfig -o /boot/grub/grub.cfg
```

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

### NetworkManager
```bash
sudo pacman -S networkmanager
sudo systemctl disable iwd
sudo systemctl stop iwd
sudo systemctl enable --now NetworkManager
```

```bash
# use networkmanager connect wifi and remember the wifi
nmcli dev wifi list/show

nmcli dev wifi connect <SSID> --ask
# enter the password of wifi

nmcli connection modify <SSID> connection.autoconnect yes
```

### Install yay
[wiki](https://wiki.archlinuxcn.org/wiki/Yay)

```bash
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
```

yay的问题在于因为使用了`go` 语言进行开发，所以对于`proxychains` 这类的代理链软件支持并不友好。所以还是使用`paru` 来作为包管理还是不错的。

### Install Paru
```bash
yay -S paru-bin
```

### Install google-chrome
```bash
yay -S google-chrome
```


### Install clash-verge
[wiki](https://www.clashverge.dev/install.html)
```bash
yay -S clash-verge-rev-bin
```

We should run `clash-verge-service` before running `clash-verge`.

### Install jetbrains mono
```bash
sudo pacman -S ttf-jetbrains-mono
```

这个安装完成之后会发现有一些图标还是没有显示出来，我们还需要安装这个字体的`nerd font`。

```bash
sudo pacman -S tff-jetbrains-mono-nerd
```

然后再打开`nvim` 这时候就可以看到没有问题了。

### Install GUI File Manager
```bash
sudo pacman -S pcmanfm
```

### Fcitx5
start fcitx5 when run dwm.

#### 方法一
modify `.xsession`
```
fcitx5 -d &
slstatus & # the time status at the right corner of dwm
exec dwm
```

#### 方法二
在上一个小章节上我们已经使用`auto-start`这个patch在dwm启动时可以运行一个shell文件。那么也可以把fcitx5的启动放在那里。

```bash
fcitx5 -d &
```

#### Config
下面的配置文件是放在`/etc/environment`这个文件中。
```setting
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
SDL_IM_MODULE=fcitx
```

### 壁纸 可使用`feh`来设置壁纸 
```bash
# in ubuntu
sudo apt-get install feh

# in archlinux
sudo pacman -S feh
```

然后在`autostart.sh`中设置显示壁纸的方式。
```bash
feh --bg-fill --no-fehbg -z ~/Pictures/wallpapers/* &
```

### 亮度
[文档](https://askubuntu.com/questions/1412055/keyboard-backlight-in-ubuntu-22-04)
在`.zshrc`文件中可以对这里的命令来做别名，方便后续的处理

```bash
sudo apt-get install brightnessctl
# 查看当前显示的device信息
brightnessctl -l
# 查看说明文档
man brightnessctl 
# 设置亮度的百分比
sudo brightnessctl --device='intel_backlight' set 70%
# 在当前的亮度上增加5%
sudo brightnessctl --device='intel_backlight' set 5%+
# 在当前的亮度上减少5%
sudo brightnessctl --device='intel_backlight' set 5%-
```

### 音量
```bash
sudo pacman -S sof-firmware alsa-firmware alsa-ucm-conf alsa-utils
```
使用`aplay`命令查看现在的音频情况，然后得到下面的信息，可以看到需要对card1 和 device0进行配置

```bash
aplay -l
```
```
card 1: PCH [HDA Intel PCH], device 0: VT1802 Analog [VT1802 Analog]
  Subdevices: 0/1
  Subdevice #0: subdevice #0
card 1: PCH [HDA Intel PCH], device 1: VT1802 Digital [VT1802 Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: PCH [HDA Intel PCH], device 2: VT1802 Alt Analog [VT1802 Alt Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
```

对`/etc/asound.conf`文件中加入下面的内容，这是对所有的用户都生效，如果是当前用户进行配置，则在`~/.asoundrc`添加以下三行。

```
defaults.pcm.card 1
defaults.pcm.device 0
defaults.ctl.card 1
```

我们可以使用`amixer`命令来设置音量
在`.zshrc`文件中可以对这里的命令来做别名，方便后续的处理

```bash
# 设置音量为90%
amixer sset Master 90% unmute
# 音量减少5%
amixer sset Master 5%- unmute
# 音量增加5%
amixer sset Master 5%+ unmute
```

也可以使用可控的界面去对音量进行设置。 
```bash
alsamixer
```

**注意：在这之前我踩了坑，使用了pipewire去管理我的声音，然后一直有问题，使用paman -Rs pipewire等命令之后才可以解决这个问题**

### 安装系统剪切板
这里可以参考`nevim.md` 文件，在`LazyVim` 的章节中也讲解了为什么要安装这个，主要就是用于我们可以访问我们的系统剪切板，达到neovim与系统的`ctrl + c` 之间的相互访问。

### 安装Wechat
首先第一个我们可以访问下面的官网，然后下载`AppImage` 的形式来加载，然后使用命令`./Wechatxxx` 的方式来打开微信。


### TTL Font && Kbd
经过上面的安装之后，我们登录，然后使用命令`startx`来启动`xserver`服务，但是这个字体很小，需要再对这块进行设置


First: Install terminus-fonts
```bash
sudo pacman -S terminus-font

cd /usr/share/kbd/consolefonts
# 可以使用滚动查找去看有没有文件
ll | less
```

按键设置，主要是对于`Caps_Lock` 和`Control` 键进行互换。

首先先对现有的按键配置copy一份到`/usr/local/share/kbd/keymaps/`

`/usr/share/kbd/keymaps/i386/qwerty/us.map.gz`

```bash
sudo mkdir -p /usr/local/share/kbd/keymaps
cp /usr/share/kbd/keymaps/i386/qwerty/us.map.gz /usr/local/share/kbd/keymaps/ 
```

然后对这个文件进行编辑操作,主要是交换**29(Control)** 和**58(Caps_Lock)**我们可以让这个两者进行互换。

最后在`/etc/vconsole.conf` 文件中加入下面的内容。
```
KEYMAP="/usr/local/share/kbd/keymaps/us.map.gz"
```


安装`mac-font`
```bash
$ yay -S ttf-mac-fonts
```

然后建立`fontconfig`相关的配置文件，文件位置在`~/.config/fontconfig/fonts.conf`以及`~/.config/fontconfig/web-ui-fonts.conf`

主要的配置如下:
```xml
  <!-- Default monospace fonts-->
  <match target="pattern">
    <test name="family">
      <string>monospace</string>
    </test>
    <edit name="family" mode="prepend" binding="strong">
      <!--配置苹果的字体-->
      <string>Lucida Grande</string>
      <string>Apple Garamond</string>
      <string>Noto Sans Mono CJK SC</string>
      <string>Symbols Nerd Font</string>
      <string>Twemoji</string>
      <string>Symbols Nerd Font</string>
    </edit>
  </match>
```

最关键的字体配置是:
```xml
      <string>Lucida Grande</string>
      <string>Apple Garamond</string>
```
这里就是配置`monospace` 使用苹果的字体。

#### 临时设置
Like the install progress at the beginning, use `setfont ter-132b` command to change the font size.

#### Always
```bash
sudo vim /etc/vconsole.conf
```

add the below setting:
```
FONT=ter-132b
```

### 影音多媒体的一些软件

* **图片类软件** 

这个管理工具是在`terminal` 下可以直接查看图片，左右移动也是按照`vim`的快捷键来的。

[imv的package包地址](https://archlinux.org/packages/extra/x86_64/imv/)
**图片类**
```bash
sudo pacman -S imv
```

现在更推荐的是使用`swayimg`
```bash
sudo pacman -S swayimg
```

配置文件在`~/.config/swayimg/config` 

* **视频类**
可以使用`mpv` 这款轻量级的应用。
```bash
sudo pacman -S mpv
```

* **电子书类**
使用`zathura`，[ArchLinux Wiki](https://wiki.archlinux.org/title/Zathura)

```bash
sudo pacman -S zathura zathura-pdf-mupdf
```

配置文件的位置在`~/.config/zathura/zathurarc`，通过配置完全可以使用`vim`的配置来浏览。

### Proxychains
如果在Terminal中想使用代理的话，可以使用`export ALL_PROXY='http://127.0.0.1:<PORT>'`来设定全局变量。这种情况下，绝大多数的命令都能从代理走流量。

```bash
sudo pacman -S proxychains
```

安装完成之后还需要再`/etc/proxychains.conf` 中对代理的地址和端口进行配置。

```
[ProxyList]
# add proxy here ...
# meanwile
# defaults set to "tor"
socks5 	127.0.0.1 7897
```

注意`socks5 127.0.0.1 7892` 这是我的`sock5` 代理地址，也可以配置为`http` 等代码信息，对于`clash verge` 已经做了**混合** 端口的配置。

### Crash when updating the system
这是一次比较有意思的事情，我的笔记本电池已经**dead** 了，有一次我在使用`pacman -Syyu` 命令滚动更新我的系统的时候，一个小朋友不小心把我的电源线给踢到了然后整个系统就断电了，而且更新里面还有`nvidia dkms` 的闭源驱动，更新正在重新写入系统参数。当我重新开机发现`grub` 也没有了，我的内核也损坏了。

解决方案是可以从`ArchLinux`的`LiveCD` 再次进入

```bash
mount /dev/sda1 /mnt

pacstrap /mnt linux linux-firmware
```
重新安装内核，再使用`arch-chroot /mnt`进入系统，修复`grub` 引导。

这种可以挽回一些重要资料，系统还是可以比较正常使用的，可能是因为事情发生的节点正好在更新`nvidia` 驱动的时候。所以`nvidia-smi` 原来可以读到我的驱动程序的，但是后来就再也读不到了。我也尝试再去删除我的内核参数配置也没有办法生效。

### USB自动挂起
[Power Management - USB](https://wiki.archlinuxcn.org/wiki/%E7%94%B5%E6%BA%90%E7%AE%A1%E7%90%86#USB_%E8%87%AA%E5%8A%A8%E6%8C%82%E8%B5%B7)

```conf
ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="05c6", ATTR{idProduct}=="9205", ATTR{power/autosuspend}="-1"
```

上面的方法没有成功，最后可以在内核中把`usbcore.suspend`直接给禁用掉。

编辑`/etc/default/grub` 这个文件。

```conf
GRUB_CMDLINE_LINUX_DEFAULT="loglevel=5 quiet nowatchdog usbcore.autosuspend=-1"
```

在这个文件中加入`usbcore.autosuspend=-1` 表示不自动挂起。

然后再更新grub配置文件。

```bash
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

通过上面的配置，现在2.4G的鼠标就不会再有问题，原来的自动挂起时间太短了，非常不爽！

### gnupg相关问题
记录一次坑，有一次删除软件时使用了`pacman -Rsdd`，这个时候可能不会考虑到一些依赖，直接把`sqlite3` 给删除了，因为`gnupg` 这个加密相关的是使用`sqlite3`所以整个系统都挂掉了。处理这个事情查找到`archwiki` 中也有相关的帖子。

[gnupg挂了的帖子](https://bbs.archlinuxcn.org/viewtopic.php?id=14291)


我们可以把gnupg的包给手动下载下来，然后使用命令安装上去。
```bash
# 首先先删除gnupg
$ sudo rm -f /var/lib/pacman/local/gnupg-2.4.7-1

```

然后重要的是编辑`/etc/pacman.conf`这个文件 
```conf
SigLevel    = Required DatabaseOptional
# SigLevel    = Never
```

我们可以指定验证签名`sig`的级别，先改为`Never`，然后就不需要验证签名了。


```bash
$ sudo pacman -U gnupg-2.4.7-1-x86_64.pkg.tar.zst --overwrite '*'
```

重新安装`gnupg` 包。

```bash
$ sudo pacman-key --init
$ sudo pacman-key --populate
```

重新刷新`key`。记得将`sig` 的级别改为正常状态。这时候再试一试使用`pacman -Syyu` 这样的命令是否可以正常的更新。


### 更换Wifi6无线网卡
更换了AX系列的显卡，但是启动之后发现无法使用，这个系列的显卡在`Linux 5.x` 之后就已经在内核中驱动了，可以直接使用*Intel* 的相关的内核驱动了。

```bash
# 查看现在的无线网卡以及蓝牙信息
$ rfkill

# 解锁无线网卡
$ rfkill unblock wlan

# 解锁蓝牙
$ rfkill unblock bluetooth
```

这里的是使用`rfkill`命令，可以查看输出的结果。

```bash
$ rfkill
ID TYPE      DEVICE              SOFT      HARD
 0 bluetooth hci0           unblocked unblocked
 1 wlan      dell-wifi      unblocked unblocked
 2 bluetooth dell-bluetooth unblocked unblocked
 3 wlan      phy0           unblocked unblocked

```

如果输出的结果中`SOFT` 中显示的数据是`blocked` 那么就说明这里的显卡已经无法被使用了，那么再使用`rfkill unblock wlan` 等相关命令去开启。然后再使用`iwctl` 等命令去链接wifi。



