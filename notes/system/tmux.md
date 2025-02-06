## tmux

<!--ts-->
   * [tmux](#tmux)
      * [安装](#安装)
      * [配置](#配置)
         * [Prefix Key](#prefix-key)
         * [快捷键配置](#快捷键配置)
         * [Status Bar配置](#status-bar配置)
<!--te-->

> tmux is a program which runs in a terminal and allows multiple other terminal programs to be run inside it. Each program inside tmux gets its own terminal managed by tmux, which can be accessed from the single terminal where tmux is running - this called multiplexing and tmux is a terminal multiplexer.

[tmux github地址](https://github.com/tmux/tmux)

### 安装

在`ArchLinux` 中，可以使用`pacman` 来安装。
```bash
sudo pacman -S tmux
```

### 配置
配置文件放在`~/.config/tmux/tmux.conf` 中。


#### Prefix Key
```conf
# 使用Control + Space 进行指令模式
set-option -g prefix C-Space
```
按下这个快捷键之后，后再使用相应的指令就可以做出相应的指令，以防跟其他快捷键发生冲突。

[tmux中打开neovim背景颜色不正确的问题](https://stackoverflow.com/questions/41783367/tmux-tmux-true-color-is-not-working-properly/41786092#41786092)

#### 快捷键配置

**全局的一些基本配置** 
| Key Mapping | 说明                                                                           |
|-------------|---------------------------------------------------------------------------------|
| `n`         | 显示当前的`pane` 为第几个                                                      |
| `:`         | 进入命令模式                                                                   |
| `r`         | 重新加载tmux配置文件                                                           |
| `c`         | 进入`copy mode` 在这个模式下可以对文本进行copy这里面的命令是按照vim进行配置的 |
| `s`         | 选择一个`session`                                                              |


**面板(pane)或window的配置**
| Key Mapping        | 说明                           |
|--------------------|--------------------------------|
| `v`                | 垂直分割一个terminal           |
| `x`                | 水平分割一个terminal           |
| `h`、`j`、`k`、`l` | 类似于vim的快捷键进行移动      |
| `C-hjkl`           | 如果有多个pane进行方向上的移动 |
| `yuio`             | 对一个面板的大小进行调整       |
| `enter`            | 创建一个新的window             |
| `C-Number`         | 切换到某个windows              |

#### Status Bar配置

```conf
set -g status-right-style 'fg=white bg=#000000'
set -g status-right "[#(cat ~/.cache/wttr)][ #(cat ~/.cache/checkupdates-cron.num)][ #(cat ~/.cache/uptime)][ #(free | grep Mem | awk '{printf \"%.0f%%\", $3/$2 * 100}')][󱩎 #(brightnessctl | awk -F'[()]' 'NR==2 {print $2}')][  #(pactl get-sink-volume 0 | awk -F' ' '{printf $5}')][ #(cat /sys/class/power_supply/BAT?/capacity)%][%b-%d %a %H:%M][#S]"
set-option -g status-position bottom
set -g status-right-length 160
set -g status-left ''
setw -g window-status-separator ''
setw -g window-status-current-style 'fg=#eeeeee bg=#9962b7'
set -g window-status-format "#[bg=#000000] #I "
set -g window-status-current-format " #I "
setw -g window-status-style 'fg=white bg=#000000'
setw -g window-status-bell-style 'fg=yellow bg=red bold'
set -g status-style bg=#000000
```


