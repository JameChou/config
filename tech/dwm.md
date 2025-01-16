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


**在计算上行和下行数据时，脚本里使用了bc命令，在初始化中时并没有安装这个命令，所以需要先安装这个工具** 
```bash
# to install the bc tool
sudo pacman -S bc
```

<++>

`dwm-status-refresh.sh`
```bash
#!/bin/bash
# Screenshot: http://s.natalian.org/2013-08-17/dwm_status.png
# Network speed stuff stolen from http://linuxclues.blogspot.sg/2009/11/shell-script-show-network-speed.html

# This function parses /proc/net/dev file searching for a line containing $interface data.
# Within that line, the first and ninth numbers after ':' are respectively the received and transmited bytes.
function get_bytes {
	# Find active network interface
	interface=$(ip route get 8.8.8.8 2>/dev/null| awk '{print $5}')
	line=$(grep $interface /proc/net/dev | cut -d ':' -f 2 | awk '{print "received_bytes="$1, "transmitted_bytes="$9}')
	eval $line
	now=$(date +%s%N)
}

# Function which calculates the speed using actual and old byte number.
# Speed is shown in KByte per second when greater or equal than 1 KByte per second.
# This function should be called each second.

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
	memfree=$(($(grep -m1 'MemAvailable:' /proc/meminfo | awk '{print $2}') / 1024 / 1024))
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

xsetroot -name "  💿 $(print_mem)G | 上行 $vel_recv | 下行 $vel_trans | $(dwm_alsa) | $(show_record) $(print_date) "

# Update old values to perform new calculations
old_received_bytes=$received_bytes
old_transmitted_bytes=$transmitted_bytes
old_time=$now

exit 0
```

