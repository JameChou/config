## DWM Installation Guide

### Download the repo
这个是官方的库，这个库还没有相关的配置，如果想使用`github` 上自己的配置可以先加载出来，因为要使用`proxychains4`工具去从`github` 上把自身的库给加载进来。
```bash
sudo pacman -S git
git clone https://git.suckless.org/dwm
git clone https://git.suckless.org/st
git clone https://git.suckless.org/dmenu

cd dwm
sudo make clean install

cd ../st
sudo make clean install

cd ../dmenu
sudo make clean install

```

### Install Xorg

```bash
sudo pacman -S xorg xorg-xinit

cp /etc/X11/xinit/xinitrc ~/.xinitrc
sudo vim .xinitrc

echo `exec dwm` >> ~/.xinitrc
startx # to start xorg
```

#### How to use dwm on ubuntu
Please modify the grub configruation file by `/etc/default/grub`. 

remove `quiet splash` parameters in key `GRUB_CMDLINE_LINUX_DEFAULT`, change the value to `text`, after update the config should be:
```
GRUB_CMDLINE_LINUX_DEFAULT = "text"
```

that means, ubuntu start with the tty(text) command line, will not start with GUI(gm3)
```bash
systemctl set-default_multi-user.target # enable multi user to login the system

systemctl set-default graphical.target # enable GUI
```

finally modify the `~/.xsession`, if the file not at `$HOME` that create a new one.
```bash
touch ~/.xsession # not have one
echo 'exec dwm` >> ~/.xsession
```

### Network Manager
Clone the AUR package to local

```bash
cd ~/software
git clone https://aur.archlinux.org/networkmanager-dmenu-git.git
cd networkmanager-dmenu
makepkg -si
```

Disabled the iwd service.
```bash
sudo systemctl disable iwd
sudo systemctl stop iwd
sudo systemctl enable --now NetworkManager
```

In dwm, press MODKEY + p to open `dmenu` then search network-manager, they will show all the networks in the environment, connect a signal, enter pharse.

```bash
ping baidu.com
```

### status
我们需要先patch startup一个补丁，然后在`dwm.c`中更改start.sh的位置
```c
runAutostart(void) {
	// system("cd ~/software/bin/dwm.script; ./autostart_blocking.sh");
	// 这里我指定了，当我dwm启动时我需要自动运行的脚本
	system("cd ~/Software/bin/dwm.script; ./autostart.sh &");
}
```

在`autostart.sh`中添加`status`相关的shell文件，在启动时运行起来。
```bash
/bin/bash ~/Software/bin/dwm.script/dwm-status.sh &
```


**在计算上行和下行数据时，脚本里使用了bc命令，在初始化中时并没有安装这个命令，所以需要先安装这个工具** 
```bash
# to install the bc tool
sudo pacman -S bc
```

这个文件`dwm-status-refresh.sh`是对状态栏进行刷新操作的`shell`。

