#!/bin/bash

ln -sf /usr/share/zoneinfo/America/Montreal /etc/localtime
hwclock --systohc
sed -i '177s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "lappy" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 lappy.localdomain lappy" >> /etc/hosts
echo root:4256 | chpasswd

# You can add xorg to the installation packages, I usually add it at the DE or WM install script
# You can remove the tlp package if you are installing on a desktop or vm

pacman -S grub efibootmgr networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools base-devel linux-headers xdg-user-dirs xdg-utils inetutils dnsutils alsa-utils os-prober ntfs-3g nvidia nvidia-utils nvidia-settings

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable tlp 

useradd -m lukas
echo alu:4256 | chpasswd

echo "lukas ALL=(ALL) ALL" >> /etc/sudoers.d/alu


printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
