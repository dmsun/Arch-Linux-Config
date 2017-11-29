#! /usr/bin/env bash
# to run:
# wget raw.githubusercontent.com/dmsun/Arch-Linux-Config/master/arch_build.sh
#chmod +x arch_build.sh
#./arch_build

#BASH
BASH=bash-completion

#GRAPHICS
#this will depend on your build, if you're using an AMD gpu, use AMDGPU. Try lspci | grep -e VGA -e 3D

GRAPHICS_NVIDIA="nvidia nvidia-utils lib32-nvidia-utils nvidia-settings opencl-nvidia ocl-icd vulkan-icd-loader"
GRAPHICS_AMD="mesa lib32-mesa amdgpu xf86-video-amdgpu opencl-nvidia opencl-mesa ocl-icd vulkan-radeon vulkan-icd-loader"

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
MEDIA="vlc kodi"

#GAMES
STEAM="steam"
LINUX_GAMES="openra supertuxkart"
EMULATORS="ppsspp dolphin-emu"
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
		sudo pacman -Syu ${GRAPHIC_AMD}
    ;;
    * )
        echo "You have selected NVIDIA"
		sudo pacman -Syu ${GRAPHIC_NVIDIA}
    ;;
esac

echo "Installing Xserver features"
sudo pacman -Syu ${XSERV}
echo "Installing the required Gnome Desktop environment"
sudo pacman -Syu ${GNOME}
echo "Installing the required Gnome Extra packages"
sudo pacman -Syu ${GNOME_EXTRA}
echo "Installing Libre Office"
sudo pacman -Syu ${OFFICE}
echo "Installing Chromium web browser"
sudo pacman -Syu ${CHROME}
echo "Installing VLC and Kodi for Media"
sudo pacman -Syu ${MEDIA}

#installing games can be done through Lutris
echo "Installing Steam"
sudo pacman -Syu ${STEAM}

#begin install of AUR
read -p "Do you want to install AUR packages (y/n)? " answer
case ${answer:0:1} in
    y|Y )
        echo "You have Yes - being the install of AUR"
		echo "Setting up and installing the Arch User Repository"
		/.aur_setup.sh
		
		echo "Installing AUR packages"
		pacaur -Syu ${AUR}
		echo "Installing AUR fonts and Icons"
		pacaur -Syu ${AUR_FONTS}
		echo "Installing AUR Games"
		pacaur -Syu ${AUR_GAMES}
    ;;
    * )
        echo "You have select No - do not install AUR"
    ;;
esac

echo "Ready to reboot"










