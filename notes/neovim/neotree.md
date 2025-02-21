## NeoTree

<!--ts-->
   * [NeoTree](#neotree)
      * [Shortcuts|Mappings](#shortcutsmappings)
<!--te-->

这个笔记主要是介绍一个`NeoTree` 在`NeoVim` 中是如何使用的以及一些我们主要使用的快捷键。

这里的系统的官方文档。
[github文档](https://github.com/nvim-neo-tree/neo-tree.nvim)

### Shortcuts|Mappings
| 快捷键             | 功能                                                                                       |
|--------------------|--------------------------------------------------------------------------------------------|
| `<space>`          | 关闭或打开一个目录                                                                         |
| `<cr>`             | `回车` 打开一个目录或打开                                                                  |
| `<esc>` \| `<c-[>` | 关闭`NeoTree`                                                                              |
| `P`                | 预览数据                                                                                   |
| `l`                | 如果已经打开预览窗口之后向右移动将焦点移至预览的窗口中                                     |
| `S`                | 横向的分栏打开一个`tab`                                                                    |
| `s`                | 左右(纵向)的打开一个分栏在同`tab` 下面                                                     |
| `t`                | 打开一个新的`tab`页                                                                        |
| `C`                | 大写的`C`关闭现在光标所在的这个位置所在目录(折叠)                                          |
| `z`                | 关闭所有的节点                                                                             |
| `a`                | 添加一个节点，如果是普通的文件就按照正常的形式进行添加，如果是目录则要以\\来作为我们的结尾 |
| `A`                | 添加一个目录                                                                               |
| `d`                | 删除一个节点                                                                               |
| `r`                | 重命名一个节点                                                                             |
| `b`                | 重命名一个节点，与`r` 不同的时，只更改文件的基础名称，不可以修改这个文件的扩展类型         |
| `y`                | 复制一个节点                                                                               |
| `x`                | 剪切一个节点                                                                               |
| `p`                | 粘贴一个节点                                                                               |
| `c`                | 拷贝一个节点                                                                               |
| `m`                | 移动一个节点                                                                               |
| `q`                | 关闭当前窗口，这个要比`\\\\` 好用，现在我们这个是打开`neo-tree`，这个速度更快也更方便      |
| `R`                | 刷新                                                                                       |
| `<`                | 上一个资源目录                                                                             |
| `>`                | 下一个资源目录                                                                             |
| `i`                | 显示这个文件的详细信息，这个节点的创建时间等信息                                           |
| `<bs>`             | 即`backspace` 键，回退到当前根目录的上一层目录节点                                         |
| `.`                | 进入这个目录并且把这个目录作为一个新的`root`节点                                           |
| `H`                | 默认的情况下不会显示隐藏的目录以及文件，使用这个指令之后就把隐藏的目录及文件都显示出来     |
| `/`                | 进行搜索操作                                                                               |
| `D`                | 对目录类型的文件进行模糊搜索                                                               |

上面这一些快捷键就是我常用的一些快捷键，是需要多加练习之后才可以使用的。



