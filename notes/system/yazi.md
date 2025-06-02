# Yazi相关配置

之前一直是使用的<u>ranger</u>工具，后来发现<u>ranger</u>这个工具有着蛮多的问题，比如在预览的时候感觉有点一些卡，当目录中的文件较多的时候会出现卡死的情况。所以就换成了<u>Yazi</u>。

## 安装

```shell
$ sudo pacman -S yazi ffmpeg 7zip jq poppler fd ripgrep fzf zoxide imagemagick
```

## 插件管理
我们可以使用
```shell
ya pkg <CR>
```
来查看有哪些命令对包(plugins)进行管理。

如常用的有:
1. 安装插件
```shell
ya pkg install <package_name>
```

2. 查看现在已经安装的插件
```shell
ya pkg list
```

3. 更新插件
```shell
ya pkg upgrade
```


### 使用的插件列表

* [相对行号插件](https://github.com/dedukun/relative-motions.yazi)

