## Fcitx5 Configuration

<!--ts-->
   * [Fcitx5 Configuration](#fcitx5-configuration)
      * [Installation](#installation)
      * [Integriate with the dwm](#integriate-with-the-dwm)
      * [How to start fcitx5](#how-to-start-fcitx5)
         * [xorg](#xorg)
         * [sway(wayland)](#swaywayland)
      * [set the input method](#set-the-input-method)
      * [与系统的语言的配置关系](#与系统的语言的配置关系)
      * [配置皮肤](#配置皮肤)
      * [configtool 配置文件所在位置](#configtool-配置文件所在位置)
<!--te-->

### Installation
```bash
pacman -S fcitx5 fcitx5-chinese-addons fcitx5-configtool fcitx5-qt 
```

### Integriate with the dwm

1. dwm should be installed the patch autostart
2. config the autostart autorun script, like  `~/software/bin/dwm.script/autostart.sh`
3. add the shell to the auto run shell script like below



```bash
fcitx5 &

# fcitx5 也提供了daemon的方式来运行启动
fcitx5 -d
```

### How to start fcitx5

#### xorg

```bash
vim ~/.xinitrc
```

add start fcitx5 command on bottom of file
```
fcitx5 -d
```

#### sway(wayland)
```conf
exec_always --no-startup-id  fcitx5 -d
# switch the input method
bindsym $mod+space exec fcitx5-remote -t && notify-send -u normal -r 3289 -t 1100 "$(fcitx5-remote -n)"
```

`bindsym $mod+space exec fcitx5-remote -t && notify-send -u normal -r 3289 -t 1100 "$(fcitx5-remote -n)"` 这一段表示使用命令去切换输入法，这时候打开`fcitx5-configtool`把原先的切换输入法的配置替换掉。

![fcitx5 配置界面图](./images/fcitx5_config.png)

### set the input method
```bash
# dwm run program
modkey + p
# search fcitx5-config-tool then add wubi to the input method list
# use control+space to switch input method
```

### 与系统的语言的配置关系
在实际的操作当中，在`/etc/localeconfg` 这个文件当中，如果我们设置的语言为`en_US`时，无论是否按上面正确的配置了`fcitx5` 依旧还是无法正确的唤醒`fcitx5`，必须要正确的设置系统语言为`zh_CN`才可以打开`fcitx5`。

### 配置皮肤

```bash

sudo pacman -S fcitx5-material-color
```

然后再使用`fcitx5-configtool` 去更改皮肤


### configtool 配置文件所在位置

`configtool` 是一个图形化的配置管理器，当然也可以直接在`fcitx5` 的配置文件中进行配置。`layout` 的配置文件在`~/.config/fcitx5/profile` 中

```
[Groups/0]
# Group Name
Name=Default
# Layout
Default Layout=us
# Default Input Method
DefaultIM=wbx

[Groups/0/Items/0]
# Name
Name=keyboard-us
# Layout
Layout=

[Groups/0/Items/1]
# Name
Name=wbx
# Layout
Layout=

[GroupOrder]
0=Default

```

**上面这个示例则是fictx5 configtool生成的配置文件**，配置了我所使用的两种键盘布局。


那么关于皮肤一类的配置内容则是存在`~/.config/fcitx5/conf/classicui.conf` 中。

```
# 垂直候选列表
Vertical Candidate List=False
# 使用鼠标滚轮翻页
WheelForPaging=True
# 字体
Font="Sans 10"
# 菜单字体
MenuFont="Sans 10"
# 托盘字体
TrayFont="Sans Bold 10"
# 托盘标签轮廓颜色
TrayOutlineColor=#000000
# 托盘标签文本颜色
TrayTextColor=#ffffff
# 优先使用文字图标
PreferTextIcon=False
# 在图标中显示布局名称
ShowLayoutNameInIcon=True
# 使用输入法的语言来显示文字
UseInputMethodLanguageToDisplayText=True
# 主题
Theme=Material-Color-Blue
# 深色主题
DarkTheme=default
# 跟随系统浅色/深色设置
UseDarkTheme=False
# 当被主题和桌面支持时使用系统的重点色
UseAccentColor=True
# 在 X11 上针对不同屏幕使用单独的 DPI
PerScreenDPI=False
# 固定 Wayland 的字体 DPI
ForceWaylandDPI=0
# 在 Wayland 下启用分数缩放
EnableFractionalScale=True
```

**注意** 我使用了`fcitx5-material-color` 这个安装包。上面的配置也进行了展示。

## 安装Rime

```zsh
sudo pacman -S fcitx5-rime
```

安装完成之后，可以在`config tools` 中添加`rime` 中添加输入法。 

[Rime极点五笔输入法配置方案](https://github.com/kingzcheung/rime-wubi)

Rime在Linux下面的配置路径在`~/.local/share/fcitx5/rime` 只需要把上面的方案给拷贝到这个目录中去就可以了。

```zsh
git clone https://github.com/kingzcheung/rime-wubi.git ~/Documents/
cd ~/.local/share/fcitx5/rime
cp -R ~/Documents/rime-wubi/* .
```

然后重启`fcitx5` 服务。

## 环境变量配置

下面的配置文件是放在`/etc/environment`这个文件中。
```setting
XIM="fcitx"
# GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
INPUT_METHOD=fcitx
SDL_IM_MODULE=fcitx
GLFW_IM_MODULE=fcitx
```


在上面的配置还差一个`gtk` 的相关配置，根据 [fcitx5 wayland 配置](https://fcitx-im.org/wiki/Using_Fcitx_5_on_Wayland) 中的说明，gtk有三个版本，`gtk2` 、`gtk3` `gtk4` 三个配置。

配置分别为:
**gtk2.0**: 在`~/.config/.gtkrc-2.0` 中添加如下配置:

```
gtk-im-module="fcitx"
```

**gtk3.0**: 在`~/.config/gtk-3.0/setting.ini` 中添加如下配置

```ini
[Settings]
gtk-im-module=fcitx
```

**gtk4.0**: 在`~/.config/gtk-4.0/setting.ini` 中添加如下配置

```ini
[Settings]
gtk-im-module=fcitx
```



