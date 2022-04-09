#!/bin/bash

ln -sf /usr/share/zoneinfo/Europe/Bucharest /etc/localtime
hwclock --systohc
sed -i -e 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' -e 's/#ro_RO.UTF-8 UTF-8/ro_RO.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=us" >> /etc/vconsole.conf
echo "archlinux" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "192.168.0.105 archlinux.local archlinux" >> /etc/hosts
echo root:password | chpasswd

useradd -m sitram
echo sitram:password | chpasswd
usermod -aG wheel sitram

echo "sitram ALL=(ALL) ALL" >> /etc/sudoers.d/sitram

#Update pacman miror list
sudo pacman -S reflector rsync
sudo reflector -c Romania -a 6 --sort rate --save /etc/pacman.d/mirrorlist

#enable multilib repository
#  : introduces a label. 
#  b branches to a label.
#  $! is an address that matches all but the last line. 
#  :a;N;$!ba; is a loop which joins lines (using N) until it gets to the last line.
sed -i ':a;N;$!ba;s/\#\[multilib\]\n#/\[multilib\]\n/' /etc/pacman.conf
sudo pacman -Syyy

sudo pacman -S grub os-prober network-manager base-devel linux-headers nfs-utils bash-completition xdg-user-dirs xdg-utils openssh reflector rsync
sudo pacman -S xorg-server lightdm lightdm-webkit2-greeter lightdm-gtk-greeter-settings cinnamon metacity gnome-terminal gnome-keyring
sudo pacman -S pipewire pipewire-alsa pipewire-pulse pipewire-jack alsa-utils flameshot network-manager-applet blueberry system-config-printer libreoffice thunar okular qalculate-gtk gimp nomacs vlc shotcut handbrake nvidia nvidia-settings archlinux-wallpaper wine wine-gecko wine-mono steam papirus-icon-theme arc-gtk-theme spice-vdagent gvfs gvfs-smb

grub-install --target=i386-pc /dev/sdX # replace sdx with your disk name, not the partition
grub-mkconfig -o /boot/grub/grub.cfg

echo "192.168.0.114:/mnt/tank1/data /home/sitram/mounts/data nfs rw 0 0" >> /etc/fstab
echo "192.168.0.114:/mnt/tank2/media /home/sitram/mounts/media nfs rw 0 0" >> /etc/fstab

sudo systemctl enable NetworkManager
sudo systemctl enable lightdm
sudo systemctl enable bluetooth
sudo systemctl enable sshd
sudo systemctl enable reflector.timer
sudo systemctl enable acpid
 
cd /tmp
git clone https://aur.archlinux.org/yay-git.git
cd yay-git
makepkg -si
cd /
sudo rm -r /tmp/yay-git

printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"

