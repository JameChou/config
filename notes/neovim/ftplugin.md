## ftplugin

在这个目录下面，`neovim` 会自动加载对应的语言类型的一些特性，比如可以设置缩进的行数等一些内容。

如可以针对`c/cpp`的语言设置缩进或`tab` 键是缩进`4` 个空格，则可以使用下面的配置。

```vim
setlocal shiftwidth=4 softtabstop=4 expandtab smarttab
```
