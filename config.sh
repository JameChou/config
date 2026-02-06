!#/bin/bash
export ALL_PROXY='http://127.0.0.1:7897'

sudo pacman -S fzf wl-clipboard cliphist wf-recorder slurp ffmpeg zsh neovim tmux waybar

cd ~/.config
ln -s ~/Documents/config/hypr/ .
ln -s ~/Documents/config/gtk* .
ln -s ~/Documents/config/tmux/ .
ln -s ~/Documents/config/rofi/ .
ln -s ~/Documents/config/kitty/ .
ln -s ~/Documents/config/mpv/ .
ln -s ~/Documents/config/chrome-flags.conf .
ln -s ~/Documents/config/fontconfig/ .
ln -s ~/Documents/config/oh-my-posh/ .
ln -s ~/Documents/config/waybar/ .

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/jeffreytse/zsh-vi-mode.git $ZSH_CUSTOM/plugins/zsh-vi-mode
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions

curl -s https://ohmyposh.dev/install.sh | bash -s


