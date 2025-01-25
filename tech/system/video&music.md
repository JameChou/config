## 影音娱乐以及录屏


在ArchLinux下，如果我想去播放视频以及音乐的话，可以安装下面几个软件。

### mpv

这是一款可以播放Video的软件。使用下面的命令去安装。

```bash
sudo pacman -S mpv
```

### OBS

这是一款可以录屏和直播的软件

```bash
sudo pacman -S obs-studio
```

### 音乐

[ArchLinux Studio娱乐影音的指导文章](https://archlinuxstudio.github.io/ArchLinuxTutorial/#/play&office/media)

```bash
yay -S yesplaymusic
```

<!--下面这个解释需要尽快解决-->
那么这个软件有一个问题就是，当我使用`dwm` 时，使用`Mod+Shift+c`这个去杀死进程的时候并不起作用，还是比较烦的。
