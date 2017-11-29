#! /usr/bin/env bash
# to run:
# wget raw.githubusercontent.com/dmsun/Arch-Linux-Config/master/arch_build.sh
#chmod +x arch_build.sh
#./arch_build

#BASH
BASH=bash-completion

#GRAPHICS
#this will depend on your build, if you're using an AMD gpu, use AMDGPU.
# try lspci | grep -e VGA -e 3D
GRAPHICS_NVIDIA="nvidia nvidia-utils lib32-nvidia-utils nvidia-settings opencl-nvidia ocl-icd vulkan-icd-loader"
GRAPHICS_AMD="mesa lib32-mesa amdgpu xf86-video-amdgpu opencl-nvidia ocl-icd vulkan-radeon"

#SOUND
SOUND="alsa-firmware alsa-tools alsa-utils pulseaudio pulseaudio-bluetooth pulseaudio-equalizer pulseaudio-gconf pulseaudio-jack"

#UTILITIES
UTIL="openssh rsync samba transmission-gtk unrar wireless_tools gparted gzip htop imagemagick bzip2 deepin-screenshot ecm-tools"

#FONTS
AUR_FONTS="ttf-ms-fonts numix-circle-icon-theme-git numix-gtk-theme-git numix-icon-theme-git paper-gtk-theme-git paper-icon-theme"

#XSERVER
XSERV="xorg-server xorg-twm xorg-xclock xorg-xinit"

#GNOME
GNOME="gdm gnome-backgrounds gnome-themes-standard networkmanager nautilus mousetweaks awaita-icon-theme"
GNOME_EXTRA="evolution gnome-calendar gnome-photos gnome-tweak-tool dconf-editor brasero"

#OFFICE
OFFICE=libreoffice-fresh 

#WEBBROWSER
CHROME="chrome-gnome-shell-git chromium"

#MEDIA
MEDIA="vlc deepin-screenshot kodi"

#GAMES
GAMES="openra dolphin-emu ppsspp steam"
AUR_GAMES="gzdoom itch pcsx2-git"

#DATASCIENCE
DATA="opencv octave"
AUR_DATA=anaconda #maybedothismanually

#AUR
AUR="conky-colors-git conky-nvidia archey3 discord dropbox nautilus-dropbox nautilus-admin rednotebook spotify tilix whatsapp-desktop discord"

#Install groups line by line in order to minimise clashes with dependencies.
sudo pacman -Syu ${BASH}
sudo pacman -Syu ${UTIL}
sudo pacman -Syu ${SOUND}

read -p "Is your GPU AMD or NVIDIA (AMD/NVIDIA)? " answer
case ${answer:0:1} in
    a|A )
        echo "You have selected AMD"
    ;;
    * )
        echo "You have selected NVIDIA"
    ;;
esac




