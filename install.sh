#!/bin/bash

if [ "$(whoami)" == "root" ]; then
    exit 1
fi

ruta=$(pwd)

# Instalando dependencias de Entorno

sudo apt install -y build-essential git vim xcb libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev
sudo apt install -y cmatrix
sudo apt install -y mugshot xfce4-terminal

# Importando cursores

git clone https://github.com/alvatip/Radioactive-nord.git 
cd Radioactive-nord 
chmod +x install.sh 
./install.sh
echo "cursores instalados"
cd $ruta

# Instalamos paquetes adionales

sudo apt install -y kitty feh scrot scrub rofi xclip bat locate ranger wmname acpi sxhkd imagemagick

# Creando carpeta de Reposistorios

mkdir $ruta/github

# Dependencias de Picom

sudo apt install -y meson libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev libxcb-glx0-dev libpcre3 libpcre3-dev

cd $ruta/github/
git clone https://github.com/ibhagwan/picom.git

# Instalando Picom
cd $ruta/github/picom

git submodule update --init --recursive
meson --buildtype=release . build
ninja -C build
sudo ninja -C build install

sudo cp -r $ruta/Components/picom-config/picom.conf ~/.config/

# Instalando p10k

cd $ruta/github/
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
echo 'source ~/.powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

# Instalando p10k root

sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/.powerlevel10k


# Instando lsd

sudo dpkg -i $ruta/lsd.deb

# Instalamos las HackNerdFonts

sudo cp -v $ruta/fonts/HNF/* /usr/local/share/fonts/

# Copiando Archivos de Configuración

cp -rv $ruta/Config/* ~/.config/
sudo cp -rv $ruta/kitty /opt/

# Copia de configuracion de .p10k.zsh y .zshrc

rm -rf ~/.zshrc
cp -v $ruta/.zshrc ~/.zshrc

cp -v $ruta/.p10k.zsh ~/.p10k.zsh
sudo cp -v $ruta/.p10k.zsh-root /root/.p10k.zsh

# Script

sudo cp -v $ruta/scripts/whichSystem.py /usr/local/bin/
sudo cp -v $ruta/scripts/screenshot /usr/local/bin/

# Plugins ZSH

sudo apt install -y zsh-syntax-highlighting zsh-autosuggestions
sudo mkdir /usr/share/zsh-sudo
cd /usr/share/zsh-sudo
sudo wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/sudo/sudo.plugin.zsh

# Cambiando de SHELL a zsh

sudo ln -s -fv ~/.zshrc /root/.zshrc

# Asignamos Permisos a los Scritps

chmod +x ~/.config/bin/ethernet_status.sh
chmod +x ~/.config/bin/htb_status.sh
chmod +x ~/.config/bin/htb_target.sh
chmod +x ~/.config/polybar/launch.sh
sudo chmod +x /usr/local/bin/whichSystem.py
sudo chmod +x /usr/local/bin/screenshot

#Installing fonts 

cp -r $ruta/Components/fonts ~/.local/share

#rxfetch

cd $ruta/github
git clone https://github.com/mangeshrex/rxfetch
cd rxfetch
cp ttf-material-design-icons/* $HOME/.local/share/fonts
# update fontconfig
fc-cache -fv
run rxfetch
./rxfetch
wget https://raw.githubusercontent.com/Mangeshrex/rxfetch/main/rxfetch && chmod +x rxfetch
sudo cp rxfetch /usr/local/bin
cd $ruta/rxfetch
sudo cp neo /usr/local/bin
sudo rm -rf /usr/local/bin/rxfetch

#Temas rositas 

cd $ruta/github

git clone https://github.com/vinceliuice/Lavanda-gtk-theme.git
cd Lavanda-gtk-theme
chmod +x install.sh
./install.sh

cd $ruta/github
git clone https://github.com/vinceliuice/Colloid-icon-theme.git
cd Colloid-icon-theme
chmod +x install.sh 
./install.sh -s nord -t pink
cd $ruta

# Mensaje de Instalado

notify-send "Kali configurado"


echo "La maquina se reiniciara en 30 segundos"
sleep 30 

kill -9 -1 
