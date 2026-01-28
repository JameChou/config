# ml4w hyprland设置

官方上面也是直接推荐我们使用最纯净的*[[installarchlinux]]*操作系统，以防有其他的干扰项。

[ml4w官网](https://www.ml4w.com/)

![ml4w设置界面](./images/ml4w-welcome.jpg)

## How to install


### 安装flatpak

这个软件是使用`flatpak` 来作为运行环境的。

```zsh
# install the flatpak
sudo pacman -S flatpak
```

flatpak需要使用国内的源才可以有比较好的速度。
```zsh
flatpak remote-modify flathub --url=https://mirrors.ustc.edu.cn/flathub
```

通过上面的命令我们则可以将源改到国内来。

### 安装ml4w安装软件程序

```zsh
flatpak install com.ml4w.dotfilesinstaller
```

等待安装完成之后，运行此软件。

```zsh
# to accelarte the internet speed, we should use the proxy before run this program
# export ALL_PROXY if necessary

flatpak run com.ml4w.dotfilesinstaller
```

通过代理的话则可以正确的安装。

### 窗口的间隔更改

**对各个窗口之间的间隔进行更改**

目录在`.config/hypr/conf/windows/default.conf`

```ini
general {
    gaps_in = 2
    gaps_out = 3 
    border_size = 1
    col.active_border = $color8 $on_primary 90deg
    col.inactive_border = $on_primary
    layout = dwindle
    resize_on_border = true
}
```

### 启动设置

在目录`autostart.conf` 中添加下面处理

```zsh
# 启动fcitx5输入法
exec-once = fcitx5 -d

# 设置屏幕的dpi,尤其是在高分屏下，因为像微信如果设置QT SCALE那个配置还是会有一些问题。
# 只有通过如下的设置才可以。
exec-once = xrdb -merge <<< 'Xft.dpi: 180'
```

### 切换shell为zsh
这里需要注意一下，如果是直接使用`Welcome` 那个app安装的时候是无法通过proxy的，因为hyprland我现在还不知道如何设置`System Proxy`。

可以通过如下命令找到需要可执行的文件目录 `.mydotfiles/com.ml4w.dotfiles.stable/.config/ml4w/scripts/shell.sh`。

```zsh
rg "Please select your" --hidden
```

最后执行这个文件(可在这个执行动作前开启代理):

```zsh
sh .mydotfiles/com.ml4w.dotfiles.stable/.config/ml4w/scripts/shell.sh
```




