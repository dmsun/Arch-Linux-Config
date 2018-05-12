#! /usr/bin/env bash
# to run:
# wget raw.githubusercontent.com/dmsun/arch-linux-config/master/backup_config_files.sh
#chmod +x backup_config_files.sh
#./backup_config_files.sh

echo "Beginning backup of configuration files to Dropbox and github"
echo "copying conky configuration"
cp -r ~/.config/conky/. ~/Dropbox/arch-linux-config/conky/.
echo "copying archey configuration"
cp -r ~/.config/archey/. ~/Dropbox/arch-linux-config/archey/
echo "copying bachrc and bash_profile"
cp ~/.bashrc ~/Dropbox/arch-linux-config/.bashrc
cp ~/.bash_profile ~/Dropbox/arch-linux-config/.bash_profile
echo "copying xinitrc"
cp ~/.xinitrc ~/Dropbox/arch-linux-config/.xinitrc
echo "copying nvim configuration"
cp  ~/.config/nvim/. ~/Dropbox/arch-linux-config/nvim/

echo "Commiting to github"
cd ~/Dropbox/arch-linux-config/
git add *
echo "commiting regular files"
git commit -m "adding regular files"
git add .*
echo "commiting hidden files"
git commit -m "adding hidden files"
git push

cd ~
echo "Backing up key configuration files is complete"



