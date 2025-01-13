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

#### history
在`plugins` 那行配置代码下我们可以直接添加history这个插件的启用。即
```
plugins=(... history ...)
```
这样的形式就可以把`history` 这个插件给添加上去了。

同样在`.zshrc` 中，再做一个简单的映射处理就可以了。
```
alias his=history
```

那么可以使用`his` 来显示出所有的历史数据，然后再加上管道的指令来进行查找的操作。在`zsh-vim-mode`下再使用`search` 来查找那个指令，这样的工作流还是不错的。

### 开启插件
```config
plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-vi-mode)
```

上面的这段配置表示我们开启了`git`，`zsh-autosuggestions` 等插件。






