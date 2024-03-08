BASEDIR=$(pwd)

# update
sudo pacman -Syyu

# install general programs (some redundant and usually pre-installed - just to make sure they are there)
sudo pacman -Syu --needed --noconfirm firefox vim kitty zsh rofi $(pacman -Ssq texlive-*) signal-desktop telegram-desktop base-devel nemo rsync
yay install polybar arandr pulseaudio pavucontrol

# snap
mkdir ~/git
cd ~/git
git clone https://aur.archlinux.org/snapd.git
cd snapd
makepkg -si --noconfirm
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap # https://stackoverflow.com/questions/68565756
cd ~

sudo snap install code --classic
sudo snap install obisidian --classic
sudo snap install teams-for-linux

# oh-my-zsh
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" --unattended

# powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

# mamba
wget "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
bash Miniforge3-$(uname)-$(uname -m).sh -b
~/miniforge3/condabin/mamba init bash zsh
rm Miniforge-*


# firefox extensions
mkdir extensions
wget -P extensions https://addons.mozilla.org/firefox/downloads/file/4216633/ublock_origin-latest.xpi
wget -P extensions https://addons.mozilla.org/firefox/downloads/file/4211087/bitwarden_password_manager-latest.xpi
firefox extensions/ublock_origin-latest.xpi # needs to be clicked!
firefox extensions/bitwarden_password_manager-latest.xpi # needs to be clicked!
rm -rf extensions

# code extensions
snap run code --install-extension ms-python.python
snap run code --install-extension ms-toolsai.jupyter
snap run code --install-extension James-Yu.latex-workshop
snap run code --install-extension PKief.material-icon-theme
snap run code --install-extension Equinusocio.vsc-material-theme
snap run code --install-extension vscodevim.vim

# copy dotfiles
rsync -a $BASEDIR/.config/ ~/.config/
cp $BASEDIR/.p10k.zsh ~/
cp $BASEDIR/.zshrc ~/

# kitty themes
cd ~/git
git clone https://github.com/dexpota/kitty-themes
ln -s ~/git/kitty-themes/themes/MaterialDark.conf ~/.config/kitty/theme.conf
echo "include ./theme.conf" >> ~/.config/kitty/kitty.conf


