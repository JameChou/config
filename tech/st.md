## St Terminal Configuration

[Check the ArchLinux wiki about st doc](https://wiki.archlinux.org/title/St)


### Change the shell to zsh
```c
// change the bash shell to zshell
static char *shell = "/bin/zsh"

// can use which command to check the zshell location
static char *shell = "/usr/bin/zsh"

```


### Change the font
Edit the following line:
```c
static char *font = "Mono:pixelsize=12:antialias=false:autohint=false";

// Change to
```

