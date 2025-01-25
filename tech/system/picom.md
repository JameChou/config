## Picom 设置

### Installation

```bash
# git clone the project
git clone https://github.com/pijulius/picom.git


cd picom

# install the compile lib and tools
sudo pacman -S libev meson cmake uthash

meson setup --buildtype=release build
ninja -C build
```

### Config
[ArchLinux Wiki for Picom](https://wiki.archlinux.org/title/Picom#Disable_shadows_for_some_windows)

```bash
# copy the sample config file to ~/.config
cp ~/Software/picom/picom.sample.conf ~/.config/picom.conf

picom --config ~/.config/picom.conf
```

### Start Picom with Xorg
add `picom -b` to `.xinitrc`

### St Transparency
Please check the file `./st.md`.


### 使用体验

从使用体验上来讲，还是不错的，这个版本还提供了动画效果。

我在`dell xps 9550` 上面接两个4K显示器时，明显感觉到在`st` 这个terminal上使用时会有非常让人难受的延时应该是显卡的能力并没有跟上。


