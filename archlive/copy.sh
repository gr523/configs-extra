#!/bin/sh

BASE_DIR="$HOME/archlive/custom/airootfs"
HOME_DIR="$BASE_DIR/root"

ln -sf /usr/share/zoneinfo/Asia/Dhaka "${BASE_DIR}/etc/localtime"

mkdir -p "${BASE_DIR}/etc/pacman.d"
cp -L /etc/pacman.d/mirrorlist "$BASE_DIR/etc/pacman.d/"

mkdir -p "$HOME_DIR/.local/bin"
mkdir -p "$HOME_DIR/.cache"
rsync -L -a --delete ~/.cache/gitstatus "$HOME_DIR/.cache/"
rsync -L -a --delete ~/.mozilla "$HOME_DIR/"
rm "${HOME_DIR}/.mozilla/firefox/c0uxp8xo.default-release/cookies.sqlite"

cp -L /usr/bin/{light,rofi-bluetooth} "$HOME_DIR/.local/bin/"
cp -L /usr/local/bin/{dmenu,dmenu_run,dmenu_path,stest} "${HOME_DIR}/.local/bin/"

cp -L ~/.fdignore "$HOME_DIR/"
cp -L ~/.profile "$HOME_DIR/.zprofile"

mkdir -p "$HOME_DIR/.config"
rsync -L -a --delete ~/.config/{alacritty,gtk-2.0,gtk-3.0,Scripts,nvim,awesome,pcmanfm,redshift,zsh,rofi,tmux} "$HOME_DIR/.config/"
rsync -L ~/.config/{aliases,aliases_arch,wallpaper.jpeg,picom.conf} "$HOME_DIR/.config/"

rsync -L -a --delete ~/.config/coc "${HOME_DIR}/.config/"

sed -i 's/local.*browser.*=.*/local browser="firefox"/'  "$HOME_DIR/.config/awesome/keymaps.lua"

# zsh
mkdir -p "$HOME_DIR/.local/share/{zsh,fonts}"
mkdir -p "$HOME_DIR/.cache/zsh"
rsync -L -a --delete ~/.local/share/zsh/plugins "$HOME_DIR/.local/share/zsh/"
tar xf ~/.config/Configs/fonts.lzma -C "$HOME_DIR/.local/share"

rm $BASE_DIR/etc/systemd/system/multi-user.target.wants/*

# network manager
ln -sf /usr/lib/systemd/system/NetworkManager.service "$BASE_DIR/etc/systemd/system/multi-user.target.wants/NetworkManager.service"
ln -sf /usr/lib/systemd/system/NetworkManager-dispatcher.service "$BASE_DIR/etc/systemd/system/dbus-org.freedesktop.nm-dispatcher.service"
ln -sf /usr/lib/systemd/system/NetworkManager-wait-online.service "$BASE_DIR/etc/systemd/system/network-online.target.wants/NetworkManager-wait-online.service"

ln -sf /usr/bin/nvim "$HOME_DIR/.local/bin/vi"


# startx
echo "exec startx" >> "$HOME_DIR/.zprofile"
echo "exec awesome" > "$HOME_DIR/.xinitrc"

rm "$HOME_DIR/.config/gtk-3.0/bookmarks"
rm -r "$BASE_DIR/etc/systemd/system/cloud-init.target.wants"
sed -i 's:.*xinput.*::g' "${HOME_DIR}/.config/Scripts/autostart.sh"
echo "pulseaudio --daemonize" >> "${HOME_DIR}/.config/Scripts/autostart.sh"

mkdir -p "$HOME_DIR/Codes/X"
touch "$HOME_DIR/Codes/X/Input.txt"
touch "$HOME_DIR/Codes/X/Output.txt"

echo "[ ! -f /usr/include/c++/11.1.0/x86_64-pc-linux-gnu/bits/stdc++.h.gch ] && g++ --std=c++20 -x c++-header -fsanitize=undefined /usr/include/c++/11.1.0/x86_64-pc-linux-gnu/bits/stdc++.h &" > "${BASE_DIR}/etc/profile"

rsync ~/.local/share/zap/v2/hw-probe-1.5-164-x86_64.AppImage "${HOME_DIR}/.local/bin/hw-probe"
rsync -a ~/archlive/{pr.tar.gpg,pr.sh} "${HOME_DIR}/"
