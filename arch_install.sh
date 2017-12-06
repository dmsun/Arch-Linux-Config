#! /usr/bin/env bash
# to run:
# wget raw.githubusercontent.com/dmsun/Arch-Linux-Config/master/arch_install.sh
#chmod +x arch_install.sh
#./arch_install

#NOTE TO THE USER: ALWAYS VERIFY THE STEPS WITH THE ARCH LINUX WIKI
#TODO: Include checks and sections for UEFI install
#Prompt USER for Partition Scheme


PARTITIONS='
	size=512M, type=, bootable
	size=30G, type=
	type=
'
DISK="/dev/sda"
MIRROR="Australia"

NEW_GROUPS=(wheel)
NEW_USERNAME="mj"

HOSTNAME="dauphine"
TIMEZONE="Australia/Sydney"

LOCALE="en_AU.utf-8"

USERNAME="mj"

#define passwds

while true; do
	read -s -p "Root password:  " PASSWORD
	echo
	read -s -p "Confirm password:  " PASSWORD2
	echo
	[ "$PASSWORD" = "$PASSWORD2" ] && break
	echo "Passwords don't match. Try again"
done

#PARTITION the disk
#TODO - auto update this with user entry
echo "Formatting the drives for install"
fdisk /dev/sda

echo "Creating the file system"
mkfs.ext4 /dev/sda1	#boot BIOS
mkfs.ext4 /dev/sda2	#root
mkfs.ext4 /dev/sda3	#home

echo "Mounting the partitions"
mount /dev/sda2 /mnt/	#root
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
mkdir /mnt/home
mount /dev/sda3 /mnt/home

#Check the internet
echo "Checking the internet connection"
ping www.google.com

#Update pacman
echo "Updating pacman"
pacman -Syu

#Update system clock
echo "Setting the time to ntp"
timedatectl set-ntp true

#Re-arranging entries in Mirrorlist
echo "Re-arranging the Mirrorlist for Australia"
vim /etc/pacman.d/mirrorlist \
'+5' '+read ! echo' \
'+r ! grep "'"${MIRROR}"'" -A 1 % | grep -v "^--"' \
'+wq'

#Install the Base system
echo "Installing the base system"
local CORE_PACKAGES="base base-devel grub openssh ntp wget neovim iw wpa_supplicant dialog wireless_tools"
pacman-key --refresh-keys
pacstrap /mnt/ ${CORE_PACKAGES}
genfstab

#Change root into system
echo "Changing root into the newly installed system"
arch-chroot /mnt/

#Core Configuration
echo "Configuring the timezone"
ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime
hwclock --systohc #assumes HW clock is set to UTC

#Setting up the locale information
echo "Configuring the locale.gen and default Language"
sed -i 's/^#en_AU\.UTF/en_AU\.UTF/' /etc/locale.gen
locale-gen
echo "LANG=${LOCALE}" > /etc/locale.conf

#Change root password
echo "Enter in the root password below"
echo "root:$PASSWORD" | chpasswd

#Add users
echo "Adding default users to wheel group with bash shell"
useradd -m -G wheel -s /bin/bash $USERNAME
echo "Changing the username passwords"
echo $USERNAME:$PASSWORD | chpasswd

#Installing Grub for a bootloader
echo "Installing and configuring GRUB"
grub-install --target=i386-pc ${DISK}
grub-mkconfig -o /boot/grub/grub.cfg

#Updating the SUDOERS file to uncomment %wheel ALL=(ALL) ALL" from sudoers
echo "Updating the SUDOERS file"
sed -i 's/^#\s*\(%wheel\s*ALL=(ALL)\s*NOPASSWD:\s*ALL\)/\1/' /etc/sudoers

#Adding Neo-Vim environment variable and changing the default editor
echo "Setting Neo-vim to be the default Editor"
echo -e 'EDITOR=nvim' > /etc/environment

#Setting the Hostname
echo "Changing the hostname file"
echo "$HOSTNAME" > /etc/hostname

#SYSTEMCTL setup
echo "Enabling ssh, dhcpcd, and ntpd"
systemctl enable sshd.service
systemctl enable dhcpcd.service
systemctl enable ntpd.service

#exit chroot
echo "Exiting Chroot"
exit

#unmount disks
echo "Unmounting disks"
umount /mnt/boot
umount /mnt

echo "Ready to reboot"



