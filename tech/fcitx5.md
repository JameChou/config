## Fcitx5 Configuration


### Installation
```bash
pacman -S fcitx5 fcitx5-chinese-addons fcitx5-configtool fcitx5-qt 
```

### Integriate with the dwm

1. dwm should be installed the patch autostart
2. config the autostart autorun script, like  `~/software/bin/dwm.script/autostart.sh`
3. add the shell to the auto run shell script like below


***integriate with dwm have some problems***

```bash
fcitx5 &
```

### start fcitx5 on startx
```bash
vim ~/.xinitrc
```

add start fcitx5 command on bottom of file
```
fcitx5 -d &
```


### set the input method
```
# dwm run program
modkey + p
# search fcitx5-config-tool then add wubi to the input method list
# use control+space to switch input method
```

