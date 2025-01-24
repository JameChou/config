## NeoVim 配置学习
![TOC]

### lua-vim-variables

NeoVim中的Variables可以使用lua来进行配置访问。

The Vim editor global dictionaries `g:` `w:` `b:` `t:` `v:` can be accessed
from Lua conveniently and idiomatically by referencing the `vim.*` Lua tables
described below. In this way you can easily read and modify global Vimscript
variables from Lua.

Examples:
```lua
    vim.g.foo = 5     -- Set the g:foo Vimscript variable.
    print(vim.g.foo)  -- Get and print the g:foo Vimscript variable.
    vim.g.foo = nil   -- Delete (:unlet) the Vimscript variable.
    vim.b[2].foo = 6  -- Set b:foo for buffer 2
```

#### vim.g
Global (`g:`) editor variables.
Key with no value returns `nil`.

访问vim的全局变量

#### vim.b
Buffer-scoped (`b:`) variables for the current buffer.
Invalid or unset key returns `nil`. Can be indexed with
an integer to access variables for a specific buffer.

访问缓冲区的Variables

#### vim.w
Window-scoped (`w:1) variables for the current window.
Invalid or unset key returns `nil`. Can be indexed with
an integer to access variables for a specific window.

访问窗口区域的Variables

#### vim.t
Tabpage-scoped (`t:`) variables for the current tabpage.
Invalid or unset key returns `nil`. Can be indexed with
an integer to access variables for a specific tabpage.

访问Tab标签页的Variables。

#### vim.v
`v:` variables.
Invalid or unset key returns `nil`.

访问普通的Variables。


### 映射mapleader
在Vim当中Space一般是用不到的，比如在`Normal`模式下`Space`表示向前移动一个位置。我以前是使用`,`来当作`leader`

```lua
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
```
这两个都在`global`区域。

### 使用Nerfont

Nerfont主要是用于显示一些图标一类的font。

```lua
vim.g.have_nerd_font = true
```


### NeoVim普通配置
`:help option-list` 可以访问option-list可选的配置选项。

也可以查看NeoVim的[option-list](https://neovim.io/doc/user/quickref.html#option-list)

```lua
-- 显示行号
vim.opt.number = true
-- 显示相对行号
vim.opt.relativenumber = true
-- 开启可以使用左击来resize窗口大小
vim.opt.mount = 'a'
-- 不显示当前所处的状态，因为已经在状态栏中显示了
vim.opt.showmode = false

-- 同步系统的clipboard在系统和Vim之间 
-- :help clipboard
vim.schedule(function()
    vim.opt.clipboard = 'unnamedplus'
end)

-- 当一行的内容很多时，分行进行显示
vim.opt.breakindent = true

-- 搜索大小写的配置
vim.opt.ignorecase = true -- 当这个为false时，如果使用 /car 那么文档中Car是搜索不到的，这个开启则可以忽略大小写
vim.opt.smartcase = true -- 同样的，如果我们使用驼峰的方式进行搜索那么这时候就会精准搜索不再忽略大小写了

-- 是否开启显示标号列，有以下几个值 auto仅当有标号要显示时才会显示
-- 'no'永远不显示
-- 'yes' 一直显示
-- 'number' 在'number'列上标号，如果没有number列，相当于'auto'
vim.opt.signcolumn = 'yes'


-- 缩短写入磁盘时间，default为4000，单位为mills。
-- 如果过了上面配置的时间，没有任何输入时，这个时候vim会把文档写入到磁盘中，以防数据丢失
vim.opt.updatetime = 250

-- default为1000 等待组合按键的时间，比如我们映射了<Esc>那么当按下时，可能会有延时，因为需要等待后续的按键组合进行处理。
vim.opt.timeoutlen = 300

-- 配置新的分成窗口
-- 竖向的分窗时是在右侧split
vim.opt.splitright = true
-- 横向分窗时在下方split
vim.opt.splitbelow = true


-- 设置字符串中的一些特殊字符的显示方式
-- see: `:help 'list'`
-- see: `:help 'listchars`'
-- see: https://yianwillis.github.io/vimcdoc/doc/options.html#'list'
vim.opt.list = true
vim.opt.listchars = { tab = '>> ', trail = '.', nbsp = '␣' }

-- TODO: 还需要查看文档进行说明
vim.opt.inccommand = 'split'

-- 显示你cursor所在哪一行
vim.option.cursorline = true

-- 向下游览时最下方有多少行显示出来方便总体一直在最中间的位置
vim.opt.scrolloff = 10
```

### 基础的快捷键绑定
首先说明lua配置中，`vm.keymap`是对keymap这个键进行定义和配置。`set()`是function进行调用。

共有三个参数，第一个表示模式，第二是需要设置的键位，第三个是处理的动作。
```lua
-- 在Normal模式下，当按下Esc或者<C-[>时，将查询高亮的清除掉。
vim.keymap.set('n', '<Esc>', '<cmd>nohisearch<CR>')


-- 语法以及warning检查<leader>q
vim.keymap.set('n', '<leader>q', vim.diagnostic.setlocallist, { desc = 'Open diagnostic [Q]uickfix list' })

-- 退出内置的Terminal绑定为连续按两次Esc
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })


-- 多窗口时互相的相互切换。
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })


```

### Autocommands
在Vim中我们可以使用Autocommands命令来做某些事情(类似于进入Buffer区时，会做我们定义的方法 )这里有一些像我们使用Javascript时来监听Triger或者Event，像这样：
```javascript
document.getElementById("#buttonId").onClick(function() {
    console.log("Click the button");
});
```
关于Autocommands的相关内容可以阅读[文档](https://neovim.io/doc/user/usr_40.html#_autocommands)

在下面的一个章节中我们可以看到如何高亮复制过的一段内容，那么其中的Group在文档中已经比较详细的说明了: 分组是为了方便我们进行管理。我们可以定义了很多Trigger，想要统一的删除则可以使用命令将这些Autocommands全部一起删除等操作。

关于lua如何注册Autocommands的配置代码，可以阅读以下[文档](https://neovim.io/doc/user/lua-guide.html#_autocommands)


关于Lua Autocommands可以监听的Event [列表](https://neovim.io/doc/user/autocmd.html#_5.-events)


### 高亮Yank段

```text
TextYankPost	Just after a yank or deleting command, but not
				if the black hole register quote_ is used nor
				for setreg(). Pattern must be "*".
				Sets these v:event keys:
				    inclusive
				    operator
				    regcontents
				    regname
				    regtype
				    visual
				The inclusive flag combined with the '[
				and '] marks can be used to calculate the
				precise region of the operation.
				Non-recursive (event cannot trigger itself).
				Cannot change the text. textlock
```

```lua
-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
```

### LazyVim
[LazyVim](https://github.com/folke/lazy.nvim.git)是一个开源的，开箱即用的NeoVim distribution。我们可以使用这个来管理相关的插件。

```lua
-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)
```

检查LazyVim安装有哪些插件以及安装后的插件状态。使用:
`:Lazy` 而更新插件使用 `:Lazy update`

#### 安装管理插件
```lua
require('lazy').setup({})
```

#### tpoe/vim-sleuth
[相关说明文档](https://github.com/tpope/vim-sleuth)
这个插件是一个可以自动识别我们文档中一个tab键所占用的空间，默认情况vim一个tab键是8个空格，而正常情况下，C语言是4个空格或者在javascript中我们也会使用2个空格来作为一个tab键。


#### lewis6991/gitsigns
[相关说明文档](https://github.com/lewis6991/gitsigns.nvim)

这个插件主要是用于在文档把git中修改的内容标记出来
```lua
  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`. This is equivalent to the following Lua:
  --    require('gitsigns').setup({ ... })
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

```

#### folke/which-key.nvim
[相关文档](https://github.com/folke/which-key.nvim)这个插件主要是用于在nvim中显示我们绑定的一些key，然后在使用的时候会把这些key显示出来。


**一般情况下，我个人感觉像DD这些应该不需要显示出来**,如果需要更改这个选项我们可以在`option`中的`delay`把延时给更改一下，现在`delay = 0`，也就是说如果我们在visual 或 normal模式下就会显示出来，比较的烦。我们将延时到500这个数值，我个人感觉是比较好的。
```lua
{
    -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      -- delay between pressing a key and opening which-key (milliseconds)
      -- this setting is independent of vim.opt.timeoutlen
        -- timeoutlen
      delay = 0,
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
}
```

#### Telescope
这个插件是用于Fuzzy(模糊查询)用的。

快捷键:

```lua
local builtin = require 'telescope.builtin'

-- 打开help tag以及文档一类
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
--  打开关于key-map 查找
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
--  模糊搜索文件全局
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
-- 打开telescope内置
vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
-- 模糊搜索单词
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
-- TODO: 这个暂时还不知道是什么，需要查找文档
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
-- 查找语法检查相关
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
--  
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
-- 查找最近打开的文件
vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
-- 查找buffer
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

-- 示例更改样式
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to Telescope to change the theme, layout, etc.
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

-- It's also possible to pass additional configuration options.
--  See `:help telescope.builtin.live_grep()` for information about particular keys
vim.keymap.set('n', '<leader>s/', function()
  builtin.live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end, { desc = '[S]earch [/] in Open Files' })

-- 查找当前neovim的配置文件
-- Shortcut for searching your Neovim configuration files
vim.keymap.set('n', '<leader>sn', function()
  builtin.find_files { cwd = vim.fn.stdpath 'config' }
end, { desc = '[S]earch [N]eovim files' })

```

#### LSP Plugin 重要
这个插件主要是用于语法的提示一些工作

下面列出了，LSP这个插件依赖的其他插件
```lua
{
  -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by nvim-cmp
      'hrsh7th/cmp-nvim-lsp',
    },
}
```

keymap映射列表
```lua
-- 跳转到光标所在这个variable或function等一类的定义处
-- 如果想到跳转回来使用<C-t>
map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

-- 在telescope中查找这个光标所在的variable等信息所有相关的位置
-- 同样的如果想要跳转回来使用<C-t>
map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

-- 跳转到光标所在位置的这个所有子类，implementation,当这个语言必须支持
map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

-- 跳转到光标所在位置的这个定义类型。
map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

-- Fuzzy 查找**当前**文件中所有方法或全局变量以及类型等等。当然有一些就无法找到
map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

-- Fuzzy 查找目前**workspace**即工作环境中所有的方法或者全局变量等信息
map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

-- 重命名光标当前所在的Variable
map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

-- 转换变量，互换一类的 目前试下来
map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

-- 跳转到**声明**处跟 gd这个命令相比，gd是跳转到定义处
map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

```

下这个段代码是关于如何把我们光标所在位置的Variable在整个document中高亮显示的。
```lua
-- The following two autocommands are used to highlight references of the
-- word under your cursor when your cursor rests there for a little while.
--    See `:help CursorHold` for information about when this is executed
--
-- When you move your cursor, the highlights will be cleared (the second autocommand).
local client = vim.lsp.get_client_by_id(event.data.client_id)
if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
  local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
  vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
    buffer = event.buf,
    group = highlight_augroup,
    callback = vim.lsp.buf.document_highlight,
  })

  vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
    buffer = event.buf,
    group = highlight_augroup,
    callback = vim.lsp.buf.clear_references,
  })

  vim.api.nvim_create_autocmd('LspDetach', {
    group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
    callback = function(event2)
      vim.lsp.buf.clear_references()
      vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
    end,
  })
end
```


下面这段代码用于在传参等这些方法中显示变量类型啊等作用，一般用于C java当中，这个功能类似说jetbrians中的一些，可以看到传参的要求，定义类型。

使用`<leader>th`来打开或者关闭。
```lua
-- The following code creates a keymap to toggle inlay hints in your
-- code, if the language server you are using supports them
--
-- This may be unwanted, since they displace some of your code
if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
  map('<leader>th', function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
  end, '[T]oggle Inlay [H]ints')
end
```


可以将diagnostic的样式改成有nerdfont来显示。
```lua
if vim.g.have_nerd_font then
  local signs = { ERROR = '', WARN = '', INFO = '', HINT = '' }
  local diagnostic_signs = {}
  for type, icon in pairs(signs) do
    diagnostic_signs[vim.diagnostic.severity[type]] = icon
  end
  vim.diagnostic.config { signs = { text = diagnostic_signs } }
end
```

#### Autoformat
自动格式化代码文件

#### Autocompetion
自动化提示


提示键
```lua
-- 向下选择一个 
['<C-n>'] = cmp.mapping.select_next_item(),
  -- 向上选择一个
['<C-p>'] = cmp.mapping.select_prev_item(),

-- <C-b>以及<C-f>跟Vim的快捷键一样向上和向后翻页
['<C-b>'] = cmp.mapping.scroll_docs(-4),
['<C-f>'] = cmp.mapping.scroll_docs(4),


-- 确认选择自动化将整个数据引入进来，进行测试之后发现还是蛮好用的，当只有一个的时候可以使用这个快捷键，若是方法需要传参也可以直接加入进来
-- Accept ([y]es) the completion.
--  This will auto-import if your LSP supports it.
--  This will expand snippets if the LSP sent a snippet.
['<C-y>'] = cmp.mapping.confirm { select = true },

-- If you prefer more traditional completion keymaps,
-- you can uncomment the following lines
--['<CR>'] = cmp.mapping.confirm { select = true },
--['<Tab>'] = cmp.mapping.select_next_item(),
--['<S-Tab>'] = cmp.mapping.select_prev_item(),

-- Manually trigger a completion from nvim-cmp.
--  Generally you don't need this, because nvim-cmp will display
--  completions whenever it has completion options available.
-- TODO: 这里的快捷键与dwm冲突了，还需要再修改一下
['<C-Space>'] = cmp.mapping.complete {},

-- Think of <c-l> as moving to the right of your snippet expansion.
--  So if you have a snippet that's like:
--  function $name($args)
--    $body
--  end
--

-- 如果这里是使用LSP自动引入进来的，可以使用下面这个两个快捷键一个个快速修改
-- <c-l> will move you to the right of each of the expansion locations.
-- <c-h> is similar, except moving you backwards.
['<C-l>'] = cmp.mapping(function()
  if luasnip.expand_or_locally_jumpable() then
    luasnip.expand_or_jump()
  end
end, { 'i', 's' }),
['<C-h>'] = cmp.mapping(function()
  if luasnip.locally_jumpable(-1) then
    luasnip.jump(-1)
  end
end, { 'i', 's' }),

-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
```



#### 主题
```lua
{
  -- You can easily change to a different colorscheme.
  -- Change the name of the colorscheme plugin below, and then
  -- change the command in the config to whatever the name of that colorscheme is.
  --
  -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  'folke/tokyonight.nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  init = function()
    -- Load the colorscheme here.
    -- Like many other themes, this one has different styles, and you could load
    -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
    vim.cmd.colorscheme 'tokyonight-night'

    -- You can configure highlights by doing something like:
    vim.cmd.hi 'Comment gui=none'
  end,
}
```

可以使用命令`:Telescope colorscheme`来查看现在NeoVim中已经安装的所有代码风格主题

#### 高亮TODO
```lua
-- Highlight todo, notes, etc in comments
{ 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

```

#### echasnovski/mini.nvim
这是一个可以快速更改括号等一类的插件，功能还是强大的
```lua
-- Examples:
--  - va)  - [V]isually select [A]round [)]paren
--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
--  - ci'  - [C]hange [I]nside [']quote
require('mini.ai').setup { n_lines = 500 }

-- Add/delete/replace surroundings (brackets, quotes, etc.)
--
-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
-- - sd'   - [S]urround [D]elete [']quotes
-- - sr)'  - [S]urround [R]eplace [)] [']
require('mini.surround').setup()

-- Simple and easy statusline.
--  You could remove this setup call if you don't like it,
--  and try some other statusline plugin
local statusline = require 'mini.statusline'
```
具体可以访问这个库的[官方地址](https://github.com/echasnovski/mini.nvim)

#### Treesitter
一个官方NeoVim的代码高亮优化显示的plugin

#### Neo-tree
[github文档](https://github.com/nvim-neo-tree/neo-tree.nvim)
==需要对官方的快捷键学习，还是不太熟练==


```lua
return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
}
```

#### windwp/nvim-autopairs 
[官方文档](https://github.com/windwp/nvim-autopairs)
这个插件是neovim自动化补全如`[]`, `{}`, `''`, `""`等。

```lua
return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  -- Optional dependency
  dependencies = { 'hrsh7th/nvim-cmp' },
  config = function()
    require('nvim-autopairs').setup {}
    -- If you want to automatically add `(` after selecting a function or method
    local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
    local cmp = require 'cmp'
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
  end,
}
```

#### 与系统的剪切板相互访问

[Ask Ubuntu下有关于这个问题](https://askubuntu.com/questions/1486871/how-can-i-copy-and-paste-outside-of-neovim)

需要安装`xclip` 或 `xcopy`

```bash
sudo pacman -S xclip
```


在`init.lua` 配置文件中增加这个特性的支持
```lua
vim.schedule(function()
    vim.opt.clipboard = 'unnamedplus'
end)
```

#### 如何安装comment插件

我们这里还是使用`Lazy` 去管理我们的插件
[numToStr-Comment](https://github.com/numToStr/Comment.nvim) 可以访问这个去看相关的代码

```lua
return {
  'numToStr/Comment.nvim',
  opts = {
    padding = true,
    sticky = true,
    ignore = nil,
    toggler = {
      line = 'gcc',
      block = 'gbc',
    },
    -- 注释代码块
    opleader = {
      line = 'gc',
      block = 'gb',
    },

    extra = {
      above = 'gc0',
      below = 'gco',
      eol = 'gcA',
    },

    mappings = {
      basic = true,
      extra = true,
    }
  },
}
```

#### NeoVim-Dap调试代码
**NeoVim-dap插件是用于debug调试用的**


#### Winbar
**Winbar插件是在文件的头部显示整个函数等信息用的**

[winbar neovim的插件地址](https://github.com/Bekaboo/dropbar.nvim)

```lua
return {
  'Bekaboo/dropbar.nvim',
  config = function()
    local api = require 'dropbar.api'
    vim.keymap.set('n', '<Leader>;', api.pick)
    vim.keymap.set('n', '[c', api.goto_context_start)
    vim.keymap.set('n', ']c', api.select_next_context)

    local confirm = function()
      local menu = api.get_current_dropbar_menu()
      if not menu then
        return
      end
      local cursor = vim.api.nvim_win_get_cursor(menu.win)
      local component = menu.entries[cursor[1]]:first_clickable(cursor[2])
      if component then
        menu:click_on(component)
      end
    end

    local quit_curr = function()
      local menu = api.get_current_dropbar_menu()
      if menu then
        menu:close()
      end
    end

    require('dropbar').setup {
      menu = {
        -- When on, automatically set the cursor to the closest previous/next
        -- clickable component in the direction of cursor movement on CursorMoved
        quick_navigation = true,
        ---@type table<string, string|function|table<string, string|function>>
        keymaps = {
          ['<LeftMouse>'] = function()
            local menu = api.get_current_dropbar_menu()
            if not menu then
              return
            end
            local mouse = vim.fn.getmousepos()
            if mouse.winid ~= menu.win then
              local parent_menu = api.get_dropbar_menu(mouse.winid)
              if parent_menu and parent_menu.sub_menu then
                parent_menu.sub_menu:close()
              end
              if vim.api.nvim_win_is_valid(mouse.winid) then
                vim.api.nvim_set_current_win(mouse.winid)
              end
              return
            end
            menu:click_at({ mouse.line, mouse.column }, nil, 1, 'l')
          end,
          ['<CR>'] = confirm,
          ['i'] = confirm,
          ['<esc>'] = quit_curr,
          ['q'] = quit_curr,
          ['n'] = quit_curr,
          ['<MouseMove>'] = function()
            local menu = api.get_current_dropbar_menu()
            if not menu then
              return
            end
            local mouse = vim.fn.getmousepos()
            if mouse.winid ~= menu.win then
              return
            end
            menu:update_hover_hl { mouse.line, mouse.column - 1 }
          end,
        },
      },
    }
  end,
}
```

然后在`neovim` 的配置文件中将这个模块引进去。
```lua
require 'shinn.plugins.winbar'
```

| 快捷键    | 作用                                       |
|-----------|--------------------------------------------|
| <leader>; | 是选中上面的菜单，然后进行编码`a` `b` 等等 |
| [c        | 是到这块区域的最上部                       |
| ]c        | 展开同层的代码区域                         |

#### ctags
原有的ctags已经不在支持了，这里需要安装universal-ctags这是原有的版本继承而来的

[universal-ctags](https://github.com/universal-ctags/ctags?tab=readme-ov-file)

```bash
git clone https://github.com/universal-ctags/ctags
cd ctags
./autogen.sh
./configure
sudo make clean install
```

#### Vista 函数列表

[github下的Vista插件是可以对当前的一些函数和属于进行显示的](https://github.com/liuchengxu/vista.vim) 

```lua
local M = {}

-- 这里进行了一下展示写法
M.Config = {
  'liuchengxu/vista.vim',

  -- config这个函数是会在引入之后执行操作
  config = function()
    vim.g.vista_icon_indent = { '╰─▸ ', '├─▸ ' }
    vim.g.vista_default_executive = 'ctags'

    -- 这里是进行改键把快捷键改为T toggle对文件的结构进行展示操作
    -- 注意：如果我们想对这个快捷键进行描述，可以使用desc这个属性来传入一个对象
    vim.keymap.set('n', 'T', '<cmd>Vista!!<CR>', { desc = '[T]oggle tags'})
  end,
}

return M
```




