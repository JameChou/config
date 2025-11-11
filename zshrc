# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

# zsh theme
ZSH_THEME="amuse"

# load plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-vi-mode history)

# high light color style
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=12'

# load omz
source $ZSH/oh-my-zsh.sh
eval "$(starship init zsh)"
export EDITOR=nvim

# --------------------------------- begin key binding--------------------------------
#
function init_keybindings() {
	# source /usr/share/fzf/key-bindings.zsh
	# source /usr/share/fzf/completion.zsh
	source /usr/local/Cellar/fzf/0.66.1/shell/key-bindings.zsh
	source /usr/local/Cellar/fzf/0.66.1/shell/completion.zsh
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

export JAVA_HOME=/usr/lib/jvm/default/
export MVN_HOME=/usr/share/java/maven

# ---------------------------------- begin alias-----------------------------------
#
alias vim='nvim'
alias ra=ranger
alias his=history

alias pc4=proxychains4
alias upsys='sudo pacman -Syyu && pc4 paru -Syyu && pc4 flatpak update'
alias lockpc='swaylock -f -c 000000'

# set the terminal proxy to link 7897 port
alias all_proxy="export ALL_PROXY='socks5://127.0.0.1:7897'"
alias autoremove="sudo pacman -Qtdq | sudo pacman -Rns -"
alias ghtoc="gh-md-toc --insert --no-backup --hide-footer"
alias lg="lazygit"
alias mpvbili='prime-run mpv --referrer="https://www.bilibili.com" -v --no-resume-playback --hwdec=auto --ytdl-raw-options=cookies-from-browser=chrome --start=13'
# ---------------------------------- end alias-----------------------------------
