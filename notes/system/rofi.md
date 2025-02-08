## Rofi相关笔记

[https://github.com/lbonn/rofi/](https://github.com/lbonn/rofi/)

Rofi本身是在`xorg` 下的一个启动器，我在`sway` 上面已经使用了`wmenu` 为什么还要再使用`rofi` 呢，主要是为了跟`wmenu` 进行配合的使用，因为如下面的表列出来的，`rofi` 可以支持`drun` 也就是支持`*.desktop`的启动方式。当然`dmenu` 也是支持的，不过再进行配置，我还是感觉烦。使用这个进行分割开来。

```
Detected modes:
        • +window
        • +run
        • +ssh
        • +drun
        • combi
        • keys
        • filebrowser
        • recursivebrowser

```


### 如何安装

* 从`github` 上面clone下来之后再进行安装。不过这种方式不太推荐，因为无法跟着包管理一起更新。

* 使用`pacman` 进行管理。

这里需要注意一下，如开头所讲的，`rofi` 本身是一个`x11`下的应用，在wayland环境上我们尽量使用支持`wayland` 原生的应用。

[https://github.com/lbonn/rofi/](https://github.com/lbonn/rofi/) 这个库里是从原先的库中folk而来的。经过代码的修改支持了wayland环境。

```bash
sudo pacman -S rofi-wayland
```


### Sway配置启动键

在`~/.config/sway/config` 中添加快捷键`$mod+d` 打开rofi。

```conf
bindsym $mod+d exec rofi -show drun
```

rofi则会找到`/usr/share/applications/` 以及 `~/.local/share/applications/` 下的`*.desktop` 文件。如果`~/.local` 下的与`/usr/share` 下的有相同的文件，则会以`~/.local` 下的为准。


这样就比较好的支持了应用从`desktop` 文件启动，我们则可以在文件中配置启动环境变量等信息。


