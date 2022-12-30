#/usr/bin/env fish

backup_path="/home/erald/Documents/configs/"
configs_path="/home/erald/.config/"

declare -A my_configs=(
    ["${configs_path}nvim/init.vim"]="init.vim"
    ["${configs_path}fish/config.fish"]="config.fish"
    ["/usr/share/X11/xorg.conf.d/nvidia.conf"]="nvidia.conf"
    ["${configs_path}kitty/kitty.conf"]="kitty.conf"
    ["${configs_path}neofetch/config.conf"]="neofetch/config.conf"
)

for conf in "${!my_configs[@]}"
do 
    cp "${conf}" "$backup_path${my_configs[$conf]}"
done

cp -r "${configs_path}BraveSoftware/" "${backup_path}BraveSoftware"

echo "Backup configs update complete!"