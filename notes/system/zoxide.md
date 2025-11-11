# zoxide

[zoxide github page](https://github.com/ajeetdsouza/zoxide)

Zoxide is a command tool that remembers directories which I use frequently.

Here is the example.

```bash
z foo              # cd into highest ranked directory matching foo
z foo bar          # cd into highest ranked directory matching foo and bar
z foo /            # cd into a subdirectory starting with foo

z ~/foo            # z also works like a regular cd command
z foo/             # cd into relative path
z ..               # cd one level up
z -                # cd into previous directory

zi foo             # cd with interactive selection (using fzf)

z foo<SPACE><TAB>  # show interactive completions (zoxide v0.8.0+, bash 4.4+/fish/zsh only)
```


## How to install

* In macos:

```bash
brew install zoxide
```

* In ArchLinux

```bash
sudo pacman -S zoxide

```

### Initialize the configuration of zoxide in zsh.

```bash
eval "$(zoxide init zsh)"
```









