## 如何配置ZSH

这个文件主要是用于说明我是如何配置`ZSH` 的。

### 安装
```bash
# On ArchLinux how to install zsh
sudo pacman -S zsh
```

#### 更改用户默认的Shell
```bash
chsh -s $(which zsh)
```

**在ArchLinux dwm中，我使用了St这个Console工具，打开时就加载zsh在st 的`config.def.h` 中也可以更改shell的路径**
```c
// change the shell to zsh
static char *shell = "/usr/bin/zsh";
```

#### 使用Oh-my-zsh来美化和配置Zsh
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### 添加plugins
我们使用`oh-my-zhs` 来管理我们的插件

#### 提示(zsh-autosuggestions)
```bash
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
```

* 更改提示颜色
```config
# 配置颜色方案，具体可以查看autosuggestions下的README.md
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=12'
```

* 更改提示快捷键
```config
# 原先是按->键时自动补全，现在是按Ctrl + T进行补全
bindkey "^T" autosuggest-accept
```

#### 语法高亮(zsh-syntax-highlighting)
```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
```

#### Vim模式(zsh-vi-mode)
```bash
git clone https://github.com/jeffreytse/zsh-vi-mode.git $ZSH_CUSTOM/plugins/zsh-vi-mode
```

### 开启插件
```config
plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-vi-mode)
```

上面的这段配置表示我们开启了`git`，`zsh-autosuggestions` 等插件。






