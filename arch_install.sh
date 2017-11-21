#! /usr/bin/env bash
# to run:
# wget raw.githubusercontent.com/dmsun/Arch-Linux-Config/master/arch_install.sh
#chmod +x arch_install.sh
#./arch_install

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

USERPACKAGES="gnome"
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
#THIS WILL BE MANUAL
fdisk /dev/sda

mkfs.ext4 /dev/sda1	#boot BIOS
mkfs.ext4 /dev/sda2	#root
mkfs.ext4 /dev/sda3	#home

mount /dev/sda2 /mnt/	#root
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
mkdir /mnt/home
mount /dev/sda3 /mnt/home


#Check the internet
ping www.google.com

#UPDATE pacman
pacman -Syu

#Update system clock
timedatectl set-ntp true

#INSTALL Base System

#MIRRORLIST re-arrange
vim /etc/pacman.d/mirrorlist \
'+5' '+read ! echo' \
'+r ! grep "'"${MIRROR}"'" -A 1 % | grep -v "^--"' \
'+wq'

local CORE_PACKAGES="base base-devel grub openssh sudo ntp wget neovim iw wpa_supplicant dialog wireless_toolsq"
pacman-key --refresh-keys
pacstrap /mnt/ ${CORE_PACKAGES}
genfstab -U /mnt/ >> /mnt/etc/fstab

#CHROOT into system
arch-chroot /mnt/

#CORE Configuration
ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime
hwclock --systohc #assumes HW clock is set to UTC

#LOCALE Setup
sed -i 's/^#en_AU\.UTF/en_AU\.UTF/' /etc/locale.gen

#Generate the locale
locale-gen
echo "LANG=${LOCALE}" > /etc/locale.conf

#ROOT password
echo "root:$PASSWORD" | chpasswd

#USERS add
useradd -m -G wheel -s /bin/bash $USERNAME
echo $USERNAME:$PASSWORD | chpasswd

#BOOTLOADER Grub install
grub-install --target=i386-pc ${DISK}
grub-mkconfig -o /boot/grub/grub.cfg

#SUDOERS uncomment %wheel ALL=(ALL) ALL" from sudoers
sed -i 's/^#\s*\(%wheel\s*ALL=(ALL)\s*NOPASSWD:\s*ALL\)/\1/' /etc/sudoers

#VIM EDITOR Environment Variable
echo -e 'EDITOR=nvim' > /etc/environment

#HOSTNAME set
echo "$HOSTNAME" > /etc/hostname

#SYSTEMCTL
systemctl enable sshd.service
systemctl enable dhcpcd.service
systemctl enable ntpd.service

#exit chroot
exit

#unmount disks
umount /mnt/boot
umount /mnt

echo "Ready to reboot"



