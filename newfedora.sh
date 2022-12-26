#!/usr/bin/env bash
# For redhat linux systems
GREEN='\033[0;32m'

function success() {
    printf "\n\n${GREEN}Installed $1 successfully!\n\n"
}


sudo dnf upgrade --refresh
wait 
printf "\n\n${GREEN}Updated successfully!\n\n"

sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
wait
success "rpm"

sudo dnf install kitty fish neovim bat vlc bpytop firewalld steam neofetch locate
wait
success "first batch"
# For i3
sudo dnf install rofi feh
wait
success "second batch; i3 utils"

sudo dnf install dnf-plugins-core
wait

sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
wait

sudo dnf install brave-browser
wait
success "Brave Browser"

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
wait 
sudo sh -c 'printf -e "[code]\nname=Visual Stcom.mattjakeman.ExtensionManager udio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
wait
dnf check-update
wait
sudo dnf install code
wait
success "VS Code"

# For asus
# sudo dnf install akmod-nvidia
# wait
# success "Nvidia Drivers"
# sudo dnf remove xorg-x11-drv-nouveau
# wait
# sudo systemd-run --on-active="2h" --unit nvidia-powerd.service                                                                                       0 (0.000s) < 21:43:
# printf "\n\n${GREEN}Enabled scheduled restart of nvidia-power every 2 hours\n\n"


# Here come the flatpaks
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
wait
sudo flatpak update
wait
success "flatpak repo"

sudo flatpak install io.dbeaver.DBeaverCommunity com.spotify.Client com.mattjakeman.ExtensionManager 
wait
success "flatpak packages"

# install_path = "/home/erald/Documents/Install/"
# config_path = "/home/erald/.config/"

# mv "${install_path}kitty.conf"  "${config_path}kitty/kitty.conf"
# mv "${install_path}config.fish"  "${config_path}fish/config.fish"
# mv "${install_path}config.conf"  "${config_path}neofetch/config.conf"

# printf "\n\n${GREEN}Moved all configs!\n\n"

chsh -s $(which fish)

printf "\n\n${GREEN}Changed default shell to fish!\n\n"
