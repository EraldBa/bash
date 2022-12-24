#!/usr/bin/env bash

# For redhat linux systems

sudo dnf upgrade --refresh
wait 

sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
wait

sudo dnf install kitty fish neovim bat vlc bpytop firewalld steam neofetch clocate
wait

sudo dnf install dnf-plugins-core
wait

sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
wait

sudo dnf install brave-browser
wait

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
wait 
sudo sh -c 'echo -e "[code]\nname=Visual Stcom.mattjakeman.ExtensionManager udio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
wait
dnf check-update
wait
sudo dnf install code
wait
# For asus
# sudo dnf install akmod-nvidia
# wait
# sudo dnf remove xorg-x11-drv-nouveau
# wait

# Here come the flatpaks
sudo flatpak update
wait

sudo flatpak install io.dbeaver.DBeaverCommunity com.spotify.Client com.mattjakeman.ExtensionManager 
wait

install_path = "/home/erald/Documents/Install/"
config_path = "/home/erald/.config/"

mv "$install_path+kitty.conf"  "$config_path+kitty/kitty.conf"
mv "$install_path+config.fish"  "$config_path+fish/config.fish"
mv "$install_path+config.conf"  "$config_path+neofetch/config.conf"

chsh -s $(which fish)