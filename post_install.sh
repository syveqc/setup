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

