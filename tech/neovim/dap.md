## DAP调试

   * [DAP调试](#dap调试)
      * [Lua配置](#lua配置)
      * [C++调试](#c调试)

NeoVim安装Dap插件
这是插件列表
[nvim-dap](https://github.com/mfussenegger/nvim-dap)
[nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)
[nvim-dap-virtual-text](https://github.com/theHamsta/nvim-dap-virtual-text)

可以使用`:vertical help dap.txt`命令去查看`dap.txt` 帮助文件，里面写的还是比较详细的

### Lua配置

```
.
├── dap.lua
dap
├── lanuage
│   └── nvim-dap-cc.lua
├── nvim-dap-keymap.lua
├── nvim-dap-sign.lua
├── nvim-dap-ui.lua
└── nvim-dap-virtual-text.lua
```

目录的配置结构是这样的，`dap.lua` 是关于`dap` 的主要配置文件。而`dap`文件夹里面放置了一些具体的模块化配置。

* `nvim-dap-keymap.lua` 快捷键配置
* `nvim-dap-ui.lua` dap-ui的配置文件
* `nvim-dap-virtual-text.lua` 内部文件的配置
* `nvim-dap-sign.lua` dap 调试时的标识


**具体配置可以访问其项目的github主页** 


### C++调试

```bash
sudo pacman -S gdb
```
首先需要安装`gdb` 调试系统，程序如果想要调试的话还需要编译时生成`gdb` 的信息。


```bash
gcc -ggdb test.c -o test
```

```lua
vim.keymap.set('n', '<F5>', function()
  require('dap').continue()
end)

vim.keymap.set('n', '<F6>', function()
  require('dap').step_over()
end)
```

当按下`<F5>` 时则可以指定需要对哪个文件进行debug

