## Xorg相关配置 

<!--ts-->
   * [Xorg相关配置](#xorg相关配置)
      * [如何控制某个显示器输出分辨率或刷新率](#如何控制某个显示器输出分辨率或刷新率)
      * [设置字体的绽放](#设置字体的绽放)
      * [外接屏幕的相关配置](#外接屏幕的相关配置)
      * [高分辨率下的显示](#高分辨率下的显示)
      * [DWM多屏的配置](#dwm多屏的配置)
<!--te-->


 这个笔记是关于Xorg的一些相关配置，尤其是关于显示分辨率一些处理，如何进行绽放的处理。还有一些外接显示器的相关内容。 

[可参考的blog配置](https://www.cnblogs.com/xieco/p/17857753.html) 
[ArchLinux Wiki about 多显示器](https://wiki.archlinuxcn.org/wiki/%E5%A4%9A%E6%98%BE%E7%A4%BA%E5%99%A8)

### 如何控制某个显示器输出分辨率或刷新率

```bash
# 使用下面这个命令去查找现在的显示信息，比如我现在这个电脑显示器
xrandr
```

这是命令输出的结果，输出了我现在这个电脑的一些信息
```
Screen 0: minimum 320 x 200, current 1920 x 1080, maximum 16384 x 16384
eDP-1 connected primary 1920x1080+0+0 (normal left inverted right x axis y axis) 344mm x 194mm
   1920x1080     60.00*+  59.97    59.96    59.93    40.00  
   1680x1050     59.95    59.88  
   1400x1050     59.98  
   1600x900      59.99    59.94    59.95    59.82  
   1280x1024     60.02  
   1400x900      59.96    59.88  
   1280x960      60.00  
   1440x810      60.00    59.97  
   1368x768      59.88    59.85  
   1280x800      59.99    59.97    59.81    59.91  
   1280x720      60.00    59.99    59.86    59.74  
   1024x768      60.04    60.00  
   960x720       60.00  
   928x696       60.05  
   896x672       60.01  
   1024x576      59.95    59.96    59.90    59.82  
   960x600       59.93    60.00  
   960x540       59.96    59.99    59.63    59.82  
   800x600       60.00    60.32    56.25  
   840x525       60.01    59.88  
   864x486       59.92    59.57  
   700x525       59.98  
   800x450       59.95    59.82  
   640x512       60.02  
   700x450       59.96    59.88  
   640x480       60.00    59.94  
   720x405       59.51    58.99  
   684x384       59.88    59.85  
   640x400       59.88    59.98  
   640x360       59.86    59.83    59.84    59.32  
   512x384       60.00  
   512x288       60.00    59.92  
   480x270       59.63    59.82  
   400x300       60.32    56.34  
   432x243       59.92    59.57  
   320x240       60.05  
   360x202       59.51    59.13  
   320x180       59.84    59.32  
VGA-1 disconnected (normal left inverted right x axis y axis)
HDMI-1 disconnected (normal left inverted right x axis y axis)
```

```bash
xrandr | grep 1920
```


这是下图输出的信息
```
Screen 0: minimum 320 x 200, current 1920 x 1080, maximum 16384 x 16384
eDP-1 connected primary 1920x1080+0+0 (normal left inverted right x axis y axis) 344mm x 194mm
   1920x1080     60.00*+  59.97    59.96    59.93    40.00  
```

我的笔记本的内置屏幕是使用`eDP` 接口现在正在输出的分辨率是`1920x1080`，当前的刷新率是`60hz`。

在`~` 目录下，我们可以使用`randr` 命令再对基础的屏幕或者外接的屏幕来进行输出显示。
```bash
xrandr --output eDP-1 --mode 1920x1080 --primary

# 下面这个命令显示了如何关闭某个显示器
xrandr --output HDMI-1 --off
```

### 设置字体的绽放
需要在用户目录`~` 下新建一个文件`.Xresource` 然后把下面的内容加入进去。
```bash
Xft.dpi:110
```

在`.xinitrc` 里加入下面的内容，表示启用绽放的数据。
```bash
xrdb -merge ~/.Xresources
```

### 外接屏幕的相关配置

[ArchLinux wiki about xrandr](https://wiki.archlinuxcn.org/wiki/Xrandr)

像上面提到一些配置上，我们使用`xrandr` 命令把显示相关的接口都显示出来之后，再进入相应的输出配置。

```bash
xrandr --output HDMI-1 --auto --left-of eDP-1

```

上面的命令就是将`HDMI`的显示接口放在`eDP-1` 的左侧，并且增加了`--auto` 参数自动化设置分辨率和刷新率等信息。

那么屏幕可以放在哪几个位置无非就是**上、左、下、右** ，对应的参数是`--left-of`，`--right-of`、`--above`、`--below`。

特殊的一些配置是如果是想使用**镜像** 模式的时候需要添加参数`--same-as`。

### 高分辨率下的显示
我现在这个电脑是4K显示分辨率，如果想要显示效果比较好，那么就需要进行缩放即`scaling`。

```bash
xrandr --output eDP-1 --auto --scale 1.1x1.1 
```

TODO: 这里还是需要再完善一下，再去探究一下为什么会这样。
经过实验这种形式在`dmenu` 上面汉字在显示的时候特别的小，真的非常不舒服。如果采用`xrdp` 不知道这种情况会不会有所改善。

### DWM多屏的配置
[DWM suckless.org](https://dwm.suckless.org/multi-monitor/) 
```c
 // begin to setup the key about multiple monitor 
 // [Mod + <] to focus the previous monitor
 {MODKEY, XK_comma, focusmon, {.i = -1}},
 // [Mod + >] to focus the next monitor
 {MODKEY, XK_period, focusmon, {.i = +1}},
 // [Mod + Shift + <] move the window to the previous monitor
 {MODKEY | ShiftMask, XK_comma, tagmon, {.i = -1}},
 // [Mod + Shift + >] move the window to the next monitor
 {MODKEY | ShiftMask, XK_period, tagmon, {.i = +1}},
 // end setup the key about multiple monitor
```

上面的这块配置已经进行解释了，可以参考下面的表格。

| 快捷键      | 解释                                                                     |
|-------------|--------------------------------------------------------------------------|
| Mod+<       | 向前一个显示器移动，相当于鼠标在前一个窗口上点击了一下，焦点移动到后一个 |
| Mod+>       | 向后一个显示器移动，相当于鼠标在后一个窗口上点击了一个，焦点移动到后一个 |
| Mod+Shift+< | 将某一个窗口移动到上一个显示器内                                         |
| Mod+Shift+> | 将某一个窗口移动到下一个显示器内                                         |

然后这里需要结合上面的`xrandr`命令对多窗口进行管理。







