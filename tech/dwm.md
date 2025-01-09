## DWM Installation Guide

### Download the repo
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
sudo pacman -S xorg xorg-init

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

`dwm-status-refresh.sh`
```bash
#!/bin/bash

# 死循环，每一段时间再去执行dwm-status-refresh.sh，来刷新状态栏的信息。
while true
do
	bash ./dwm-status-refresh.sh
	sleep 2
done
```

`dwm-status-refresh.sh`

```bash
#!/bin/bash
# 获得已经上网的数据流量
function get_bytes {
	# Find active network interface
	interface=$(ip route get 8.8.8.8 2>/dev/null| awk '{print $5}')
	line=$(grep $interface /proc/net/dev | cut -d ':' -f 2 | awk '{print "received_bytes="$1, "transmitted_bytes="$9}')
	eval $line
	now=$(date +%s%N)
}


function get_velocity {
	value=$1
	old_value=$2
	now=$3

	timediff=$(($now - $old_time))
	velKB=$(echo "1000000000*($value-$old_value)/1024/$timediff" | bc)
	if test "$velKB" -gt 1024
	then
		echo $(echo "scale=2; $velKB/1024" | bc)MB/s
	else
		echo ${velKB}KB/s
	fi
}

# Get initial values
get_bytes
old_received_bytes=$received_bytes
old_transmitted_bytes=$transmitted_bytes
old_time=$now

print_volume() {
	volume="$(amixer get Master | tail -n1 | sed -r 's/.*\[(.*)%\].*/\1/')"
	if test "$volume" -gt 0
	then
		echo -e "\uE05D${volume}"
	else
		echo -e "Mute"
	fi
}

print_mem(){
	memfree=$(($(grep -m1 'MemAvailable:' /proc/meminfo | awk '{print $2}') / 1024))
	echo -e "$memfree"
}

print_temp(){
	test -f /sys/class/thermal/thermal_zone0/temp || return 0
	echo $(head -c 2 /sys/class/thermal/thermal_zone0/temp)C
}

#!/bin/bash

print_date(){
	date '+%Y年%m月%d日 %H:%M'
}

show_record(){
	test -f /tmp/r2d2 || return
	rp=$(cat /tmp/r2d2 | awk '{print $2}')
	size=$(du -h $rp | awk '{print $1}')
	echo " $size $(basename $rp)"
}


LOC=$(readlink -f "$0")
DIR=$(dirname "$LOC")
export IDENTIFIER="unicode"

#. "$DIR/dwmbar-functions/dwm_transmission.sh"
#. "$DIR/dwmbar-functions/dwm_cmus.sh"
#. "$DIR/dwmbar-functions/dwm_resources.sh"
#. "$DIR/dwmbar-functions/dwm_battery.sh"
#. "$DIR/dwmbar-functions/dwm_mail.sh"
#. "$DIR/dwmbar-functions/dwm_backlight.sh"
. "$DIR/dwmbar-functions/dwm_alsa.sh"
#. "$DIR/dwmbar-functions/dwm_pulse.sh"
#. "$DIR/dwmbar-functions/dwm_weather.sh"
#. "$DIR/dwmbar-functions/dwm_vpn.sh"
#. "$DIR/dwmbar-functions/dwm_network.sh"
#. "$DIR/dwmbar-functions/dwm_keyboard.sh"
#. "$DIR/dwmbar-functions/dwm_ccurse.sh"
#. "$DIR/dwmbar-functions/dwm_date.sh"

get_bytes

# Calculates speeds
vel_recv=$(get_velocity $received_bytes $old_received_bytes $now)
vel_trans=$(get_velocity $transmitted_bytes $old_transmitted_bytes $now)

xsetroot -name "  💿 $(print_mem)M ⬇️ $vel_recv ⬆️ $vel_trans $(dwm_alsa) $(show_record) $(print_date) "

# Update old values to perform new calculations
old_received_bytes=$received_bytes
old_transmitted_bytes=$transmitted_bytes
old_time=$now

exit 0
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

### 壁纸 可使用`feh`来设置壁纸 
```bash
sudo apt-get install feh
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


