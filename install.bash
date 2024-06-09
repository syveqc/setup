BASEDIR=$(pwd)

# set package manager
PACMAN_CMD=$(which pacman)
YUM_CMD=$(which yum)

if [[ ! -z $PACMAN_CMD ]]; then
	PACKAGE_MANAGER=pacman
elif [[ ! -z $YUM_CMD ]]; then
	PACKAGE_MANAGER=yum
else
	echo "error no suitable package manager found."
	exit 1;
fi

# update
sudo $PACKAGE_MANAGER -Syyu --noconfirm

# install general programs (some redundant and usually pre-installed - just to make sure they are there)
sudo $PACKAGE_MANAGER -Syu --needed --noconfirm firefox vim kitty zsh rofi $($PACKAGE_MANAGER -Ssq texlive-*) signal-desktop telegram-desktop base-devel nemo rsync docker
yay -Syu --noconfirm polybar arandr pulseaudio pavucontrol spotify nextcloud-client go-task pre-commit sioyek nvidia-settings libwacom xf86-input-wacom xournalpp biber xclip borgmatic python-llfuse flameshot

# docker
sudo systemctl enable docker.socket

# snap
mkdir ~/git
cd ~/git
git clone https://aur.archlinux.org/snapd.git
cd snapd
makepkg -si --noconfirm
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap # https://stackoverflow.com/questions/68565756
cd ~

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

# neovim
bash $BASEDIR/neovim.bash

# copy dotfiles
rsync -a $BASEDIR/.config/ ~/.config/
cp $BASEDIR/.p10k.zsh ~/
cp $BASEDIR/.zshrc ~/

# mamba init
~/miniforge3/condabin/mamba init bash zsh

# kitty themes
cd ~/git
git clone https://github.com/dexpota/kitty-themes
ln -s ~/git/kitty-themes/themes/MaterialDark.conf ~/.config/kitty/theme.conf
echo "include ./theme.conf" >> ~/.config/kitty/kitty.conf

# snap stuff
zsh $BASEDIR/install_snap_stuff.zsh

# change shell to zsh
chsh -s $(which zsh)

# firefox extensions
mkdir extensions
wget -P extensions https://addons.mozilla.org/firefox/downloads/file/4216633/ublock_origin-latest.xpi
wget -P extensions https://addons.mozilla.org/firefox/downloads/file/4211087/bitwarden_password_manager-latest.xpi
wget -P extensions https://addons.mozilla.org/firefox/downloads/file/3643624/firefox_color-latest.xpi
firefox extensions/ublock_origin-latest.xpi # needs to be clicked!
firefox extensions/bitwarden_password_manager-latest.xpi # needs to be clicked!
firefox extensions/firefox_color-latest.xpi # needs to be clicked!
firefox https://github.com/rose-pine/firefox # go to rose pine firefox theme github to apply
rm -rf extensions

