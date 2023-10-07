## telegram desktop
#wget -O tg_d.tar.xz https://telegram.org/dl/desktop/linux
#mkdir -p ~/bin
#tar -xf tg_d.tar.xz -C ~/bin

## ssh key
#ssh-keygen -t ed25519 -C "andreyku6@gmail.com"
#eval "$(ssh-agent -s)"
#ssh-add ~/.ssh/id_ed25519
#cat ~/.ssh/id_ed25519.pub
#TODO add it to github auto

## dot files
#sudo apt install git -y &&
#git clone git@github.com:KukuruzaAndrii/dotfiles.git &&
#shopt -s dotglob &&
#mv ./dotfiles/* ./ && #TODO  without .git
#rm -rf ./dotfiles


## user libs
mkdir -p dev

sudo apt install emacs libfuse2 -y
