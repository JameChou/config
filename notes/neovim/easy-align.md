## Easy Align

   * [Easy Align](#easy-align)
      * [配置](#配置)
      * [Demo](#demo)

[Easy Align Github](https://github.com/junegunn/vim-easy-align) 

### 配置

这个插件是一个Vim的纯插件并不是为了NeoVim专用的，我们依然可以直接去添加这个插件，通过这个插件我基本掌握了如何去在NeoVim中管理和映射相关的插件。

```lua
return {
  'junegunn/vim-easy-align',
  config = function()
    vim.keymap.set('n', 'ga', '<Plug>(EasyAlign)', { desc = 'Easy Align' })
    vim.keymap.set('x', 'ga', '<Plug>(EasyAlign)', { desc = 'Easy Align' })
  end,
}
```

在`LazyVim` 中，我们只需要把Github的地址给出之后，如果是`NeoVim`  专用的插件一般是会提供相应的对象属性来对快捷键进行配置操作。而在Vim类的插件中可能是需要调用`map` 的方法才可以进行配置的。那么在观察上面的代码最重要的是我们要提供一个`config` 方法，使用这个方法在内部的时候才可以访问`vim.keymap` 即NeoVim的内置vim对象。

```lua
config = function()
  -- 这里可以访问vim的对象，调用对应的方法
  vim.keymap
end
```

```vim
" 对Visual模式下配置
xmap ga <Plug>(EasyAlign)
" 对Normal模式下配置
nmap ga <Plug>(EasyAlign)
```

### Demo
```
apple		    =red
grass+=green
sky-=	  blue
```

可以使用 `vipga=` 
* `v`isual-select `i`nner `p`aragraph
* Start EasyAlign command(`ga`)
* Align around `=`

或者也可以使用
* Start EasyAlign command(`ga`) for `i`nner `p`aragraph
* Align around `=`


当然这个插件还提供了一些类似正则表达式的一些特性，可以访问最上面的链接对这个插件进行详细的了解。

