## 影音娱乐以及录屏

<!--ts-->
   * [影音娱乐以及录屏](#影音娱乐以及录屏)
      * [mpv](#mpv)
      * [OBS](#obs)
      * [Music](#music)
<!--te-->

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

### Music

[ArchLinux Studio娱乐影音的指导文章](https://archlinuxstudio.github.io/ArchLinuxTutorial/#/play&office/media)

[FeelUOwn](https://github.com/feeluown/FeelUOwn) 这款音乐播放器是`python` 编写的，与其他的一些软件播放器比较来看(electron)编写的，效率上要好一点，另外对于输入法一类的都还是不错的。

```bash
# 安装FeelUOwn 音乐播放器
yay -S feeluown

# 安装网易云音乐插件
yay -S feeluown-netease
```
