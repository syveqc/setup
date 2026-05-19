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
makepkg
sudo pacman -U --noconfirm yay-bin-*.pkg.tar.zst

# install base programs
cd $BASEDIR
REPO_PKGS=(
  nextcloud-client nvidia-open-dkms nvidia-utils egl-wayland nvidia-settings
  libwacom xf86-input-wacom xournalpp biber borgmatic lazygit ranger
  bitwarden bitwarden-cli autorandr firefox vim zsh signal-desktop
  telegram-desktop nemo rsync docker qt5-wayland qt6-wayland hyprland
  grim slurp wl-clipboard hypridle spotify-launcher wget curl
  starship zoxide greetd greetd-tuigreet mako fuzzel ttf-firacode-nerd
  hyprpaper waybar npm stylua unzip
)

AUR_PKGS=(
  sioyek-appimage wezterm-git
)

sudo pacman -Syu --noconfirm --needed "${REPO_PKGS[@]}"
yay -S --noconfirm "${AUR_PKGS[@]}"

# docker - not needed?
# sudo systemctl enable docker.socket

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
cp $BASEDIR/.zshrc ~/

# get wallpaper
mkdir -p ~/Pictures/wallpapers
wget -O ~/Pictures/wallpapers/leafy-moon.png 'https://github.com/rose-pine/wallpapers/blob/c158dda0f482b063c98cbf3a3d178d4170abecc4/leafy-moon.png?raw=true'

# greetd config
sudo cp $BASEDIR/.config/greetd/config.toml /etc/greetd/config.toml
sudo systemctl enable greetd

# change shell to zsh
sudo chsh -s $(which zsh) $USER

