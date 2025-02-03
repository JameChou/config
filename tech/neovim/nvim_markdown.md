## Markdown Configuration in NeoVim
[[toc]]

### Install Markdown Preview Plugin for NeoVim

Install nodejs and npm.
```bash
sudo pacman -S nodejs npm
sudo proxychains4 npm install --global yarn

# set the registry from official to taobao
yarn config set registry https://registry.npm.taobao.org

# disable yarn ssl connect
yarn config set strict-ssl false

```

Import `instant-markdown` plugin to lazyvim manager. Run `nvim`, use command `:Lazy` to install the plugin.

```lua
  {
    'instant-markdown/vim-instant-markdown',
    ft = { 'markdown' },
    build = 'yarn install',
    config = function()
      vim.g.instant_markdown_autostart = 0
    end,
  },
```

Use `:InstantMarkdownPreview` for  openning the chrome/firefox(default browser) to preview the markdown rendered html on real-time.

`:InstantMarkdownStop` to stop the preview process & close the tab in borwser.

### Snippets for Markdown
Create a new folder called `ftplgin`, `~/.config/nvim`  then create a new file `markdown.vim`, paste the follow lines, restart the nvim.

```vim
"autocmd Filetype markdown map <leader>w yiWi[<esc>Ea](<esc>pa)
autocmd Filetype markdown inoremap <buffer> ,f <Esc>/<++><CR>:nohlsearch<CR>"_c4l
autocmd Filetype markdown inoremap <buffer> ,w <Esc>/ <++><CR>:nohlsearch<CR>"_c5l<CR>
autocmd Filetype markdown inoremap <buffer> ,n ---<Enter><Enter>
autocmd Filetype markdown inoremap <buffer> ,b **** <++><Esc>F*hi
autocmd Filetype markdown inoremap <buffer> ,s ~~~~ <++><Esc>F~hi
autocmd Filetype markdown inoremap <buffer> ,i ** <++><Esc>F*i
autocmd Filetype markdown inoremap <buffer> ,d `` <++><Esc>F`i
autocmd Filetype markdown inoremap <buffer> ,c ```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA
autocmd Filetype markdown inoremap <buffer> ,m - [ ] 
autocmd Filetype markdown inoremap <buffer> ,p ![](<++>) <++><Esc>F[a
autocmd Filetype markdown inoremap <buffer> ,a [](<++>) <++><Esc>F[a
autocmd Filetype markdown inoremap <buffer> ,1 #<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap <buffer> ,2 ##<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap <buffer> ,3 ###<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap <buffer> ,4 ####<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap <buffer> ,l --------<Enter>
```

#### Shortcuts for Markdown
| 快捷键 | 创建的文字       |
|--------|------------------|
| `,n`   | ---              |
| `,b`   | **粗体**文字     |
| `,s`   | ~~被划去~~的文字 |
| `,i`   | *斜体*文字       |
| `,d`   | `代码块`         |
| `,c`   | 大的 `代码块`    |
| `,m`   | - [ ] 清单       |
| `,p`   | 图片             |
| `,a`   | [链接]()         |
| `,1`   | # H1             |
| `,2`   | ## H2            |
| `,3`   | ### H3           |
| `,4`   | #### H4          |
| `,l`   | --------         |

`,w` backword the next `<++>`
`,f` forware the next `<++>`
