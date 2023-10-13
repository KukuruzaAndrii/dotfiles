set -xe

sudo dnf install gh git gnome-tweaks binutils -y


# swap ctrl and caps lock
gsettings set org.gnome.desktop.input-sources xkb-options [\'ctrl:swapcaps\']

# disable auto lock
gsettings set org.gnome.desktop.screensaver lock-enabled false


# enable auto log on
sudo sed -i s/AutomaticLoginEnable=False/AutomaticLoginEnable=True/ /etc/gdm/custom.conf


## ll
if grep -q "alias ll" ~/.bashrc
then
echo alias ll=\'ls -al --color=auto\' >> ~/.bashrc
fi

## Fedora video problems
#enable RPM repo
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
# install multymedia libs
sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel
sudo dnf install lame\* --exclude=lame-devel
sudo dnf group upgrade --with-optional Multimedia --allowerasing

# terminal shortcut
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings [\'/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/\']
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name \'terminal\'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command \'gnome-terminal\'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding \'\<Control\>\<Alt\>t\'

## telegram desktop

#wget -O tg_d.tar.xz https://telegram.org/dl/desktop/linux
#mkdir -p ~/bin
#tar -xf tg_d.tar.xz -C ~/bin
#rm -f tg_d.tar.xz

## ssh key
ssh-keygen -t ed25519 -C "andreyku6@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
#TODO add it to github auto
gh auth

## dot files
#sudo apt install git -y &&
#git clone git@github.com:KukuruzaAndrii/dotfiles.git &&
#shopt -s dotglob &&
#mv ./dotfiles/* ./ && #TODO  without .git
#rm -rf ./dotfiles


## user libs
#mkdir -p dev

#sudo apt install emacs libfuse2 -y
