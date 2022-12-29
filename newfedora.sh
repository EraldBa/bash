#!/usr/bin/env bash
# For redhat linux systems
GREEN='\033[0;32m'
RESET='\033[0m'
DISTRO="Fedora"

function success() {
    printf "\n\n${GREEN}Installed $1 successfully!${RESET}\n\n"
}

function upgrade_and_install_pkg_manager(){
    sudo dnf upgrade --refresh
    wait 
    printf "\n\n${GREEN}Updated successfully!${RESET}\n\n"

    sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    wait
    success "rpm"

    sudo dnf install kitty fish neovim bat vlc bpytop firewalld steam neofetch locate
    wait
    success "first batch"
}

function i3wm(){
    sudo dnf install rofi feh polybar
    wait
    success "second batch; i3 utils"
}

function install_from_idie_repos(){
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
    sudo sh -c 'printf "[code]\nname=Visual Stcom.mattjakeman.ExtensionManager udio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
    wait
    dnf check-update
    wait
    sudo dnf install code
    wait
    success "VS Code"
}
    
function nvidia(){
    sudo dnf install akmod-nvidia
    wait
    success "Nvidia Drivers"
    sudo dnf remove xorg-x11-drv-nouveau
    wait
}


function install_flatpaks(){
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    wait
    sudo flatpak update
    wait
    success "flatpak repo"

    sudo flatpak install io.dbeaver.DBeaverCommunity com.spotify.Client com.mattjakeman.ExtensionManager 
    wait
    success "flatpak packages"
}

function move_configs(){
    declare -A dirsMap=(  
        [kitty.conf]=kitty/ 
        [config.fish]=fish/
        [config.conf]=neofetch/
        [init.vim]=nvim/
    )

    install_path="/home/erald/Documents/configs/"
    config_path="/home/erald/.config/"

    for conf in "${!dirsMap[@]}"
    do
        mv "$install_path$conf"  "${config_path}${dirsMap[$conf]}"
    done

    mv -r "${install_path}BraveSoftware/" "$config_path"

    printf "\n\n${GREEN}Moved all configs!${RESET}\n\n"
}

function switch_to_fish(){
    chsh -s $(which fish)
    printf "\n\n${GREEN}Changed default shell to fish!${RESET}\n\n"
}
