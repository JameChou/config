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


