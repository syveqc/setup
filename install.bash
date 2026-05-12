BASEDIR=$(pwd)

# sudoloop
sudo -v  # prompt once, cache credentials
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
SUDO_KEEPALIVE_PID=$!
trap 'kill $SUDO_KEEPALIVE_PID' EXIT

# update
sudo pacman -Syyu --noconfirm

# install yay
sudo pacman -Syu --needed --noconfirm git base-devel fakeroot debugedit
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si

# install base programs
cd $BASEDIR
REPO_PKGS=(
  nextcloud-client nvidia-open-dkms nvidia-utils egl-wayland nvidia-settings
  libwacom xf86-input-wacom xournalpp biber borgmatic lazygit ranger
  bitwarden bitwarden-cli autorandr firefox vim kitty zsh signal-desktop
  telegram-desktop nemo rsync docker qt5-wayland qt6-wayland hyprland
  grim slurp wl-clipboard hypridle spotify-launcher qt5-3d sioyek-appimage
  wget curl
)

# no AUR packages so far
# AUR_PKGS=(
# )

sudo pacman -Syu --noconfirm --needed "${REPO_PKGS[@]}"
# yay -S --noconfirm "${AUR_PKGS[@]}"

# docker - not needed?
# sudo systemctl enable docker.socket

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

# zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
git clone https://github.com/marlonrichert/zsh-autocomplete ~/.oh-my-zsh/plugins/zsh-autocomplete
git clone https://github.com/jeffreytse/zsh-vi-mode ~/.oh-my-zsh/plugins/zsh-vi-mode

# mamba
wget "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
bash Miniforge3-$(uname)-$(uname -m).sh -b
rm Miniforge3-*

# mamba init
~/miniforge3/condabin/mamba init bash zsh

# neovim
bash $BASEDIR/neovim.bash

# copy dotfiles
rsync -a $BASEDIR/.config/ ~/.config/
cp $BASEDIR/.p10k.zsh ~/
cp $BASEDIR/.zshrc ~/

# get wallpaper
mkdir -p ~/Pictures/wallpapers
wget -O ~/Pictures/wallpapers/leafy-moon.png 'https://github.com/rose-pine/wallpapers/blob/c158dda0f482b063c98cbf3a3d178d4170abecc4/leafy-moon.png?raw=true'

# kitty themes
cd ~/git
git clone https://github.com/dexpota/kitty-themes
ln -s ~/git/kitty-themes/themes/MaterialDark.conf ~/.config/kitty/theme.conf

# change shell to zsh
chsh -s $(which zsh)

