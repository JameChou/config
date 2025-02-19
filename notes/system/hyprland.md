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

