#! /usr/bin/env bash
# to run:
# wget raw.githubusercontent.com/dmsun/Arch-Linux-Config/master/aur_setup.sh
# chmod +x aur_setup.sh
# ./aur_setup.sh

echo "Checking for system updates..."
sudo pacman -Syu

echo "Installing pacaur dependencies"
sudo pacman -Syu base-devel --needed
sudo pacman -Syu expac yajl git --noconfirm --needed

echo "Creating temporary install area"
mkdir -p ~/tmp/pacaur_install
cd ~/tmp/pacaur_install

#install cower from AUR
echo "Cloning Cower into temporary directory"
git clone https:/aur.archlinux.org/cower.git
cd cower
echo "Installing Cower"
makepkg -i
cd ..
#install pacaur from AUR
echo "Cloning Pacaur into temporary directory"
git clone https://aur.archlinux.org/pacaur.git
cd pacaur
echo "Installing Pacuar"
makepkg -i

#cleanup files
cd ~
echo "Removing temporary files"
rm -r ~/tmp/pacaur_install
echo "Complete"