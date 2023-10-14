#!/usr/bin/env bash
# Uninstall extra fonts 
sudo apt purge \
fonts-beng-extra \
fonts-beng \
fonts-deva-extra \
fonts-deva \
fonts-gargi \
fonts-gubbi \
fonts-gujr-extra \
fonts-gujr \
fonts-guru-extra \
fonts-guru \
fonts-indic \
fonts-kacst-one \
fonts-kacst \
fonts-kalapi \
fonts-khmeros-core \
fonts-knda \
fonts-lao \
fonts-lklug-sinhala \
fonts-lohit-beng-assamese \
fonts-lohit-beng-bengali \
fonts-lohit-deva \
fonts-lohit-gujr \
fonts-lohit-guru \
fonts-lohit-knda \
fonts-lohit-mlym \
fonts-lohit-orya \
fonts-lohit-taml-classical \
fonts-lohit-taml \
fonts-lohit-telu \
fonts-mlym \
fonts-nakula \
fonts-navilu \
fonts-noto-cjk \
fonts-orya-extra \
fonts-orya \
fonts-pagul \
fonts-sahadeva \
fonts-samyak-deva \
fonts-samyak-gujr \
fonts-samyak-mlym \
fonts-samyak-taml \
fonts-sarai \
fonts-sil-abyssinica \
fonts-sil-padauk \
fonts-smc-anjalioldlipi \
fonts-smc-chilanka \
fonts-smc-dyuthi \
fonts-smc-karumbi \
fonts-smc-keraleeyam \
fonts-smc-manjari \
fonts-smc-meera \
fonts-smc-rachana \
fonts-smc-raghumalayalamsans \
fonts-smc-suruma \
fonts-smc-uroob \
fonts-smc \
fonts-taml \
fonts-telu-extra \
fonts-telu \
fonts-thai-tlwg \
fonts-tibetan-machine \
fonts-tlwg-garuda-ttf \
fonts-tlwg-garuda \
fonts-tlwg-kinnari-ttf \
fonts-tlwg-kinnari \
fonts-tlwg-laksaman-ttf \
fonts-tlwg-laksaman \
fonts-tlwg-loma-ttf \
fonts-tlwg-loma \
fonts-tlwg-mono-ttf \
fonts-tlwg-mono \
fonts-tlwg-norasi-ttf \
fonts-tlwg-norasi \
fonts-tlwg-purisa-ttf \
fonts-tlwg-purisa \
fonts-tlwg-sawasdee-ttf \
fonts-tlwg-sawasdee \
fonts-tlwg-typewriter-ttf \
fonts-tlwg-typewriter \
fonts-tlwg-typist-ttf \
fonts-tlwg-typist \
fonts-tlwg-typo-ttf \
fonts-tlwg-typo \
fonts-tlwg-umpush-ttf \
fonts-tlwg-umpush \
fonts-tlwg-waree-ttf \
fonts-tlwg-waree \
fonts-yrsa-rasa 

# Install Fonts
# preferences are already set up in config dotfile
# changes should take effect on system restart

font_dir="$HOME/.local/share/fonts"

mkdir "$font_dir"
mkdir "$font_dir/ttf"

mkdir ~/temp
cd ~/temp

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/SourceCodePro.zip
wget https://github.com/solmatas/BitterPro/files/4696179/ttf.zip
wget https://github.com/rsms/inter/releases/download/v3.19/Inter-3.19.zip

unzip SourceCodePro.zip # SourceCodePro
unzip ttf.zip # BitterPro
unzip Inter-3.19.zip # SourceCodePro
mv **/Inter.ttf "$font_dir/ttf/Inter.ttf"

mv **/ttf/* "$font_dir/ttf"
cd ..
rm -rf ~/temp

# update the font cache
fc-cache -vf "$font_dir"
