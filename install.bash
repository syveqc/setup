# update
sudo pacman -Syyu

# enable AUR in pamac
sudo sed -Ei '/EnableAUR/s/^#//' /etc/pamac.conf

# install general programs (some redundant and usually pre-installed - just to make sure they are there)
sudo pacman -Syu --needed firefox vim kitty zsh rofi $(pacman -Ssq texlive-*) signal-desktop telegram-desktop base-devel nemo
pamac install polybar arandr pulseaudio pavucontrol
sudo ln -s /var/lib/snapd/snap /snap # https://stackoverflow.com/questions/68565756
sudo snap install code --classic
sudo snap install teams-for-linux

# change default shell
chsh -s $(which zsh)

# mamba
wget "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
bash Miniforge3-$(uname)-$(uname -m).sh -b
bash ~/miniforge3/condabin/mamba init bash zsh


# firefox extensions
mkdir extensions
wget -P extensions https://addons.mozilla.org/firefox/downloads/file/4216633/ublock_origin-latest.xpi
wget -P extensions https://addons.mozilla.org/firefox/downloads/file/4211087/bitwarden_password_manager-latest.xpi
firefox extensions/ublock_origin-latest.xpi # needs to be clicked!
firefox extensions/bitwarden_password_manager-latest.xpi # needs to be clicked!
rm -rf extensions

# code extensions
code --install-extension ms-python.python
code --install-extension ms-toolsai.jupyter
code --install-extension James-Yu.latex-workshop
code --install-extension PKief.material-icon-theme
code --install-extension Equinusocio.vsc-material-theme
code --install-extension vscodevim.vim

