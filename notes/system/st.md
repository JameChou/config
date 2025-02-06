## St Terminal Configuration

<!--ts-->
   * [St Terminal Configuration](#st-terminal-configuration)
      * [Change the shell to zsh](#change-the-shell-to-zsh)
      * [Change the font](#change-the-font)
      * [Shortcut Zoom](#shortcut-zoom)
      * [Tranparency](#tranparency)
<!--te-->

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

### Shortcut Zoom
```c
static Shortcut shortcuts[] = {
	/* mask                 keysym          function        argument */
	{ XK_ANY_MOD,           XK_Break,       sendbreak,      {.i =  0} },
	{ ControlMask,          XK_Print,       toggleprinter,  {.i =  0} },
	{ ShiftMask,            XK_Print,       printscreen,    {.i =  0} },
	{ XK_ANY_MOD,           XK_Print,       printsel,       {.i =  0} },
	// 这里是放大 Prior是代表PageUp
	{ TERMMOD,              XK_Prior,       zoom,           {.f = +1} },
	// 这里是缩小 Next是代表PageDn
	{ TERMMOD,              XK_Next,        zoom,           {.f = -1} },
	// 这里是恢复到默认的状态, Home键
	{ TERMMOD,              XK_Home,        zoomreset,      {.f =  0} },
	{ TERMMOD,              XK_C,           clipcopy,       {.i =  0} },
	{ TERMMOD,              XK_V,           clippaste,      {.i =  0} },
	{ TERMMOD,              XK_Y,           selpaste,       {.i =  0} },
	{ ShiftMask,            XK_Insert,      selpaste,       {.i =  0} },
	{ TERMMOD,              XK_Num_Lock,    numlock,        {.i =  0} },
};
```


### Tranparency
下载patch
```bash
wget st.suckless.org/patches/alpha/st-alpha-20240814-a0274bc.diff
path -p1 < patches/st-alpha-20240814-a0274bc.diff

sudo make clean install
```

