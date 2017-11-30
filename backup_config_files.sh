#! /usr/bin/env bash
# to run:
# wget raw.githubusercontent.com/dmsun/Arch-Linux-Config/master/backup_config_files.sh
#chmod +x backup_config_files.sh
#./backup_config_files.sh

echo "Beginning backup of configuration files to Dropbox and github"
echo "copying conky configuration"
cp ~/.config/conky/conky.conf ~/Dropbox/Arch-Linux-Config/conky/
echo "copying archey configuration"
cp ~/.config/archey ~/Dropbox/Arch-Linux-Config/.archey.cfg
echo "copying bachrc and bash_profile"
cp ~/.bashrc ~/Dropbox/Arch-Linux-Config/
cp ~/.bash_profile ~/Dropbox/Arch-Linux-Config/
echo "copying xinitrc"
cp ~/.xinitrc ~/Dropbox/Arch-Linux-Config/


echo "Commiting to github"
cd ~/Dropbox/Arch-Linux-Config/
git add *
echo "commiting regular files"
git commit -m "adding regular files"
git add .*
echo "commiting hidden files"
git commit -m "adding hidden files"
git push

cd ~
echo "Backing up key configuration files is complete"



