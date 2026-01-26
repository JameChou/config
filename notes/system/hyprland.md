## hyprland的相关配置

hyprland是一个wayland下的窗口管理器，其效果还是相当不错的，我已经尝试过了`X11` 以及 wayland下的*i3* 替代软件`sway`，其实sway的使用效果还是不错的，但是因为sway对于`nvidia` 的显卡基本是没有支持的，所以最终还是选择了hyprland。

<!--ts-->
   * [hyprland的相关配置](#hyprland的相关配置)
      * [安装](#安装)
      * [配置](#配置)
         * [nVidia配置](#nvidia配置)
         * [多屏幕](#多屏幕)
<!--te-->

### 安装

安装还是比较简单的，可以直接使用pacman进行管理。
```bash
sudo pacman -S hyprland
```

### 配置
配置文件在`~/.config/hypr/hyprland.conf`这个文件下面。

#### nVidia配置
这里可以查看[nVidia配置](./video_accleration.md)

#### 多屏幕
```conf
monitor=eDP-1,3840x2160@60,0x0,2
monitor=DP-1,3840x2160@60,1920x0,1.5
```

这里是对不同的接口进行配置。
可以指定分辨率以及位置和缩放。**位置这里需要注意是按缩放进行计算的**。

```conf
# Super + Shift + <
# 移动当前的window去上一个显示器
bind = $mainMod SHIFT, comma, movewindow, mon:l

# Super + Shift + > 
# 移动当前的window去下一个显示器
bind = $mainMod SHIFT, period, movewindow, mon:r

# Super + Control + <
# 聚焦到上一个显示器
bind = $mainMod CONTROL, comma, focusmonitor, +1

# Super + Control + >
# 聚焦到上一个显示器
bind = $mainMod CONTROL, period, focusmonitor, -1
```

#### 使程序使用wayland协议
类似于Chrome的这一类，我们可以使用`*-flags.conf` 文件去配置如*Chrome* 程序，在`~/.config` 目录下，新建`chromg-flags.conf`

```conf
--enable-features=UseOzonePlatform
--ozone-platform=wayland
--enable-features=WebRTCPipeWireCapturer
--disable-features=WaylandFractionalScaleV1
--enable-wayland-ime
# --gtk-version=4
--wayland-text-input-version=3

```
Chrome在启动时会根据这里的配置文件使用wayland以及wayland-input的协议，达到使用的要求。

当然我们可以在`*.desktop` 文件中加入启动的参数。

以Electron的程序typora程序来举例，我们可以更改`~/.local/share/applications/typora.desktop` ，在启动部分加入参数。

```config
Exec=typora --ozone-platform=wayland --enable-wayland-ime %U
```

`--ozone-platform=wayland` 表示这个程序启动的时候使用wayland协议
`--enable-wayland-ime` 表示使用wayland的输入法

### Hyprland高分屏

**重点这里需要去讲一下jetbrains的相关程序**:

* jetbrains的所有IDE都是使用java swing开发库去开发的，java的原生程序在Linux上的协议是X11，这样导致像在Hyprland这种wayland合成器，无法有效的对其进行缩放。

所以我们如果想在X11下对字体和界面有一个很好的渲染效果，可以使用下面的配置在`~/.config/hypr/hyprland.conf` 中对于X11的缩放设置为0，这样缩放就交于X11的程序自行判断是否要进行缩放处理。

```conf
xwayland {
    force_zero_scaling = true
}
```

然后在`vmoptions` 配置文件中，加入缩放条件，不过使用这样的形式处理之后，体验还是相当差的，如右边框的小图标鼠标放上去之后无法有效的捕捉到。

```options
-Dsun.java2d.uiScale=2
-Dsun.java2d.uiScale.enabled=true
```
这个配置就是表示需要将IDE进行2倍的缩放处理。

不过后来找到了更好的解决方案，那就是使用启动的方式，指定使用wayland的tool那么就解决了这个问题。

更改`~/.local/share/applications/idea.desktop` 文件

```conf
# 这种方式好像在启动的时候并没有用
Exec=/home/xinyu/Software/idea-IU-243.24978.46/bin/idea %U -Dawt.toolkit.name=WLToolkit
```
在启动参数中增加`-Dawt.toolkit.name=WLToolkit` 就可以了。


### 设置macOS下的字体

安装macOS下的字体，我们使用`apple-fonts` 这个AUR包。

```bash
# yay -S apple-fonts
paru -S apple-fonts

```

然后就可以使用`nwg-look` 这个命令来进行设置。


