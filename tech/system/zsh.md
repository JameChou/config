## 如何配置ZSH
[[toc]]

这个文件主要是用于说明我是如何配置`ZSH` 的。

### 有用的工具fzf

<b>[fzf](https://wiki.archlinux.org/title/Fzf)</b>是一个命令行下非常强大的模糊搜索工具。可以对**文件**、**命令历史** 进行搜索操作。

```bash
sudo pacman -S fzf
```

上面的命令可以安装`fzf` 工具。

那么其默认的配置文件是存放在`/usr/share/fzf` 目录下的，提供了`zsh` 和 `bash` 两种配置文件。

以我现在为例，我是使用`zsh` 的，那么在`.zshrc`文件中可以使用`source` 来加载这些配置。如`source /usr/share/fzf/key-bindings.zsh` 表示加载`fzf` 的默认`keybinding` 配置文件。

[zsh中我使用zsh-vi-mode，bindkey的问题](https://github.com/jeffreytse/zsh-vi-mode)，在`Execute Extra Commands`当中需要仔细阅读一下，如果我们使用`auto-completion`或`fzf`这些工具的时候，可能会面临的一些快捷键的冲突。**关于这块的解释和注意问题，跳转到下面的章节关于zsh-vim-mode**的部分。


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

参考VimMode的配置，因为现在也使用了`fzf` 去查找文件或者命令等信息。所以这里的配置就需要重新做一下，`Ctrl + T` 在`fzf` 中是表示对文件进行模糊搜索。

#### 语法高亮(zsh-syntax-highlighting)
```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
```


#### Vim模式(zsh-vi-mode)
```bash
git clone https://github.com/jeffreytse/zsh-vi-mode.git $ZSH_CUSTOM/plugins/zsh-vi-mode
```

我们在`plugin`中可以使用下面的配置去加载。

```bash
plugins=(zsh-vi-mode)
```

而zsh中也是存在`vim` 模式的。可以使用配置

```bash
plugins=(vi-mode)
```

只是这个插件比原生的`vi-mode` 更加的好用，更改了指针的样式以及更改了一些快捷键。那么其加载的方式是一些*lazy* 模式，那么就会导致我们下面的配置就可能失效了。


```bash
bindkey -r "^T"
bindkey "^T" autosuggest-accept
```

因为在我们`remove`或重新配置之后，`zsh-vi-mode` 也会重新再绑定。


不过其也提供了`lazy` 加载完成之后再执行的回调函数`zvm_after_init_commands`。


```bash
function init_keybindings() {
	source /usr/share/fzf/key-bindings.zsh
	source /usr/share/fzf/completion.zsh
	bindkey "^Y" autosuggest-accept
}

zvm_after_init_commands+=(init_keybindings)

```

| 快捷键     | 说明                                       |
|------------|--------------------------------------------|
| `Ctrl + T` | fzf模糊查找文件                            |
| `Ctrl + R` | fzf模糊查找之前已经执行过的命令            |
| `Ctrl + Y` | 自动补全主要是用于与neovim下的提示做到一致 |

通过上面的处理我们更改了新的快捷键。

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


