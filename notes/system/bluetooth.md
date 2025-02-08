## Bluetooth Configuration

<!--ts-->
   * [Bluetooth Configuration](#bluetooth-configuration)
      * [Install the BCM driver firmware](#install-the-bcm-driver-firmware)
      * [Start Bluetooth Service](#start-bluetooth-service)
      * [Install bluetooth util](#install-bluetooth-util)
      * [删除某个设备](#删除某个设备)
      * [Trust某个设备](#trust某个设备)
      * [开机即可以被发现](#开机即可以被发现)
<!--te-->

### Install the BCM driver firmware
```bash
yay -S bcm20703a1-firmware
```


### Start Bluetooth Service

```bash
# to confirm the operation system has started the bluetooth serivce yet
sudo systemctl status bluetooth

#if the service didn't start, run the below command
sudo systemctl start bluetooth
```


### Install bluetooth util
```bash
sudo pacman -S bluez-utils
```


Use `bluetoothctl` to enter the config command.

[ArchLinux Bluetooth Wiki](https://wiki.archlinuxcn.org/wiki/%E8%93%9D%E7%89%99)


**An example, bluetoothctl** 

```
[NEW] Controller 00:10:20:30:40:50 hostname [default]
[bluetooth]# agent KeyboardOnly
Agent registered

[bluetooth]# default-agent
Default agent request successful

[bluetooth]# power on
Changing power on succeeded
[CHG] Controller 00:10:20:30:40:50 Powered: yes

[bluetooth]# scan on
Discovery started
[CHG] Controller 00:10:20:30:40:50 Discovering: yes
[NEW] Device 00:12:34:56:78:90 device name
[CHG] Device 00:12:34:56:78:90 LegacyPairing: yes

[bluetooth]# pair 00:12:34:56:78:90
Attempting to pair with 00:12:34:56:78:90
[CHG] Device 00:12:34:56:78:90 Connected: yes
[CHG] Device 00:12:34:56:78:90 Connected: no
[CHG] Device 00:12:34:56:78:90 Connected: yes
Request PIN code
[agent] Enter PIN code: 1234
[CHG] Device 00:12:34:56:78:90 Paired: yes
Pairing successful
[CHG] Device 00:12:34:56:78:90 Connected: no

[bluetooth]# connect 00:12:34:56:78:90
Attempting to connect to 00:12:34:56:78:90
[CHG] Device 00:12:34:56:78:90 Connected: yes
Connection successful
```


1. `power on` 开启蓝牙设备。
2. `scan on` 开始对周围的环境进行扫描操作。
3. `deivces` 来获得要配对的设备的MAC地址等信息。
4. `pair MAC_ADDRESS` 对某个设备进行配对操作。
5. 如果配对设备不需要PIN，那么可能需要将设备添加到信任列表，使用命令`trust MAC_ADDRESS`。
6. 使用命令`connect MAC_ADDRESS` 建立连接。

### 删除某个设备
```bash
remove XX:00:XX:XX:XX
```

可以使用命令对某个已经配对的设备进行删除操作。

或者我们进行`/var/lib/bluetooth` 下面找到本机对应的`Mac` 地址下的文件夹，然后再对里面的某个设备删除，或者编辑。


### Trust某个设备

```bash
# 进入bluetoothctl 管理控制台
bluetoothctl

# 表示信任某个设备
trust 00:18:xx:xx:xx
```

我的Filco Ninja机械键盘在使用的时候有这么一个问题：连接成功之后在第二次连接的时候会出现一直断连的情况，需要手动的输入，信任此设备才可以正常的使用。

### 开机即可以被发现
编辑`/etc/bluetooth/main.conf`文件，在`General` 中加入

```
[General]
DiscoverableTimeout = 0
```




