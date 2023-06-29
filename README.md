# Table of contents

- [About my Homelab](./general/general.md#about-my-homelab)
- [Introduction](./general/general.md#introduction)
  - [How I started](./general/general.md#how-i-started)
  - [HomeLab architecture](./general/general.md#homelab-architecture)
  - [Document structure](./general/general.md#document-structure)
  - [Prerequisites](./general/general.md#prerequisites)
- [Common](./general/general.md#common)
  - [SSH configuration](./general/general.md#ssh-configuration)
  - [Execute commands using SSH](./general/general.md#execute-commands-using-ssh)
  - [How to fix warning about ECDSA host key](./general/general.md#how-to-fix-warning-about-ecdsa-host-key)
  - [Ubuntu - upgrade from older distribution](./general/general.md#ubuntu---upgrade-from-older-distribution)
  - [Ubuntu - configure unattended upgrades](./general/general.md#ubuntu---configure-unattended-upgrades)
  - [Ubuntu - Clean unnecessary packages](./general/general.md#ubuntu---clean-unnecessary-packages)
  - [Ubuntu - Remove old kernels on Ubuntu](./general/general.md#ubuntu---remove-old-kernels)
  - [Ubuntu - Clean up snap on Ubuntu](./general/general.md#ubuntu---clean-up-snap)
  - [Clear systemd journald logs](./general/general.md#clear-systemd-journald-logs)
  - [Ubuntu - MariaDB update](./general/general.md#ubuntu---mariadb-update)
  - [Ubuntu - Install nginx](./general/general.md#ubuntu---install-nginx)
  - [Ubuntu - Configure PHP source list](./general/general.md#ubuntu---configure-php-source-list)
  - [Ubuntu - Synchronize time with systemd-timesyncd](./general/general.md#ubuntu---synchronize-time-with-systemd-timesyncd)
  - [Ubuntu - Synchronize time with ntpd](./general/general.md#ubuntu---synchronize-time-with-ntpd)
  - [Update system timezone](./general/general.md#update-system-timezone)
  - [Correct DNS resolution](./general/general.md#correct-dns-resolution)
  - [Qemu-guest-agent](./general/general.md#qemu-guest-agent)
  - [Simulate server load](./general/general.md#simulate-server-load)
    - [CPU](./general/general.md#cpu)
    - [RAM](./general/general.md#ram)
    - [Disk](./general/general.md#disk)
  - [Generate Gmail App Password](./general/general.md#generate-gmail-app-password)
  - [Configure Postfix Server to send email through Gmail](./general/general.md#configure-postfix-server-to-send-email-through-gmail)
  - [Mail notifications for SSH dial-in](./general/general.md#mail-notifications-for-ssh-dial-in)
  - [Backup folder](./general/general.md#backup-folder)
  - [Generate random passwords or tokens](./general/general.md#generate-random-passwords-or-tokens)
- [Proxmox - Virtualization server](./proxmox/proxmox.md#proxmox---virtualization-server)
  - [Proxmox - OS configuration](./proxmox/proxmox.md#proxmox---os-configuration)
  - [Proxmox - NTP time server](./proxmox/proxmox.md#proxmox---ntp-time-server)
  - [Proxmox - PCI Passthrough configuration](./proxmox/proxmox.md#proxmox---pci-passthrough-configuration)
  - [Proxmox - UPS monitoring software](./proxmox/proxmox.md#proxmox---ups-monitoring-software)
  - [Proxmox - VNC client access configuration](./proxmox/proxmox.md#proxmox---vnc-client-access-configuration)
- [pfSense - Firewall, DHCP and NTP server](./proxmox/proxmox.md#pfsense---firewall-dhcp-and-ntp-server)
  - [pfSense - VM configuration](./pfsense/pfsense.md#pfsense---vm-configuration)
  - [pfSense - Setup](./pfsense/pfsense.md#pfsense---setup)
  - [Firewall / NAT / Port Forward](./pfsense/pfsense.md#firewall--nat--port-forward)
  - [Firewall / NAT / Outbound](./pfsense/pfsense.md#firewall--nat--outbound)
  - [pfSense - DHCP server setup](./pfsense/pfsense.md#pfsense---dhcp-server-setup)
  - [pfSense - OpenVPN setup](./pfsense/pfsense.md#pfsense---openvpn-setup)
- [piHole - All-around DNS solution server](./pihole/pihole.md#pihole---all-around-dns-solution-server)
  - [piHole - VM configuration](./pihole/pihole.md#pihole---vm-configuration)
  - [piHole - OS Configuration](./pihole/pihole.md#pihole---os-configuration)
  - [piHole - Setup](./pihole/pihole.md#pihole---setup)
  - [piHole - Ubound as a recursive DNS server](./pihole/pihole.md#pihole---ubound-as-a-recursive-dns-server)
  - [piHole - Local DNS configuration](./pihole/pihole.md#pihole---local-dns-configuration)
- [TrueNAS - Storage management server](./truenas/truenas.md#truenas---storage-management-server)
  - [TrueNAS - VM configuration](./truenas/truenas.md#truenas---vm-configuration)
  - [TrueNAS - HDD passtrough](./truenas/truenas.md#truenas---hdd-passtrough)
  - [TrueNAS - OS Configuration](./truenas/truenas.md#truenas---os-configuration)
  - [TrueNAS - Setup](./truenas/truenas.md#truenas---setup)
- [HomeAssistant - Home automation server](./homeassistant/homeassistant.md#homeassistant---home-automation-server)
  - [HomeAssistant - VM configuration](./homeassistant/homeassistant.md#homeassistant---vm-configuration)
  - [HomeAssistant - Installation and setup](./homeassistant/homeassistant.md#homeassistant---installation-and-setup)
  - [HomeAssistant - Other plugins](./homeassistant/homeassistant.md#homeassistant---other-plugins)
  - [HomeAssistant - Mosquitto broker(MQTT)](./homeassistant/homeassistant.md#homeassistant---mosquitto-brokermqtt)
  - [HomeAssistant - Paradox Alarm integration](./homeassistant/homeassistant.md#homeassistant---paradox-alarm-integration)
  - [HomeAssistant - UPS integration](./homeassistant/homeassistant.md#homeassistant---ups-integration)
  - [HomeAssistant - Integration of CCTV cameras](./homeassistant/homeassistant.md#homeassistant---integration-of-cctv-cameras)
  - [HomeAssistant - Google Assistant integration](./homeassistant/homeassistant.md#homeassistant---google-assistant-integration)
  - [HomeAssistant - Recorder integration](./homeassistant/homeassistant.md#homeassistant---recorder-integration)
- [Nextcloud - Content collaboration server](./homeassistant/homeassistant.md#nextcloud---content-collaboration-server)
  - [Nextcloud - VM configuration](./nextcloud/nextcloud.md#nextcloud---vm-configuration)
  - [Nextcloud - OS Configuration](./nextcloud/nextcloud.md#nextcloud---os-configuration)
  - [Nextcloud - Installation and configuration of nginx web server](./nextcloud/nextcloud.md#nextcloud---installation-and-configuration-of-nginx-web-server)
  - [Nextcloud - Installation and configuration of PHP 8.0](./nextcloud/nextcloud.md#nextcloud---installation-and-configuration-of-php-80)
  - [Nextcloud - Installation and configuration of MariaDB database](./nextcloud/nextcloud.md#nextcloud---installation-and-configuration-of-mariadb-database)
  - [Nextcloud - Database creation](./nextcloud/nextcloud.md#nextcloud---database-creation)
  - [Nextcloud - Installation of Redis server](./nextcloud/nextcloud.md#nextcloud---installation-of-redis-server)
  - [Nextcloud - Optimize and update using a script](./nextcloud/nextcloud.md#nextcloud---optimize-and-update-using-a-script)
  - [Nextcloud - Bash aliases for executing Nextcloud Toolset occ](./nextcloud/nextcloud.md#nextcloud---bash-aliases-for-executing-nextcloud-toolset-occ)
  - [Nextcloud - Map user data directory to nfs share](./nextcloud/nextcloud.md#nextcloud---map-user-data-directory-to-nfs-share)
- [Hercules - HomeLab services VM](./hercules/hercules.md./hercules/hercules.md#hercules---homelab-services-vm)
  - [Hercules - VM configuration](./hercules/hercules.md#hercules---vm-configuration)
  - [Hercules - OS Configuration](./hercules/hercules.md#hercules---os-configuration)
  - [Hercules - Docker installation and docker-compose](./hercules/hercules.md#hercules---docker-installation-and-docker-compose)
    - [Hercules - Remove docker packages from Ubuntu repository](./hercules/hercules.md#hercules---remove-docker-packages-from-ubuntu-repository)
    - [Hercules - set up Docker repository](./hercules/hercules.md#hercules---set-up-docker-repository)
    - [Hercules - Install Docker Engine](./hercules/hercules.md#hercules---install-docker-engine)
  - [Hercules - Watchtower docker container](./hercules/hercules.md#hercules---watchtower-docker-container)
  - [Hercules - Heimdall docker container](./hercules/hercules.md#hercules---heimdall-docker-container)
  - [Hercules - Portainer docker container](./hercules/hercules.md#hercules---portainer-docker-container)
  - [Hercules - Calibre docker container](./hercules/hercules.md#hercules---calibre-docker-container)
  - [Hercules - Calibre-web docker container](./hercules/hercules.md#hercules---calibre-web-docker-container)
  - [Hercules - qBitTorrent docker container](./hercules/hercules.md#hercules---qbittorrent-docker-container)
  - [Hercules - Jackett docker container](./hercules/hercules.md#hercules---jackett-docker-container)
  - [Hercules - Sonarr docker container](./hercules/hercules.md#hercules---sonarr-docker-container)
  - [Hercules - Radarr docker container](./hercules/hercules.md#hercules---radarr-docker-container)
  - [Hercules - Bazarr docker container](./hercules/hercules.md#hercules---bazarr-docker-container)
  - [Hercules - Lidarr docker container](./hercules/hercules.md#hercules---lidarr-docker-container)
  - [Hercules - Overseerr docker container](./hercules/hercules.md#hercules---overseerr-docker-container)
  - [Hercules - GoDaddy DNS Updater](./hercules/hercules.md#hercules---godaddy-dns-updater)
  - [Hercules - SWAG - Secure Web Application Gateway docker container](./hercules/hercules.md#hercules---swag---secure-web-application-gateway-docker-container)
  - [Hercules - Plex docker container](./hercules/hercules.md#hercules---plex-docker-container)
  - [Hercules - PostgressSQL database docker container](./hercules/hercules.md#hercules---postgresssql-database-docker-container)
  - [Hercules - MySQL database docker container](./hercules/hercules.md#hercules---mysql-database-docker-container)
  - [Hercules - Adminer docker container](./hercules/hercules.md#hercules---adminer-docker-container)
  - [Hercules - PGAdmin docker container](./hercules/hercules.md#hercules---pgadmin-docker-container)
  - [Hercules - Guacamole daemon and web application docker container](./hercules/hercules.md#hercules---guacamole-daemon-and-web-application-docker-container)
  - [Hercules - Redis docker container](./hercules/hercules.md#hercules---redis-docker-container)
  - [Hercules - LibreSpeed docker container](./hercules/hercules.md#hercules---librespeed-docker-container)
  - [Hercules - Authelia docker container](./hercules/hercules.md#hercules---authelia-docker-container)
  - [Hercules - PortfolioPerformance docker container](./hercules/hercules.md#hercules---portfolioperformance-docker-container)
- [Windows11 - Virtual Windows Desktop VM](./hercules/hercules.md./hercules/hercules.md#windows11---virtual-windows-desktop-vm)
  - [Windows11 - VM configuration](./windows/windows.md#windows11---vm-configuration)
  - [Windows11 - Windows installation](./windows/windows.md#windows11---windows-installation)
  - [Windows11 - Remote Desktop Connection configuration](./windows/windows.md#windows11---remote-desktop-connection-configuration)
- [Code - coding VM](./code/code.md#code---coding-vm)
  - [Code - VM configuration](./code/code.md#code---vm-configuration)
  - [Code - OS Configuration](./code/code.md#code---os-configuration)
  - [Code - CodeServer installation and configuration](./code/code.md#code---codeserver-installation-and-configuration)
  - [Code - Accessing CodeServer from outside local network](./code/code.md#code---accessing-codeserver-from-outside-local-network)
- [ArchLinux - Desktop VM](./archlinux/archlinux.md#archlinux---desktop-vm)
  - [ArchLinux - VM configuration](./archlinux/archlinux.md#archlinux---vm-configuration)
  - [ArchLinux - OS Configuration](./archlinux/archlinux.md#archlinux---os-configuration)
  - [ArchLinux - Network configuration](./archlinux/archlinux.md#archlinux---network-configuration)
    - [ArchLinux - systemd-networkd](./archlinux/archlinux.md#archlinux---systemd-networkd)
    - [ArchLinux - NetworkManager](./archlinux/archlinux.md#archlinux---networkmanager)
  - [ArchLinux - Troubleshoot sound issues](./archlinux/archlinux.md#archlinux---troubleshoot-sound-issues)
  - [ArchLinux - I3 installation & Customization](./archlinux/archlinux.md#archlinux---i3-installation--customization)
  - [ArchLinux - ZSH shell](./archlinux/archlinux.md#archlinux---zsh-shell)
  - [ArchLinux - Downgrade packages](./archlinux/archlinux.md#archlinux---downgrade-packages)
    - [ArchLinux - Using pacman cache](./archlinux/archlinux.md#archlinux---using-pacman-cache)
    - [ArchLinux - Using Arch Linux Archive](./archlinux/archlinux.md#archlinux---using-arch-linux-archive)
    - [ArchLinux - Restore system to an earlier date](./archlinux/archlinux.md#archlinux---restore-system-to-an-earlier-date)
  - [ArchLinux - Connect Android To Arch Linux Via USB](./archlinux/archlinux.md#archlinux---connect-android-to-arch-linux-via-usb)
  - [ArchLinux - Rebuild AUR packages when python is upgraded](./archlinux/archlinux.md#archlinux---rebuild-aur-packages-when-python-is-upgraded)
- [WordPress - WorPress server VM](./wordpress/wordpress.md#wordpress---worpress-server-vm)
  - [WordPress - VM configuration](./wordpress/wordpress.md#wordpress---vm-configuration)
  - [WordPress - OS Configuration](./wordpress/wordpress.md#wordpress---os-configuration)
  - [WordPress - Installation and configuration of nginx web server](./wordpress/wordpress.md#wordpress---installation-and-configuration-of-nginx-web-server)
  - [WordPress - Installation and configuration of PHP 8.0](./wordpress/wordpress.md#wordpress---installation-and-configuration-of-php-80)
  - [WordPress - Installation and configuration of MariaDB database](./wordpress/wordpress.md#wordpress---installation-and-configuration-of-mariadb-database)
  - [WordPress - Database creation](./wordpress/wordpress.md#wordpress---database-creation)
  - [Wordpress - Installation and optimization](./wordpress/wordpress.md#wordpress---installation-and-optimization)
  - [Wordpress - Installation of Redis server](./wordpress/wordpress.md#wordpress---installation-of-redis-server)
  - [Wordpress - Manual migration to another domain](./wordpress/wordpress.md#wordpress---manual-migration-to-another-domain)
