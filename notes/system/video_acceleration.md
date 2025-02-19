## 关于视频硬解加速的笔记

<!--ts-->
   * [关于视频硬解加速的笔记](#关于视频硬解加速的笔记)
      * [安装nVidia闭源驱动](#安装nvidia闭源驱动)
      * [Hyprland设置](#hyprland设置)
      * [安装vaapi](#安装vaapi)
<!--te-->

[https://wiki.archlinuxcn.org/wiki/%E7%A1%AC%E4%BB%B6%E8%A7%86%E9%A2%91%E5%8A%A0%E9%80%9F](https://wiki.archlinuxcn.org/wiki/%E7%A1%AC%E4%BB%B6%E8%A7%86%E9%A2%91%E5%8A%A0%E9%80%9F)

这里讲解的还是蛮清楚的。

### 安装nVidia闭源驱动

[https://wiki.archlinuxcn.org/wiki/NVIDIA](https://wiki.archlinuxcn.org/wiki/NVIDIA)

其中也比较的明确的说明了，按表格中的硬件型号进行安装。可以使用下面的命令来查看硬件的相关信息：
```bash
$ lspci -k -d ::03xx
```

```
01:00.0 3D controller: NVIDIA Corporation GP107GLM [Quadro P2000 Mobile] (rev a1)
        Subsystem: Dell Device 087d
        Kernel driver in use: nvidia
        Kernel modules: nouveau, nvidia_drm, nvidia

```

这里的显卡代号是`GP107GLM`，然后可以安装最新的显卡驱动。

```bash
$ sudo pacman -S nvidia nvidia-utils nvidia-prime
```

上面的这个是安装`nvidia` 和 `nvidia-utils` 这两个驱动。以及`prime-run` 的工具，可以使用通过个工具来指定某个程序使用nvidia进行处理。详情可以查看下面的wiki:

经过这里的测试，现在的安装包已经做的比较智能了，好像已经把应该设置的参数都已经设置完成了。按照wiki中的所说，我们可以在`/etc/modprobe.d/nvidia.conf`中进行配置:

```conf
options nvidia_drm modeset=1 fbdev=1
```

在`/etc/mkinitcpio.conf` 这个文件中，增加module:
```conf
MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)
```

然后再使用命令重新配置系统的参数。
```bash
$ sudo mkinitcpio -P
```
这里配置完成之后，需要进行**重启**的操作。

安装完成之后需要对配置进行检测，首先是`modeset`，

```bash
$ sudo cat /sys/module/nvidia_drm/parameters/modeset
```

输出的结果应该是*Y*。

然后再查看`fbdev` 是否已经正确设置。
```bash
$ sudo cat /sys/module/nvidia_drm/parameters/fbdev
```

与*modeset* 是一样的，这里的输出结果应该是*Y*。

然后可以安装`cuda` 包，进行`cuda` 的开发。

```bash
$ sudo pacman -S cuda
```

安装完成之后可以使用下面的指令查看是否已经成功的安装上`cuda` 了。

```bash
$ nvcc --version
```

这里是输出结果。

```
nvcc: NVIDIA (R) Cuda compiler driver
Copyright (c) 2005-2025 NVIDIA Corporation
Built on Wed_Jan_15_19:20:09_PST_2025
Cuda compilation tools, release 12.8, V12.8.61
Build cuda_12.8.r12.8/compiler.35404655_0
```

### Hyprland设置

[https://wiki.hyprland.org/Nvidia/](https://wiki.hyprland.org/Nvidia/)
我们可以安装wiki中的说明对`~/.config/hypr/hyprland.conf` 中添加相应的环境变量。

在配置中增加:
```conf
env = LIBVA_DRIVER_NAME,nvidia
env = __GLX_VENDOR_LIBRARY_NAME,nvidia
```

### 安装vaapi
在安装这个之前先要安装`meson`
[https://wiki.archlinux.org/title/Hardware_video_acceleration](https://wiki.archlinux.org/title/Hardware_video_acceleration)

```bash
$ sudo pacman -S mesa
```

再安装`xf86-video-intel`

```bash
$ sudo pacman -S xf86-video-intel
```

```bash
$ sudo pacman -S libva-utils
```


