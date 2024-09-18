# ArchLinux - Desktop VM

## ArchLinux - VM configuration

- VM id: 151
- HDD: 60GB
- Sockets: 1
- Cores: 30
- RAM:
  - Min: 2048
  - Max: 32768
  - Ballooning Devices: enabled
- Machine: i440fx
- Audio Device
  - Audio Device: AC97
  - Backend Driver: SPICE
- Network
  - LAN MAC address: 92:4B:CC:81:96:83
  - Static ip assigned in pfSense: 192.168.0.105
  - Local domain record in piHole: archlinux .local
- Options:
  - Start at boot: enabled
  - QEMU Guest Agent: enabled, guest trim
  - SPICE Enhancements:
    - Folder Sharing: enabled
    - Video Streaming: off
- OS: [ArchLinux](https://archlinux.org/)

## ArchLinux - OS Configuration

### Configure wireless network access

Install iNet Wireless daemon and set a delay for iwd service start

```bash
sudo pacman -S iwd
sudo systemctl enable iwd
sudo systemctl edit iwd
#add the following text
[Service]
ExecStartPre=sleep 3
```

### Base software installation

Enable multilib repository by uncommenting the `[multilib]` section in `/etc/pacman.conf`:

```bash
/etc/pacman.conf
[multilib]
Include = /etc/pacman.d/mirrorlist
```

Update pacman mirror list with the servers that were checked maximum 6 hours ago, sorted by speed for Romania and save it to a file

```bash
sudo pacman -S reflector rsync
sudo reflector -c Romania -a 6 --sort rate --save /etc/pacman.d/mirrorlist
```

Refresh the servers

```bash
sudo pacman -Syyy
```

Base software installation after running `arch-chroot`

- **GRUB bootloader**: grub
- **OS Prober**: os-prober
- **Program for detection and configuration of networks**: network-manager
- **Packages used for building apps**: base-devel linux-headers
- **utils for accesing nfs shares**: nfs-utils
- **bash auto completion**: bash-completion
- **tool to help manage "well knownw" directories**: xdg-user-dirs
- **utilities for managing default applications**: xdg-utils
- **ssh server**: openssh
- **reflector**: reflector
- **git**: git
- **rsync**: rsync
- **Daemon for delivering ACPI events**: acpi acpi_call
- **Scripts and tools for pacman**: pacman-contrib
- **A directory listing program**: tree
- **System for distributing Linux Sandboxed apps**: flatpak
- **Network monitoring tool**: iftop
- **Containerization software**: docker
- **Interactive process viewer**: htop
- **CLI system information tool for terminal**: neofetch
- **DOS filesystem utilities**: dosfstools
- **NTFS filesystem driver and utilities**: ntfs-3g

```bash
sudo pacman -S grub os-prober network-manager base-devel linux-headers nfs-utils bash-completition xdg-user-dirs xdg-utils openssh reflector rsync acpi acpi_call pacman-contrib tree flatpak iftop docker htop neofetch dosfstools ntfs-3g
```

### Configure local network mounts

Add the following mounting points to `/etc/fstab/`

```bash
192.168.0.114:/mnt/tank1/data /home/sitram/mounts/data nfs defaults,auto 0 0
192.168.0.114:/mnt/tank2/media /home/sitram/mounts/media nfs defaults,auto 0 0
```

### Install AUR Helper

Install yay AUR Helper

```bash
sudo pacman -S git
sudo pacman -S --needed base-devel 
cd /tmp
git clone https://aur.archlinux.org/yay-git.git
cd yay-git
makepkg -si
cd /
sudo rm -r /tmp/yay-git
```

### Desktop environment installation(Cinnamon)

Uninstall graphics driver for intel because it interferes with cinnamon

```bash
sudo pacman -R xf86-video-intel
```

Disable bluetooth service and remove the existing package

```bash
sudo systemctl disable bluetooth
sudo pacman -R bluez bluez-utils pulseaudio-bluetooth
```

- **display server**: xorg-server
- **display manager**: lightdm
- **greeter**: lightdm-webkit2-greeter lightdm-gtk-greeter lightdm-pantheon-greeter lightdm-slick-greeter
- **greeter settings editor**: lightdm-gtk-greeter-settings
- **desktop environment**: cinnamon
- **window manager(used by cinnamon as fallback in case cinnamon fails)**: metacity
- **terminal(cinnamon doesn't come with one)**: gnome-terminal
- **password manager**: gnome-keyring

```bash
sudo pacman -S xorg-server lightdm lightdm-webkit2-greeter lightdm-gtk-greeter lightdm-pantheon-greeter lightdm-slick-greeter lightdm-gtk-greeter-settings cinnamon metacity gnome-terminal gnome-keyring
```

Configuration:

- **Icons Theme***: Papirus-Dark
- **Applications Theme**: Mint-Y-Dark-Blue
- **Mouse pointer Theme**: Adwaita
- **Desktop Theme**: Mint-Y-Dark-Blue
- **Default Font**: Cantarell Regular 9
- **Desktop font**: Cantarell Regular 10
- **Document Font**: Cantarell Regular 11
- **Monospace font**: Source Code Pro Regular 10
- **Window title font**: Cantarell Regular 10

### Desktop environment installation(Gnome)

- **display server**: xorg-server
- **display manager**: gdm
- **greeter**: lightdm-webkit2-greeter lightdm-gtk-greeter lightdm-slick-greeter lightdm-slick-greeter
- **greeter settings editor**: lightdm-gtk-greeter-settings
- **desktop environment**: gnome
- **window manager(used by cinnamon as fallback in case cinnamon fails)**: metacity

```bash
sudo pacman -S xorg-server gdm lightdm-webkit2-greeter lightdm-gtk-greeter lightdm-pantheon-greeter lightdm-slick-greeter lightdm-gtk-greeter-settings gnome metacity
```

### Desktop environment installation(KDE)

- **display server**: xorg-server
- **display manager**: lightdm
- **greeter**: lightdm-webkit2-greeter lightdm-gtk-greeter lightdm-slick-greeter lightdm-slick-greeter
- **greeter settings editor**: lightdm-gtk-greeter-settings
- **desktop environment**: plasma
- **terminal**: gnome-terminal
- **password manager**: gnome-keyring

```bash
sudo pacman -S xorg-server lightdm lightdm-webkit2-greeter lightdm-gtk-greeter lightdm-pantheon-greeter lightdm-slick-greeter lightdm-gtk-greeter-settings plasma gnome-terminal gnome-keyring
```

### Common apps for all desktop environments

- **ALSA utilities**: alsa-utils
- **screenshot tool**: flameshot
- **CUPS printer configuration tool**: system-config-printer
- **NetworkManager applet**: network-manager-applet
- **bluetooth configuration tool**: blueberry
- **office suite**: libreoffice
- **file manager**: thunar
- **archive manager and plugins for Thunar**: file-roller thunar-archive-plugin thunar-volman thunar-media-tags-plugin
- **PDF viewer**: okular
- **calculator**: qalculate-gtk
- **image editor**: gimp
- **image viewer:** nomacs
- **video player**: smplayer-themes smplayer-skins smtube yt-dlp
- **video editing software**: shotcut
- **video transcoder software**: handbrake
- **wallpapers**: archlinux-wallpaper
- **wine**: wine
- **wine packages for applications that depend on Internet Explorer and .NET**: wine-geko wine-mono
- **wine libraries**: lib32-libpulse
- **steam**: steam
- **icons**: papirus-icon-theme
- **themes**: arc-gtk-theme
- **fonts for Bootstrap**: ttf-font-awesome
- **Spice agent xorg client that enables copy and paste between client and X-session and more**: spice-vdagent
- **Gnome virtual filesystems implementation**: gvfs
- **Windows File and printer sharing for Non-KDE desktops**: gvfs-smb
- **GUI system monitor**: gnome-system-monitor
- **Telegram - instant messaging system**: telegram-desktop
- **Utility to modify video**: v4l-utils
- **Live streaming and recording software**: obs-studio
- **Remote desktop client and plugins**: remmina spice-gtk freerdp
- **Linux tools for UDF filesystems and DVD/CD-R(W) drives**: udftools
- **Optimize Linux Laptop Battery Life**: tlp

```bash
sudo pacman -S alsa-utils flameshot network-manager-applet blueberry system-config-printer libreoffice thunar file-roller thunar-archive-plugin thunar-volman thunar-media-tags-plugin okular qalculate-gtk gimp nomacs smplayer-themes smplayer-skins smtube yt-dlp shotcut handbrake archlinux-wallpaper wine wine-gecko wine-mono lib32-libpulse steam papirus-icon-theme arc-gtk-theme arc-gtk-theme spice-vdagent gvfs gvfs-smb gnome-system-monitor telegram-desktop v4l-utils obs-studio remmina spice-gtk freerdp udftools tlp
```

### Configure NVIDIA drivers

Install NVIDIA drivers

```bash
sudo pacman -S nvidia nvidia-settings nvidia-prime nvidia-utils xorg-xrandr
```

Since Nvidia does not support automatic KMS loading, enabling DRM(Direct Rendering Manager) kernel mode setting is requiered.

Edit `/etc/default/grub` and append the existing kernel options between the quotes in the `GRUB_CMDLINE_LINUX_DEFAULT` line the following parameter:

```bash
GRUB_CMDLINE_LINUX_DEFAULT="nvidia-drm.modeset=1"
```

Re-generate the `grub.cfg` file with:

```bash
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

Configure early loading of nvidia modules by adding them to the initramfs

Edit `/etc/mkinitcpio.conf` and add under `MODULES` option the following:

```bash
MODULES=(nvidia)
```

Regenerate initramfs images based on all existing presets:

```bash
sudo mkinitcpio -P
```

After adding the nvidia drivers to the initramfs, do not forget to run `mkinitcpio` every time there is a nvidia driver update. This process can be automated with the following pacman hook below.

```bash
sudo nano /etc/pacman.d/hooks/nvidia.hook
```

```bash
[Trigger]
Operation=Install
Operation=Upgrade
Operation=Remove
Type=Package
# Uncomment the installed NVIDIA package
Target=nvidia
#Target=nvidia-open
#Target=nvidia-lts
# If running a different kernel, modify below to match
Target=linux

[Action]
Description=Updating NVIDIA module in initcpio
Depends=mkinitcpio
When=PostTransaction
NeedsTargets
Exec=/bin/sh -c 'while read -r trg; do case $trg in linux*) exit 0; esac; done; /usr/bin/mkinitcpio -P'
```

### Configure LightDM and Xorg to use NVIDIA driver

NVIDIA driver can be configured to be the primary rendering provider.

Add the following lines to file `/etc/X11/xorg.conf.d/10-nvidia-drm-outputclass.conf`

```bash
Section "OutputClass"
    Identifier "intel"
    MatchDriver "i915"
    Driver "modesetting"
EndSection

Section "OutputClass"
    Identifier "nvidia"
    MatchDriver "nvidia-drm"
    Driver "nvidia"
    Option "AllowEmptyInitialConfiguration"
    Option "PrimaryGPU" "yes"
    ModulePath "/usr/lib/nvidia/xorg"
    ModulePath "/usr/lib/xorg/modules"
EndSection
```

After installing `lightdm`, the greeter can be configured by editing `lightdm.conf`. A list of all greeter-session installed on the system can be found by listing the contents of `/usr/share/xgreeters`

When NVIDIA is configured to be the primary rendering provider, I found out that `lightdm-slick-greeter` works ok and has a nice aestetichs.

```bash
sudo nano /etc/lightdm/lightdm.conf

# Select the installed greeter
greeter-session = lightdm-slick-greeter
#Change display output for VM's only
display-setup-script=xrandr --output Virtual-1 --mode 1920x1080
#For laptops with NVIDIA GPU
display-setup-script=/etc/lightdm/display_setup.sh
```

The script from `/etc/lightdm/display_setup.sh` is used to configure NVIDIA driver for lightdm. After adding the content below to the file, make the script executable with `sudo chmod +x display_setup.sh`. Make sure this configuration is done after NVIDIA drivers are installed and configured correctly. The name of the driver might vary and can be obtained by running `xrandr --listproviders`

```bash
#!/bin/sh
xrandr --setprovideroutputsource modesetting NVIDIA-G0
xrandr --auto
xrandr --output eDP-1-1 --primary
```

Restart `lightdm` service to activate the changes

```bash
sudo systemctl restart lightdm.service
```

### Configure PipeWire multimedia framework

Configure [PipeWire](https://wiki.archlinux.org/title/PipeWire) multimedia framework

- **Low-latency audio/video router and processor**: pipewire
- **ALSA configuration**: pipewire-alsa
- **PulseAudio replacement**: pipewire-pulse
- **Session and policy manager for PipeWire**: wireplumber
- **Audio effects for PipeWire applications**: easyeffects

```bash
sudo pacman -S pipewire pipewire-alsa pipewire-pulse wireplumber
yay -S easyeffects
```

Load extra modules

```bash
sudo touch /etc/pipewire/pipewire-pulse.conf.d/pipewire.conf
nano /etc/pipewire/pipewire-pulse.conf.d/pipewire.conf
```

add text

```bash
# Extra modules can be loaded here.
context.exec = [
    { path = "pactl"        args = "load-module module-switch-on-connect" }
]
```

### Configure PulseAudio multimedia framework

Configure [PulseAudio](https://wiki.archlinux.org/title/PulseAudio) multimedia framework

- **General-purpose sound server**: pulseaudio
- **ALSA Configuration for PulseAudio**: pulseaudio-alsa
- **Bluetooth support for PulseAudio**: pulseaudio-bluetooth
- **A GTK volume control for PulseAudio**: pacucontrol

```bash
sudo pacman -S pulseaudio pulseaudio-alsa pulseaudio-bluetooth
yay -S pavucontrol
```

### Common AUR packages

- **greeter theme**: lightdm-webkit-theme-aether
- **LightDM display manager configuration tool**: lightdm-settings
- **Google Chrome**: google-chrome
- **Zip archiver**: 7-zip
- **Visual Studio Code**: visual-studio-code-bin
- **Sublime text editor**: sublime-text-4
- **icons**: tela-icon-theme-git
- **themes**: mint-themes-git
- **Optimus Manager for systems with integrated and dedicated GPU + applet**: optimus-manager optimus-manager-qt
- **Teamviewer**: teamviewer
- **Nextcloud desktop client**: nextcloud-client
- **system information tool + helpers**: [archey4](https://github.com/HorlogeSkynet/archey4) virt-what dmidecode wmctrl pciutils lm_sensors
- **system restore utility**: timeshift
- **Pacman GUI**: pamac-aur
- **Snap**: snapd
- **InterractiveBrokers client**: ib-tws
- **Disk analyzer tool**: qdirstat
- **Microsoft fonts**: ttf-ms-win11-auto
- **Plex desktop client for Linux**: plex-desktop
- **Optional firmware for the default linux kernel to get rid of the annoying 'WARNING: Possibly missing firmware for module:' messages**: mkinitcpio-firmware

```bash
yay -S lightdm-webkit-theme-aether lightdm-settings google-chrome 7-zip visual-studio-code-bin sublime-text-4 tela-icon-theme mint-themes optimus-manager optimus-manager-qt teamviewer nextcloud-client archey4 virt-what dmidecode wmctrl pciutils lm_sensors timeshift snapd ib-tws qdirstat ttf-ms-win11-auto plex-desktop mkinitcpio-firmware
```

List AUR installed packages

```bash
pacman -Qm
```

### Post instalation services handling

Enable various services:

- **NetworkManager**
- **Display manager**
- **Bluetooth**
- **SSH server**
- **Reflector timer to update periodically the pacman mirrorlist**
- **Daemon for delivering ACPI events**
- **Qemu guest agent for VM's**
- **Systemd Network daemon**
- **Teamviewer daemon**
- **Optimus Manager daemon for switching between integrated and dedicated GPU**
- **Docker**

```bash
sudo systemctl enable NetworkManager
sudo systemctl enable lightdm
sudo systemctl enable bluetooth
sudo systemctl enable sshd
sudo systemctl enable reflector.timer
sudo systemctl enable tlp
sudo systemctl enable qemu-guest-agent
sudo systemctl enable systemd-networkd
sudo systemctl enable teamviewerd
sudo systemctl enable optimus-manager.service
sudo systemctl enable docker
```

Check what graphics driver is used with command `nvidia-smi`

Check all enabled services

```bash
sudo systemctl list-unit-files --state=enabled
```

## ArchLinux - Network configuration

## ArchLinux - systemd-networkd

## ArchLinux - NetworkManager

[NetworkManager](https://wiki.archlinux.org/title/NetworkManager) is a program for providing detection and configuration for systems to automatically connect to networks. NetworkManager's functionality can be useful for both wireless and wired networks. For wireless networks, NetworkManager prefers known wireless networks and has the ability to switch to the most reliable network. NetworkManager-aware applications can switch from online and offline mode. NetworkManager also prefers wired connections over wireless ones, has support for modem connections and certain types of VPN. NetworkManager was originally developed by Red Hat and now is hosted by the GNOME project.

NetworkManager can be installed with the following packages:

- `networkmanager` -  which contains a daemon, a command line interface (`nmcli`) and a curses‐based interface (`nmtui`)
- `nm-connection-editor` - agraphical user interface
- `network-manager-applet` - a system tray applet (nm-applet)
- `wpa_supplicant` - cross-platform suplicant for wireless connections

```bash
sudo pacman -S networkmanager wpa_supplicant nm-connection-editor network-manager-applet
sudo pacman -R iwd
sudo systemctl disable dhcpcd.service
sudo systemctl disable systemd-networkd.service
sudo systemctl disable iwd.service
sudo systemctl enable wpa_supplicant.service
sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager.service
sudo reboot
```

By default NetworkManager uses its internal DHCP client so make sure to disable the `dhcpd` service if it is installed on the system.

To change the DHCP client backend, set the option `main.dhcp=dhcp_client_name` with a configuration file in `/etc/NetworkManager/conf.d/`.

```bash
/etc/NetworkManager/conf.d/dhcp-client.conf
[main]
dhcp=dhclient
```

NetworkManager can use `systemd-resolved` as a DNS resolver and cache. Make sure that `systemd-resolved` is properly configured and that `systemd-resolved.service` is started before using it.

`systemd-resolved` will be used automatically if `/etc/resolv.conf` is a symlink to `/run/systemd/resolve/stub-resolv.conf`, `/run/systemd/resolve/resolv.conf` or `/usr/lib/systemd/resolv.conf.`

You can enable it explicitly by setting `main.dns=systemd-resolved` with a configuration file in `/etc/NetworkManager/conf.d/`

```bash
/etc/NetworkManager/conf.d/dns.conf
[main]
dns=systemd-resolved
```

Interactive UI manager of NetworkManager can be launched with `nmtui`.

NetworkManager can also be configured to run a script on network status change.

The following script safely unmounts the NFS shares before the relevant network connection is disabled by listening for the down, pre-down and vpn-pre-down events, make sure the script is executable - `/etc/NetworkManager/dispatcher.d/30-nfs.sh`

```bash
#!/bin/sh

# Find the connection UUID with "nmcli con show" in terminal.
# All NetworkManager connection types are supported: wireless, VPN, wired...
WIRED_UUID="4e4a9c21-50d1-3475-ab43-09f582b5ba10"
WIRELESS_ADI_UUID="1bde9f13-565d-4253-84e2-c4538464345d"
WIRELESS_ADI5G_UUID="eb7e84c3-07e2-4900-86d0-483b75ad4be8"

if [ "$CONNECTION_UUID" = "$WIRED_UUID" ] || [ "$CONNECTION_UUID" = "$WIRELESS_ADI_UUID" ] || [ "$CONNECTION_UUID" = "$WIRELESS_ADI5G_UUID" ]; then
    
    # Script parameter $1: network interface name, not used
    # Script parameter $2: dispatched event
    
    case "$2" in
        "up")
            mount -a -t nfs4,nfs 
            ;;
        "down"|"pre-down"|"vpn-pre-down")
            umount -l -a -t nfs4,nfs -f >/dev/null
            ;;
    esac
fi
```

In order to turn Wi-Fi on when the LAN cable is unplugged (for example when detaching from a laptop dock), and for Wi-Fi to be automatically disabled, once a LAN cable is plugged in again, create the following dispatcher scripy, replacing `LAN_interface` with the name assigned to the wired interface. The name can be obtained using `nmcli`. The Ethernet (LAN) interfaces start with `en`, e.g. `enp0s5`

```bash
/etc/NetworkManager/dispatcher.d/wlan_auto_toggle.sh

#!/bin/sh

if [ "$1" = "LAN_interface" ]; then
    case "$2" in
        up)
            nmcli radio wifi off
            ;;
        down)
            nmcli radio wifi on
            ;;
    esac
elif [ "$(nmcli -g GENERAL.STATE device show LAN_interface)" = "20 (unavailable)" ]; then
    nmcli radio wifi on
fi
```

## ArchLinux - Troubleshoot sound issues

```bash
dmesg | grep snd
#FWIW to properly debug pulse
systemctl --user mask pulseaudio.socket
pulseaudio -k
pulseaudio -vvv
systemctl --user mask pulseaudio.socket
```

## ArchLinux - I3 installation & Customization

Installing the needed packages

- **Display manager**: i3-wm
- **Lockscreen for I3**: i3lock
- **i3 Status bar**: i3status
- **i3 blocks**: i3blocks
- **compositor**: picom
- **theme swtcher**: lxappearance
- **run menu for the programs**: dmenu
- **font**: ttf-ubuntu-font-family
- **terminal**: terminator
- **image viewer that can be use to manage wallpapers**: feh
- **GUI for xrandr to set resolution**: arandr
- **dmenu replacement**: rofi
- **automatically turn numlock on**: numlockx

```bash
sudo pacman -S i3-wm i3lock i3status i3blocks picom lxappearance dmenu ttf-ubuntu-font-family terminator feh arandr rofi numlockx
```

Keyboard shortcuts:

- **Open new terminal**: $mod+Enter
- **Open dmenu**: $mod+d
- **Close window**: $mod+Shift+q

---

- **Switch workspace**: $mod+num

---

- **Open next window vertically**: $mod+v
- **Open next window horizontally**: $mod+h

---

- **Stacked mode**: $mod+s
- **Tabbed mode**: $mod+w
- **Slpith/slpitv mode**: $mod+e
- **Full screen toggling**: $mod+f

---

- **Restart i3**: $mod+Shift+r
- **Move left**: $mod+j / $mod+left
- **Move down**: $mod+k / $mod+down
- **Move up**: $mod+l / $mod+up
- **Move right**: $mod+; / $mod+right

---

- **Move window left**: $mod+Shift+j / $mod+Shift+left
- **Move window down**: $mod+Shift+k / $mod+Shift+down
- **Move window up**: $mod+Shift+l / $mod+Shift+up
- **Move window right**: $mod+Shift+; / $mod+Shift+right

---

- **Move window to a workspace**: $mod+Shift+num

---

- **Restart i3 in place**: $mod+Shift+r
- **Exit i3**: $mod+Shift+e

---

I3 configuration file is located in `~/.config/i3/config`

Changes in order to use i3status bar configuration from home folder

```bash
mkdir ~/.config/i3status
sudo cp /etc/i3status.conf ~/.config/i3status/i3status.conf
sudo chown sitram:sitram ~/.config/i3status/i3status.conf
```

In order to change system wide theme and fonts, `lxappearance` is used.

Polybar instalation and configuration

```bash
yay -S polybar
```

## ArchLinux - ZSH shell

Zsh (The Z shell) is an Unix shell that can be used as an interactive login shell and as a command interpreter for shell scripting. Zsh is an extended Bourne shell with many improvements, including some features from Bash, ksh, and tcsh.

Install the shell

```bash
sudo pacman -S zsh zsh-completions
```

Set Zsh as default shell and open again the terminal

```bash
chsh -s /usr/bin/zsh
```

Install [oh my zsh](https://github.com/ohmyzsh/ohmyzsh) using curl

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Chose a fancy theme like agnoster and install the fonts used by it

```bash
sudo pacman -S powerline-fonts
```

Edit `~/.zshrc` file and change parameter `ZSH_THEME="agnoster"`. Restart the terminal to load the new theme

Install [Powerlevel10k](https://github.com/romkatv/powerlevel10k) theme and the required font

```bash
yay -S ttf-meslo-nerd-font-powerlevel10k zsh-theme-powerlevel10k-git
```

Edit `~/.zshrc` file and add line `source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme` at the end

After terminal is restarted, the configuration for PowerLevel10k theme is started atuomatically. This can be triggered later on by running the following command:

```bash
p10k configure
```

Edit `~/.zshrc` file and add the following plugins:

- [git](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git)
- [web-search](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/web-search)
- [history](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/history)
- [sudo](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/sudo)

```bash
plugins=(git web-search history sudo)
```

## ArchLinux - Downgrade packages

When using a rolling distro like Arch, sometimes things break when updating packages to newer version. When this happens there are several ways to perform a downgrade

### ArchLinux - Using pacman cache

If a package was installed at an earlier stage, and the pacman cache was not cleaned, an earlier version from `/var/cache/pacman/pkg/` can be installed.

This process will remove the current package and install the older version. Dependency changes will be handled, but pacman will not handle version conflicts. If a library or other package needs to be downgraded with the packages, please be aware that you will have to downgrade this package yourself as well.

```bash
pacman -U /var/cache/pacman/pkg/package-old_version.pkg.tar.zst
```

`old_version` could be something like `x.y.z-x86_64` where the last part is the architecture for which the package is installed.

### ArchLinux - Using Arch Linux archive

The [Arch Linux Archive](https://wiki.archlinux.org/title/Arch_Linux_Archive) is a daily snapshot of the official repositories. It can be used to install a previous package version, or restore the system to an earlier date.

```bash
pacman -U https://archive.archlinux.org/packages/path/package-old_version.pkg.tar.zst
```

### ArchLinux - Restore system to an earlier date

To restore all packages to their version at a specific date, let us say 30 March 2014, you have to direct pacman to this date, by replacing your `/etc/pacman.d/mirrorlist` with the following content:

```bash
#                                                                              
# Arch Linux repository mirrorlist                                             
# Generated on 2042-01-01                                                      
#
Server=https://archive.archlinux.org/repos/2014/03/30/$repo/os/$arch
```

Update the database and force downgrade:

```bash
pacman -Syyuu
```

If you get errors complaining about corrupted/invalid packages due to PGP signature, try to first update separately `archlinux-keyring` and `ca-certificates`.

## ArchLinux - Connect Android To Arch Linux Via USB

Install Android studio

```bash
yay -S android-studio
```

Enable MTP(Media Transfer Protocol) support by installing

```bash
sudo pacman -S mtpfs
```

For devices running Android 4+, this should do the trick. However, on later versions, we would need another package called `jmtpfs` from AUR repository:

```bash
yay -S jmtpfs
```

At this point, we have MTP enabled. However, it would still not be visible in your File Manager as it is not auto-mounted as we desire. To auto mount it, we need to install a package with:

```bash
sudo pacman -S gvfs-mtp
```

PTP stands for “Picture Transfer Protocol” and infact is the protocol on which MTP is based. When you communicate with your Android phone via PTP, it appears as a digital camera to your PC.

```bash
sudo pacman -Sy gvfs-gphoto2
```

Finally, for the changes to take effect, reboot the system

```bash
sudo reboot now
```

## ArchLinux - Rebuild AUR packages when python is upgraded

Whenever `Python` upgrades it's major version in [core](https://archlinux.org/packages/core/x86_64/python/), Python packages installed from AUR might need to be rebuild.

To get a list of them, you can run:

```bash
pacman -Qoq /usr/lib/python3.xx
```

And to rebuild them all at once with an AUR helper such as yay, you can do:

```bash
yay -S $(pacman -Qoq /usr/lib/python3.xx) --answerclean All
```

If any of the packages don't work with Python 3.xx yet, this might fail halfway through and they might need to be rebuild manually one at a time.

### ArchLinux - Brother printer & scanner

CUPS is the standards-based, open source printing system developed by OpenPrinting for Linux.

Install CUPS and start it automatically system-wide.

```bash
sudo pacman -S cups

sudo systemctl enable cups
sudo systemctl enable cups.socket
sudo systemctl start cups
```

For the HomeLab I chose [Brother MFC-L2732DW](https://support.brother.com/g/b/spec.aspx?c=eu_ot&lang=en&prod=mfcl2732dw_eu) monochrome laser printer with scanner and fax functionality. The reason I chose this printer is because Brother is a very reliable brand and it's quite cheap to refill the drum with tonner.

In order to use the printer, the driver needs to be installed. The AUR package for mfc-l2732dw model doesn't work and since the driver is the same as for mfc-l2730dw model, I chose to install this one.

```bash
yay -S brother-mfc-l2730dw
```

Configure the printer in `CUPS`:

- Open `CUPS` by searching for `Manage printing` in your desktop environment or going to [http://localhost:631/](http://localhost:631/)
- Open the tab `Administration` an press `Add Printer` button
- Select the printer for which the drivers were installed for from `Discovered Network Printers` option
- Configure the name and sharing settings
- Select the name of the printer in `Model` list, and click `Add Printer`

Now the printer should be configured and it can be tested by printing a test page and some random text or image from web.

In order to use the scanner functionality of the device, the corresponding driver has to be installed. There are multiple `brscan` packages in AUR and for the model I chose, `brscan4` contains the correct driver.

```bash
yay -S brscan4
```

For network scanners, Brother provides a different configuration tool for each `brscan` version which has to be run with the name, model and the ip specific for the scanner

```bash
sudo brsaneconfig4 -a name="Scanner" model="MFC-L2732DW" ip=192.168.0.233
```

Brother has released a tool to enable scanning to be triggered by user interaction with the scanner itself (e.g., by selecting one of `Scan to email`, `Scan to image`, etc. on the scanner's keypad) rather than by an attached computer. This can be set up by installing the `brscan-skey` package and starting `brscan-skey.service` using `systemd`.

Brother supplies some default scripts that are executed when a scan type is selected on the keypad. For all options apart from "Scan to email" the resulting output can be found inside `$HOME/brscan`, with `$HOME` the home directory of the user running this tool (so `/srv/brscan-skey` if started via systemd as a systemwide process).

```bash
yay -S brscan-skey

systemctl enable brscan-skey.service
systemctl start brscan-skey.service
```

SANE provides a library and a command-line tool to use the scanner functionality of the printer under Linux.

For a GUI frontend the following two options will be installed

- [Simple Scan](https://gitlab.gnome.org/GNOME/simple-scan) — Simplified GUI that is intended to be easier to use and better integrated into the GNOME desktop than XSane.
- [XSane](http://www.xsane.org/) — Full-featured GTK-based frontend, looking a bit old but providing extended functionalities.

```bash
sudo pacman -S sane xsane xsane-gimp simple-scan
```

### ArchLinux - Chrome Remote Desktop

1. Build and install the package from AUR with `yay -S chrome-remote-deskttop`
2. run crd --setup
3. (Optional) Configure execution of your preferred window manager in ~/.chrome-remote-desktop-session
4. Go to [http://remotedesktop.google.com/headless](http://remotedesktop.google.com/headless)
5. Click "next" and "authorize" through each instruction
6. Copy/paste and run the provided "Debian" command, which should look like the following: `DISPLAY= /opt/google/chrome-remote-desktop/start-host --code="<UNIQUE_CODE>" --redirect-url="<https://remotedesktop.google.com/_/oauthredirect>" --name=`
7. Set up a name and PIN
8. Wait for successful output containing `"Host ready to receive connections."`
9. Run `crd --start`

More details can be found on Victor Mendonca's [blog](https://blog.victormendonca.com/2020/04/02/how-to-install-chrome-remote-desktop-on-arch/). Please keep in mind that these instructions might get outdated so be prepared for some troubleshooting in case some of the instructions don't apoply anymore.

#### ArchLinux - Chrome Remote Desktop - newer version issue

In case of a version missmatch error, run the following command to get the latest version of `chrome-remote-desktop`

```bash
curl -qs https://dl.google.com/linux/chrome-remote-desktop/deb/dists/stable/main/binary-amd64/Packages | grep "^Version\|^SHA256" | awk '{print $2}'
```

Edit `~/.cache/yay/chrome-remote-desktop/PKGBUILD` and modify `pkgver` with the newest version.

Build and install the package locally without checking the checksums `~/.cache/yay/chrome-remote-desktop/makepkg -si --skipchecksums`

Resume configuration from point 2 in [ArchLinux - Chrome Remote Desktop](#archlinux---chrome-remote-desktop)

#### ArchLinux - Chrome Remote Desktop - missing json file

In case `systemctl --user status chrome-remote-desktop` shows an error related to missing `.json` file in `/home/<username>/.config/chrome-remote-desktop/host#*.json`, try adding your user to `chrome-remote-desktop` with

```bash
usermod -aG chrome-remote-desktop $USER
```

#### ArchLinux - Chrome Remote Desktop - invalid escape sequence '\s'

In case `systemctl --user status chrome-remote-desktop` shows an error related to `invalid escape sequence '\s'`, try the next fix.

```bash
systemd[1469]: Starting "Chrome Remote Desktop host daemon"...
crd[276834]: /opt/google/chrome-remote-desktop/chrome-remote-desktop:2529: SyntaxWarning: invalid escape sequence '\s'
crd[276834]:   re.split('\s+', os.environ[HOST_EXTRA_PARAMS_ENV_VAR].strip())
pkexec[276835]: pam_unix(polkit-1:session): session opened for user root(uid=0) by sitram(uid=1000)
crd[276914]: /opt/google/chrome-remote-desktop/chrome-remote-desktop:2529: SyntaxWarning: invalid escape sequence '\s'
crd[276914]:   re.split('\s+', os.environ[HOST_EXTRA_PARAMS_ENV_VAR].strip())
crd[276914]: Killing process 276908
systemd[1469]: Started "Chrome Remote Desktop host daemon".
```

Replace the `\s` with `\\s` in `/opt/google/chrome-remote-desktop/chrome-remote-desktop`

```python
2562: extra_start_host_args = []
2527:  if HOST_EXTRA_PARAMS_ENV_VAR in os.environ:
2528:      extra_start_host_args = \
2529:          re.split('\\s+', os.environ[HOST_EXTRA_PARAMS_ENV_VAR].strip())
```

After restarting the `chrome--remote-desktop` service, the status showed that the daemon is successfully started

```bash
systemctl --user status chrome-remote-desktop.service
○ chrome-remote-desktop.service - "Chrome Remote Desktop host daemon"
     Loaded: loaded (/usr/lib/systemd/user/chrome-remote-desktop.service; enabled; preset: enabled)
     Active: inactive (dead) since Wed 2024-09-18 10:40:11 EEST; 3s ago
 Invocation: b1f776d453fa4b2aaf5cab4acbb8f3ab
    Process: 285042 ExecStart=/usr/bin/crd --start (code=exited, status=0/SUCCESS)
    Process: 285118 ExecStop=/usr/bin/crd --stop (code=exited, status=0/SUCCESS)
   Mem peak: 16.3M
        CPU: 332ms

systemd[1469]: Starting "Chrome Remote Desktop host daemon"...
pkexec[285047]: pam_unix(polkit-1:session): session opened for user root(uid=0) by sitram(uid=1000)
crd[285122]: Killing process 285116
systemd[1469]: Started "Chrome Remote Desktop host daemon".
```

#### ArchLinux - Chrome Remote Desktop - connect to an existing session

With default installation `chrome-remote-desktop` created a new session. Use the following configuration to connect to an existing session isntead of creating a new one so you can access all your open tabs from each monitor.

Find what display number X is using

```bash
echo $DISPLAY
:0
```

Create a file in `~/.config/chrome-remote-desktop/Xsession` with the display value

```bash
echo "0" > ~/.config/chrome-remote-desktop/Xsession
```

Stop the c`hrome-remote-desktop.service`

```bash
systemctl --user stop chrome-remote-desktop.service
```

Check if it stopped with `crd --status`. If it did not, stop it with `crd --stop`

```bash
rd --status
CRD status: STOPPED
```

Take a backup of `/opt/google/chrome-remote-desktop/chrome-remote-desktop`

Download the patched `/opt/google/chrome-remote-desktop/chrome-remote-desktop` to the same location, or follow the instructions to manually modify your file [here](https://gist.github.com/nightuser/2ec1b91a66ec33ef0a0a67b6c570eb40#file-use_existing_session-patch).

Note: The patched version was tested with chrome-remote-desktop `128.0.6613.44`

One-liner for all the steps above:

```bash
cho $DISPLAY | tr -d ':' >> ~/.config/chrome-remote-desktop/Xsession && cd /opt/google/chrome-remote-desktop && sudo cp chrome-remote-desktop chrome-remote-desktop_bak && sudo wget -qO- "https://gist.githubusercontent.com/nightuser/2ec1b91a66ec33ef0a0a67b6c570eb40/raw/b09250dcc9a28f09de93192a948dffb4963c2aca/use_existing_session.patch" | tail -n +5 > ~/use_existing_session.patch && sudo patch -Np1 -i ~/use_existing_session.patch && rm ~/ use_existing_session.patch && systemctl --user restart chrome-remote-desktop.service && systemctl --user status chrome-remote-desktop.service
```

If a host had been already configured before applying the patch above and for some reason it no longer appears in [https://remotedesktop.google.com/access](https://remotedesktop.google.com/access), do again the entire process from [https://remotedesktop.google.com/headless](https://remotedesktop.google.com/headless) and it should work.
