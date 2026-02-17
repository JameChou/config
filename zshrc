# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

# zsh theme
ZSH_THEME="amuse"

# load plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-vi-mode history)

# high light color style
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=12'

# load omz
source $ZSH/oh-my-zsh.sh
eval "$(zoxide init zsh)"
eval "$(oh-my-posh init zsh --config ~/Documents/config/oh-my-posh/themes/1_shell.omp.json)"
# eval "$(starship init zsh)"
export EDITOR=nvim

# --------------------------------- begin key binding--------------------------------
#
#
# initialize fuzzy finder configruation - shortcut key
# initialize zshell autosuggestion plugin shortcut key
function init_keybindings() {
	source /usr/share/fzf/key-bindings.zsh
	source /usr/share/fzf/completion.zsh
	# source /usr/local/Cellar/fzf/0.66.1/shell/key-bindings.zsh
	# source /usr/local/Cellar/fzf/0.66.1/shell/completion.zsh
	bindkey "^Y" autosuggest-accept
}

zvm_after_init_commands+=(init_keybindings)

# intialize configuration of zoxide
eval "$(zoxide init zsh)"
# --------------------------------- end key binding--------------------------------

# set the xterm color to 256
export TERM=xterm-256color

export XDG_CONFIG_HOME=~/.config
# export LC_LANG=und

# managed by pacman under ArchLinux
# export JAVA_HOME=/usr/lib/jvm/default/
# export MVN_HOME=/usr/share/java/maven

# managed by brew under macOS

# ---------------------------------- begin alias-----------------------------------
#
alias vim='nvim'
alias v='nvim'
# alias ra=ranger
alias ra=yazi
alias ranger=yazi
# To show command-line history.
alias his=history

alias pc4=proxychains4
# Automatically update system packages.
alias upsys='sudo pacman -Syyu && paru -Syyu && flatpak update'
# Lock system.
alias lockpc='swaylock -f -c 000000'

# set the terminal proxy to link 7897 port
alias all_proxy="export ALL_PROXY='socks5://127.0.0.1:7897'"
# Auto remove never used package in ArchLinux system.
alias autoremove="sudo pacman -Qtdq | sudo pacman -Rns -"
# A command-line tool for generating markdown toc that is generally supported by github.
alias ghtoc="gh-md-toc --insert --no-backup --hide-footer"
alias lg="lazygit"
# Play Bilibili videos with NVIDIA GPU acceleration. In ArchLinux or other Linux-base system.
alias play='prime-run mpv --referrer="https://www.bilibili.com" -v --no-resume-playback --hwdec=auto --ytdl-raw-options=cookies-from-browser=chrome --start=13'
# ---------------------------------- end alias-----------------------------------

[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh
