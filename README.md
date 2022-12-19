# A guide to my Homelab

Table of contents:

- [About my Homelab](#about-my-homelab)
- [Introduction](#introduction)
  - [How I started](#how-i-started)
  - [HomeLab architecture](#homelab-architecture)
  - [Document structure](#document-structure)
  - [Prerequisites](#prerequisites)
- [General](#general)
  - [SSH configuration](#ssh-configuration)
  - [Execute commands using SSH](#execute-commands-using-ssh)
  - [How to fix warning about ECDSA host key](#how-to-fix-warning-about-ecdsa-host-key)
  - [Ubuntu - upgrade from older distribution](#ubuntu---upgrade-from-older-distribution)
  - [Ubuntu - configure unattended upgrades](#ubuntu---configure-unattended-upgrades)
  - [Ubuntu - Clean unnecessary packages](#ubuntu---clean-unnecessary-packages)
  - [Ubuntu - Remove old kernels on Ubuntu](#ubuntu---remove-old-kernels)
  - [Ubuntu - Clean up snap on Ubuntu](#ubuntu---clean-up-snap)
  - [Clear systemd journald logs](#clear-systemd-journald-logs)
  - [Ubuntu - MariaDB update](#ubuntu---mariadb-update)
  - [Ubuntu - Install nginx](#ubuntu---install-nginx)
  - [Ubuntu - Configure PHP source list](#ubuntu---configure-php-source-list)
  - [Ubuntu - Synchronize time with systemd-timesyncd](#ubuntu---synchronize-time-with-systemd-timesyncd)
  - [Ubuntu - Synchronize time with ntpd](#ubuntu---synchronize-time-with-ntpd)
  - [Update system timezone](#update-system-timezone)
  - [Correct DNS resolution](#correct-dns-resolution)
  - [Qemu-guest-agent](#qemu-guest-agent)
  - [Simulate server load](#simulate-server-load)
    - [CPU](#cpu)
    - [RAM](#ram)
    - [Disk](#disk)
  - [Generate Gmail App Password](#generate-gmail-app-password)
  - [Configure Postfix Server to send email through Gmail](#configure-postfix-server-to-send-email-through-gmail)
  - [Mail notifications for SSH dial-in](#mail-notifications-for-ssh-dial-in)
- [Proxmox - Virtualization server](#proxmox---virtualization-server)
  - [Proxmox - OS configuration](#proxmox---os-configuration)
  - [Proxmox - NTP time server](#proxmox---ntp-time-server)
  - [Proxmox - PCI Passthrough configuration](#proxmox---pci-passthrough-configuration)
  - [Proxmox - UPS monitoring software](#proxmox---ups-monitoring-software)
  - [Proxmox - VNC client access configuration](#proxmox---vnc-client-access-configuration)
- [pfSense - Firewall, DHCP and NTP server](#pfsense---firewall-dhcp-and-ntp-server)
  - [pfSense - VM configuration](#pfsense---vm-configuration)
  - [pfSense - Setup](#pfsense---setup)
  - [Firewall / NAT / Port Forward](#firewall--nat--port-forward)
  - [Firewall / NAT / Outbound](#firewall--nat--outbound)
  - [pfSense - DHCP server setup](#pfsense---dhcp-server-setup)
  - [pfSense - OpenVPN setup](#pfsense---openvpn-setup)
- [piHole - All-around DNS solution server](#pihole---all-around-dns-solution-server)
  - [piHole - VM configuration](#pihole---vm-configuration)
  - [piHole - OS Configuration](#pihole---os-configuration)
  - [piHole - Setup](#pihole---setup)
  - [piHole - Ubound as a recursive DNS server](#pihole---ubound-as-a-recursive-dns-server)
  - [piHole - Local DNS configuration](#pihole---local-dns-configuration)
- [TrueNAS - Storage management server](#truenas---storage-management-server)
  - [TrueNAS - VM configuration](#truenas---vm-configuration)
  - [TrueNAS - HDD passtrough](#truenas---hdd-passtrough)
  - [TrueNAS - OS Configuration](#truenas---os-configuration)
  - [TrueNAS - Setup](#truenas---setup)
- [HomeAssistant - Home automation server](#homeassistant---home-automation-server)
  - [HomeAssistant - VM configuration](#homeassistant---vm-configuration)
  - [HomeAssistant - Installation and setup](#homeassistant---installation-and-setup)
  - [HomeAssistant - Other plugins](#homeassistant---other-plugins)
  - [HomeAssistant - Mosquitto broker(MQTT)](#homeassistant---mosquitto-brokermqtt)
  - [HomeAssistant - Paradox Alarm integration](#homeassistant---paradox-alarm-integration)
  - [HomeAssistant - UPS integration](#homeassistant---ups-integration)
  - [HomeAssistant - Integration of CCTV cameras](#homeassistant---integration-of-cctv-cameras)
  - [HomeAssistant - Google Assistant integration](#homeassistant---google-assistant-integration)
  - [HomeAssistant - Recorder integration](#homeassistant---recorder-integration)
- [Nextcloud - Content collaboration server](#nextcloud---content-collaboration-server)
  - [Nextcloud - VM configuration](#nextcloud---vm-configuration)
  - [Nextcloud - OS Configuration](#nextcloud---os-configuration)
  - [Nextcloud - Installation and configuration of nginx web server](#nextcloud---installation-and-configuration-of-nginx-web-server)
  - [Nextcloud - Installation and configuration of PHP 8.0](#nextcloud---installation-and-configuration-of-php-80)
  - [Nextcloud - Installation and configuration of MariaDB database](#nextcloud---installation-and-configuration-of-mariadb-database)
  - [Nextcloud - Database creation](#nextcloud---database-creation)
  - [Nextcloud - Installation of Redis server](#nextcloud---installation-of-redis-server)
  - [Nextcloud - Optimize and update using a script](#nextcloud---optimize-and-update-using-a-script)
  - [Nextcloud - Bash aliases for executing Nextcloud Toolset occ](#nextcloud---bash-aliases-for-executing-nextcloud-toolset-occ)
  - [Nextcloud - Map user data directory to nfs share](#nextcloud---map-user-data-directory-to-nfs-share)
- [Hercules - HomeLab services VM](#hercules---homelab-services-vm)
  - [Hercules - VM configuration](#hercules---vm-configuration)
  - [Hercules - OS Configuration](#hercules---os-configuration)
  - [Hercules - Docker installation and docker-compose](#hercules---docker-installation-and-docker-compose)
    - [Hercules - Remove docker packages from Ubuntu repository](#hercules---remove-docker-packages-from-ubuntu-repository)
    - [Hercules - set up Docker repository](#hercules---set-up-docker-repository)
    - [Hercules - Install Docker Engine](#hercules---install-docker-engine)
  - [Hercules - Watchtower docker container](#hercules---watchtower-docker-container)
  - [Hercules - Heimdall docker container](#hercules---heimdall-docker-container)
  - [Hercules - Portainer docker container](#hercules---portainer-docker-container)
  - [Hercules - Calibre docker container](#hercules---calibre-docker-container)
  - [Hercules - Calibre-web docker container](#hercules---calibre-web-docker-container)
  - [Hercules - qBitTorrent docker container](#hercules---qbittorrent-docker-container)
  - [Hercules - Jackett docker container](#hercules---jackett-docker-container)
  - [Hercules - Sonarr docker container](#hercules---sonarr-docker-container)
  - [Hercules - Radarr docker container](#hercules---radarr-docker-container)
  - [Hercules - Bazarr docker container](#hercules---bazarr-docker-container)
  - [Hercules - Lidarr docker container](#hercules---lidarr-docker-container)
  - [Hercules - Overseerr docker container](#hercules---overseerr-docker-container)
  - [Hercules - DuckDNS docker container](#hercules---duckdns-docker-container)
  - [Hercules - SWAG - Secure Web Application Gateway docker container](#hercules---swag---secure-web-application-gateway-docker-container)
  - [Hercules - Plex docker container](#hercules---plex-docker-container)
  - [Hercules - Guacamole docker container](#hercules---guacamole-docker-container)
  - [Hercules - Adminer docker container](#hercules---adminer-docker-container)
  - [Hercules - PGAdmin docker container](#hercules---pgadmin-docker-container)
  - [Hercules - PostgressSQL database docker container](#hercules---postgresssql-database-docker-container)
  - [Hercules - MySQL database docker container](#hercules---mysql-database-docker-container)
  - [Hercules - Redis docker container](#hercules---redis-docker-container)
  - [Hercules - Jenkins CI docker container](#hercules---jenkins-ci-docker-container)
  - [Hercules - LibreSpeed docker container](#hercules---librespeed-docker-container)
  - [Hercules - PortfolioPerformance docker container](#hercules---portfolioperformance-docker-container)
- [Windows11 - Virtual Windows Desktop VM](#windows11---virtual-windows-desktop-vm)
  - [Windows11 - VM configuration](#windows11---vm-configuration)
  - [Windows11 - Windows installation](#windows11---windows-installation)
  - [Windows11 - Remote Desktop Connection configuration](#windows11---remote-desktop-connection-configuration)
- [Code - coding VM](#code---coding-vm)
  - [Code - VM configuration](#code---vm-configuration)
  - [Code - OS Configuration](#code---os-configuration)
  - [Code - CodeServer installation and configuration](#code---codeserver-installation-and-configuration)
  - [Code - Accessing CodeServer from outside local network](#code---accessing-codeserver-from-outside-local-network)
- [ArchLinux - Desktop VM](#archlinux---desktop-vm)
  - [ArchLinux - VM configuration](#archlinux---vm-configuration)
  - [ArchLinux - OS Configuration](#archlinux---os-configuration)
  - [ArchLinux - Network configuration](#archlinux---network-configuration)
    - [ArchLinux - systemd-networkd](#archlinux---systemd-networkd)
    - [ArchLinux - NetworkManager](#archlinux---networkmanager)
  - [ArchLinux - Troubleshoot sound issues](#archlinux---troubleshoot-sound-issues)
  - [ArchLinux - I3 installation & Customization](#archlinux---i3-installation--customization)
  - [ArchLinux - ZSH shell](#archlinux---zsh-shell)
  - [ArchLinux - Downgrade packages](#archlinux---downgrade-packages)
- [WordPress - WorPress server VM](#wordpress---worpress-server-vm)
  - [WordPress - VM configuration](#wordpress---vm-configuration)
  - [WordPress - OS Configuration](#wordpress---os-configuration)
  - [WordPress - Installation and configuration of nginx web server](#wordpress---installation-and-configuration-of-nginx-web-server)
  - [WordPress - Installation and configuration of PHP 8.0](#wordpress---installation-and-configuration-of-php-80)
  - [WordPress - Installation and configuration of MariaDB database](#wordpress---installation-and-configuration-of-mariadb-database)
  - [WordPress - Database creation](#wordpress---database-creation)

## About my Homelab

This repository is intended to record my experience in setting up a HomeLab using a dedicated server running [Proxmox](https://www.proxmox.com/en/) with various services running in several VM's and LXC's. I will be touching topics related to virtualization, hardware passtrough, LXC, Docker and several services which I currently use. This document is a work in progress and will evolve as I gain more experience and find more interesting stuff to do. I do not intend this repository or this document to be taken as a tutorial because I don't consider myself an expert in this area.

Use the information provided in this repository at your own risk. I take no responsibility for any damage to your equipment. Depending on my availability I can support if asked in solving issues with your software but be prepared to troubleshoot stuff that don't work on your own. My recommendation is to take the information that I provide here and adapt it to your own needs and hardware. For any questions please contact me at **adrian.martis (at) gmail . com**

## Introduction

### How I started

Initially I started my adventure in building an HomeLab on an old laptop, where I installed Proxmox and did some testing with several VM's and [HomeAssistant](https://www.home-assistant.io/). It probably would have been enough if it didn't had two annoying issues. Every couple of days, the laptop froze and I had to manually reboot it. The second issue was that BIOS did not support resume to the last power state in case of a power shortage. Because of these two issues, I couldn't run the laptop for more then a few days without having to physically interact with it. Because of this I couldn't have a reliable server for running services or home automation. After struggling with this setup for a couple of months I decided it was time for an upgrade.

I spent several weeks researching about various hardware builds for an HomeLab. I read blogs, joined several channels on Reddit and groups on Facebook dedicated to this topic. The more I spent researching, the more I got frustrated of how easy it was for people living in US, Germany or UK to access all kind of equipment. I either had to make a compromise and buy consumer grade equipment, spent extra money on shipping tax to order, or get lucky and find a good deal in my own country.

In the end, it payed off to be patient, because I got lucky and found a complete system for sale locally. Everyone I talked with, said it was overkill for what I wanted to run in my HomeLab. I diregarded their advices and went with my gut feeling. I payed for the entire server around 800$ and now I had the equipment needed to fulfill any project I wanted.

The server contained the case, PSU, cables, two Intel Xeon CPU's and 192GB of server graded RAM with ECC. I had two 1GB, 2.5', 7200 rpm HDD's in another laptop which I decided to use in RAID 1 to keep some of my data safe. I bought a 1TB M.2 2280 SSD from SWORDFISH to use for host operating system and various VM's. The final purchase was an HPE Ethernet 1GB 2-port 361T adapter which I wanted to passtrough to a VM running a dedicated firewall. Later I added another 750GB old HDD to store movies and tv shows.

### HomeLab architecture

Over time, I added new hardware to my HomeLab, like IoT devices, a range extender to have a better Wifi coverage and an UPS. I have planned to upgrade my storage and perhaps purchase a GPU but they have a low priority due to budget constraints. However, I am always open for suggestions so feel free to reach me over email in case you have one.

The software, services and the overall architecture of my my HomeLab are constantly adapting and evolving. When I learn a new technology or find an interesting software, I decide to incorporate it in my existing architecture or just spin a VM for test.

[Here](HomeLab.jpg) you can find a picture with an overview of the current architecture. I update every time I change something to my HomeLab. The details on the configuration of each VM and service can be seen below.

### Document structure

The document is written in Markdown and structured in 3 main sections.

First section contains a short history, current HomeLab state and structure of the document.

The second section contains general tutorials that are independed to any any VM. Some of the commands assume that either the DHCP or the DNS server is up and running, so please keep this in mind when reading.

The third section contains a chapter for every VM or LXC container I currently run. Inside each chapter there are sections that describe the VM configuration in Proxmox, specific OS configurations, software and services installation and configuration. This is a work in progress so expect that some of these chapters are empty and will be added at a later date, when I have some time available.

### Prerequisites

- [x] Layer 2 Network Switch, preferably one that supports Gigabit Ethernet and has at least 16 ports
- [x] Dedicated PC that can be used as a PVE Host
- [x] Internet access for PVE host
- [x] Network router with Wi-Fi support
  - Preferably one that supports both 2.4Gz and 5Ghz bands
- [x] Cabling
- [x] UPS to allow the network equipment a clean shutdown in case of power failures and prevent damage caused by power fluctuations
  - I recommend to have a dedicated power circuit for the HomeLab equipment

Optional:

- [x] Network rack to store all homelab equipment

## General

The following sections apply to all VM's.

Unless the services running on the VM require a dedicated OS, I prefer to use Ubuntu Server. The sections in this chapter are tested on Ubuntu Server but might apply with slight modifications to other Linux based operating systems. For each VM I will specify which chapter from this section applies.

Every VM has user **sitram** configured during installation. The user has **sudo** privileges.

### SSH configuration

I use two keys for my entire HomeLab. One is used for Guacamole, so I can access from any web browser my servers in case I don't have access trough a SSH client. The other is my personal key which I use for accessing trough SSH clients.

I store these keys on every VM so that I can easily connect from one VM to another using SSH. A copy of each key is stored in an offline secure location.

Copy sshd configuration from an existing VM. An example can be found in this repo [here](sshd_config)

```bash
scp /etc/ssh/sshd_config sitram@192.168.0.xxx:/home/sitram
```

Copy the private and public keys for accessing the VM trough Guacamole from an existing VM

 ```bash
scp guacamole sitram@192.168.0.xxx:~/.ssh/
scp guacamole.pub sitram@192.168.0.xxx:~/.ssh/
```

Copy personal private and public keys for accessing the VM trough SSH and being able to access other servers on the network from an existing VM.

```bash
scp id_rsa sitram@192.168.0.xxx:~/.ssh/
scp id_rsa.pub sitram@192.168.0.xxx:~/.ssh/
```

Copy the authorized_keys file which allows connection to the VM using only my Guacamole or personal key from an existing VM.

```bash
scp authorized_keys sitram@192.168.0.xxx:~/.ssh/
```

Backup default sshd configuration, in case something goes wrong. Replace the existing configuration with the new one.

```bash
sudo mv /etc/ssh/sshd_config /etc/ssh/sshd_config.bkp
sudo mv ~/sshd_config /etc/ssh/
sudo chown root:root /etc/ssh/sshd_config
```

Restart sshd to use the new configuration.

```bash
sudo systemctl restart sshd
```

### Execute commands using SSH

The SSH client program can be used for logging into a remote machine or server and for executing commands on a remote machine. When a command is specified, it is executed on the remote host/server instead of the login shell of the current machine.

The syntax is as follows for executing commands

```bash
ssh user1@server1 command1
ssh user1@server1 'command2'
```

Several commands can be piped using the syntax below

```bash
ssh user1@server1 'command1 | command2'
```

Multiple compands can be executed using the syntax below

```bash
ssh user@hostname "command1; command2; command3"
```

Commands can be executed remotely with `sudo` using the syntax below

```bash
ssh -t user@hostname sudo command
ssh -t user@hostname 'sudo command1 arg1 arg2'
```

Execute comands remote with `su`

```bash
ssh user@hostname su -c "/path/to/command1 arg1 arg2"
```

To copy a file from `B` to `A` while logged into `B`:

```bash
scp /path/to/file username@a:/path/to/destination
```

To copy a file from `B` to `A` while logged into `A`:

```bash
scp username@b:/path/to/file /path/to/destination
```

### How to fix warning about ECDSA host key

When connecting with SSH, the following warning could be displayed in case the IP is reused for a different VM.

```text
Warning: the ECDSA host key for 'myserver' differs from the key for the IP address '192.168.0.xxx'
```

In order to get rid of the warning, remove the cached key for ```192.168.1.xxx``` on the local machine:

```bash
ssh-keygen -R 192.168.1.xxx
```

### Ubuntu - upgrade from older distribution

```bash
sudo apt update
sudo apt list --upgradable
sudo apt upgrade
```

The repositories for older releases that are not supported (like 11.04, 11.10 and 13.04) get moved to an archive server. There are repositories available at [old-releases.ubuntu.com](http://old-releases.ubuntu.com).

The reason for this is that it is now out of support and no longer receiving updates and security patches.

If you want to continue using an outdated release, edit `/etc/apt/sources.list` and change `archive.ubuntu.com` and `security.ubuntu.com` to `old-releases`.ubuntu.com.

You can do this with sed:

```bash
sudo sed -i -re 's/([a-z]{2}\.)?archive.ubuntu.com|security.ubuntu.com/old-releases.ubuntu.com/g' /etc/apt/sources.list
```

then update the system with:

```bash
sudo apt-get update && sudo apt-get dist-upgrade
```

### Ubuntu - configure unattended upgrades

Ubuntu provides a unique tool called `unattended-upgrades` in order to automatically retrieve and install security patches and other essential upgrades for a server. Installing the tool can be done with the following commands:

```bash
sudo apt-get update
sudo apt install unattended-upgrades
```

After installation, you can check to ensure that the `unattended-upgrades` service is running using `systemctl`

```bash
sudo systemctl status unattended-upgrades.service
```

Open configuration file `/etc/apt/apt.conf.d/50unattended-upgrades` with `nano`:

```bash
sudo nano /etc/apt/apt.conf.d/50unattended-upgrades
```

Uncomment or change the following lines

- `"${distro_id}:${distro_codename}-updates";`
- `Unattended-Upgrade::Mail "adrian.martis@gmail.com";`
- `Unattended-Upgrade::Remove-Unused-Kernel-Packages "true";`
- `Unattended-Upgrade::Remove-New-Unused-Dependencies "true";`
- `Unattended-Upgrade::Remove-New-Unused-Dependencies "true";`

An example of this file that I use on all my Ubuntu based VM's can be found [here](50unattended-upgrades)

Reload `unattended-upgrades` service:

```bash
sudo systemctl restart unattended-upgrades.service
```

### Ubuntu - Clean unnecessary packages

Very few server instances utilize these packages and they can be clean to save storage on the VM. Make sure you don't need them before removing them.

```bash
sudo apt purge --auto-remove snapd squashfs-tools friendly-recovery apport at cloud-init
```

Remove the `unattended-upgrades` package and the associated services which are responsible for automatically updating packages in the system in case this functionality is not used in your HomeLab.

```bash
sudo apt purge --auto-remove unattended-upgrades
sudo systemctl disable apt-daily-upgrade.timer
sudo systemctl mask apt-daily-upgrade.service
sudo systemctl disable apt-daily.timer
sudo systemctl mask apt-daily.service
```

Remove orphan packages

```bash
sudo apt autoremove --purge
```

### Ubuntu - Remove old kernels

After a while, there will be multiple versions of kernel on your system, which take up a lot of storage space. Old kernels and images can be removed with the following command

```bash
dpkg --list | grep 'linux-image' | awk '{ print $2 }' | sort -V | sed -n '/'"$(uname -r | sed "s/\([0-9.-]*\)-\([^0-9]\+\)/\1/")"'/q;p' | xargs sudo apt-get -y purge
```

Remove old kernels headers

```bash
dpkg --list | grep 'linux-headers' | awk '{ print $2 }' | sort -V | sed -n '/'"$(uname -r | sed "s/\([0-9.-]*\)-\([^0-9]\+\)/\1/")"'/q;p' | xargs sudo apt-get -y purge
```

Explanation (remember, `|` uses the output of the previous command as the input to the next)

- `dpkg` --list lists all installed packages
- `grep linux-image` looks for the installed linux images
- `awk '{ print $2 }'` just outputs the 2nd column (which is the package name)
- `sort -V` puts the items in order by version number
- ```$(uname -r | sed "s/\([0-9.-]*\)-\([^0-9]\+\)/\1/")"``` extracts only the version (e.g. "3.2.0-44") , without "-generic" or similar from `uname -r`
- `xargs sudo apt-get -y` purge purges the found kernels

Modify last part `xargs echo sudo apt-get -y purge` so that the command to purge the old kernels/headers is printed, then you can check that nothing unexpected is included before you run it.

All-in-one version to remove images and headers (combines the two versions above):

```bash
echo $(dpkg --list | grep linux-image | awk '{ print $2 }' | sort -V | sed -n '/'`uname -r`'/q;p') $(dpkg --list | grep linux-headers | awk '{ print $2 }' | sort -V | sed -n '/'"$(uname -r | sed "s/\([0-9.-]*\)-\([^0-9]\+\)/\1/")"'/q;p') | xargs sudo apt-get -y purge
```

### Ubuntu - Clean up snap

List all versions of packages retained by Snap

```bash
snap list --all
```

The default value is 3 for several revisions for retention. That means Snap keeps 3 older versions of each package, including the active version. Changing the retention value to 2 can be done with the following command

```bash
sudo snap set system refresh.retain=2
```

Script to set the default retention value of Snap packages to 2 and clean-up older packages

```bash
#!/bin/bash
#Set default retention values of snaps to 2
sudo snap set system refresh.retain=2

#Removes old revisions of snaps
#CLOSE ALL SNAPS BEFORE RUNNING THIS
set -eu
LANG=en_US.UTF-8 snap list --all | awk '/disabled/{print $1, $3}' |
    while read snapname revision; do
        sudo snap remove "$snapname" --revision="$revision"
    done
```

### Clear systemd journald logs

Checking disk usage of all journal files is done with command

```bash
sudo journalctl --disk-usage
```

Before clearing the logs, run the following command to rotate the journal files. All currently active journal files will be marked as archived, so that they are never written in future.

```bash
sudo journalctl --rotate
```

Delete journal logs older than X days

```bash
sudo journalctl --vacuum-time=2days
```

Delete log files until the disk space taken falls below the specified size:

```bash
sudo journalctl --vacuum-size=100M
```

Delete old logs and limit file number to X:

```bash
sudo journalctl --vacuum-size=100M
```

Edit the configuration file to limit the journal log disk usage to 100MB

```bash
sudo -H gedit /etc/systemd/journald.conf
```

When the file opens, un-comment (remove # at the beginning) the line `#SystemMaxUse=` and change it to `SystemMaxUse=100M`.

Save the file and reload systemd daemon via command:

```bash
sudo systemctl daemon-reload
```

### Ubuntu - MariaDB update

MariaDb distribution repo can be found [here](https://mariadb.org/download/?t=repo-config)

Configure MariaDB APT repository and add MariaDB signing key to use Ubuntu 20.04 (Focal Fossa) repository:

```bash
curl -LsS -O https://downloads.mariadb.com/MariaDB/mariadb_repo_setup
sudo bash mariadb_repo_setup --os-type=ubuntu  --os-version=focal --mariadb-server-version=10.6
```

### Ubuntu - Install nginx

Install the prerequisites:

```bash
sudo apt install curl gnupg2 ca-certificates lsb-release ubuntu-keyring
```

Import an official nginx signing key so apt could verify the packages authenticity. Fetch the key:

```bash
curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor \
    | sudo tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null
```

Verify that the downloaded file contains the proper key:

```bash
gpg --dry-run --quiet --import --import-options import-show /usr/share/keyrings/nginx-archive-keyring.gpg
```

The output should contain the full fingerprint 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 as follows:

```bash
pub   rsa2048 2011-08-19 [SC] [expires: 2024-06-14]
      573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62
uid                      nginx signing key <signing-key@nginx.com>
```

If the fingerprint is different, remove the file.

To set up the apt repository for stable nginx packages, run the following command:

```bash
echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
http://nginx.org/packages/ubuntu `lsb_release -cs` nginx" \
    | sudo tee /etc/apt/sources.list.d/nginx.list
```

If you would like to use mainline nginx packages, run the following command instead:

```bash
echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
http://nginx.org/packages/mainline/ubuntu `lsb_release -cs` nginx" \
    | sudo tee /etc/apt/sources.list.d/nginx.list
```

Set up repository pinning to prefer our packages over distribution-provided ones:

```bash
echo -e "Package: *\nPin: origin nginx.org\nPin: release o=nginx\nPin-Priority: 900\n" \
    | sudo tee /etc/apt/preferences.d/99nginx
```

To install nginx, run the following commands:

```bash
sudo apt update
sudo apt install nginx
```

### Ubuntu - Configure PHP source list

Add PHP software sources

```bash
cd /etc/apt/sources.list.d
sudo echo "deb [signed-by=/usr/share/keyrings/php-fm.gpg] http://ppa.launchpad.net/ondrej/php/ubuntu $(lsb_release -cs) main" | sudo tee php.list
```

In order to be able to trust the sources, use the corresponding keys:

```bash
sudo apt-key adv --recv-keys --keyserver hkps://keyserver.ubuntu.com:443 4F4EA0AAE5267A6C
sudo apt-get update -q4
sudo make-ssl-cert generate-default-snakeoil -y
sudo apt-key export E5267A6C | sudo gpg --dearmour -o /usr/share/keyrings/php-fm.gpg
sudo apt-key del E5267A6C
sudo apt-get update
```

### Ubuntu - Synchronize time with systemd-timesyncd

I have a dedicated timeserver which servers all the clients in my HomeLab. Whenever it is possible, I configure each server to use the internal timeserver.

Make sure NTP is not installed

```bash
sudo apt purge ntp
```

Edit file `timesyncd.conf`

```bash
sudo nano /etc/systemd/timesyncd.conf
```

Uncomment and modify the lines starting with `NTP`and `FallbackNTP`

```bash
NTP=192.168.0.2
FallbackNTP=pool.ntp.org
```

Restart the timesync daemon to use the internal timeserver

```bash
sudo systemctl restart systemd-timesyncd
```

or

```bash
sudo timedatectl set-ntp off
sudo timedatectl set-ntp on
timedatectl timesync-status
```

Check newly configured NTP servers are used by looking in the journal

```bash
journalctl --since -1h -u systemd-timesyncd
```

Configuration used can be checked using

```bash
sudo timedatectl show-timesync --all
```

To start troubleshooting, check the logs using the command

```bash
sudo grep systemd-timesyncd /var/log/syslog | tail
```

### Ubuntu - Synchronize time with ntpd

Install NTP server and ntpdate. Verify the version of NTP server to make sure it is correctly installed

```bash
sudo apt-get update
sudo apt-get install ntp ntpdate
sntp --version
```

Configure the NTP server pool either to a server closest to own location or local NTP server.

```bash
sudo nano /etc/ntp.conf
```

Comment the lines starting with `pool` and add the line

```bash
server 192.168.0.2 prefer iburst
```

The `iburst` option is recommended, and sends a burst of packets only if it cannot obtain a connection with the first attempt.
The `burst` option always does this, even on the first attempt, and should never be used without explicit permission and may result in blacklisting.

Restart NTP server and verify that it's running correctly

```bash
sudo service ntp stop
sudo service ntp start
sudo service ntp status
```

Check newly configured NTP servers are used by looking in the journal

```bash
journalctl --since -1h -u ntpd
```

In order to verify time synchronization status with each defined server or pool look for `\*` near the servers listed by command below. Any server which is not marked with `\*` is not syncronized.

```bash
ntpq -pn
```

Force update time with NTP service daemon and check that the communication with the ntp server is successfully.

```bash
date ; sudo service ntp stop ; sudo ntpdate -d 192.168.0.2 ; sudo service ntp start ; date
```

Logs can be checked using the command below

```bash
sudo grep ntpd /var/log/syslog | tail
```

### Update system timezone

In order to list all available timezones, the following command can be used

```bash
timedatectl list-timezones
```

Once the correct timezone from the above list has been chosen, system timezone can be changed using the command

```bash
sudo timedatectl set-timezone Europe/Bucharest
```

Check that system timezone, system clock synchronization and NTP services are correct

```bash
sudo timedatectl
```

### Correct DNS resolution

Edit file /etc/systemd/resolv.conf an add the following lines:

```bash
[Resolve]
DNS=192.168.0.103
FallbackDNS=8.8.8.8
Domains=local
```

To provide domain name resolution for software that reads `/etc/resolv.conf` directly, such as web browsers and GnuPG, replace the file with a symbolic link to the one from `systemd-resolved`

```bash
sudo rm -f /etc/resolv.conf
sudo ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf
sudo systemctl restart systemd-resolved.service
```

### Qemu-guest-agent

The qemu-guest-agent is a helper daemon, which is installed in the guest VM. It is used to exchange information between the host and guest, and to execute command in the guest.

According to Proxmox VE [wiki](https://pve.proxmox.com/wiki/Qemu-guest-agent), the qemu-guest-agent is used for mainly two things:

1. To properly shutdown the guest, instead of relying on ACPI commands or windows policies
2. To freeze the guest file system when making a backup (on windows, use the volume shadow copy service VSS).

guest-agent has to be installed in ech VM and enabled in Proxmox VE GUI or via CLI

- GUI: On the VM Options tab, set option 'Enabled' on 'QEMU Guest Agent
- CLI: `qm set VMID --agent 1`

### Simulate server load

Sometimes you need to discover how the performance of an application is affected when the system is under certain types of load. This means that an artificial load must be created. It is possible to install dedicated tools to do this, but this option isn’t always desirable or possible.

Every Linux distribution comes with all the tools needed to create load. They are not as configurable as dedicated tools but they will always be present and you already know how to use them.

#### CPU

The following command will generate a CPU load by compressing a stream of random data and then sending it to `/dev/null`:

```bash
cat /dev/urandom | gzip -9 > /dev/null
```

If you require a greater load or have a multi-core system simply keep compressing and decompressing the data as many times as you need:

```bash
cat /dev/urandom | gzip -9 | gzip -d | gzip -9 | gzip -d > /dev/null
```

An alternative is to use the sha512sum utility:

```bash
sha512sum /dev/urandom
```

Use CTRL+C to end the process.

#### RAM

The following process will reduce the amount of free RAM. It does this by creating a file system in RAM and then writing files to it. You can use up as much RAM as you need to by simply writing more files.

First, create a mount point then mount a ramfs filesystem there:

```bash
mkdir z
mount -t ramfs ramfs z/
```

Then, use dd to create a file under that directory. Here a 128MB file is created:

```bash
dd if=/dev/zero of=z/file bs=1M count=128
```

The size of the file can be set by changing the following operands:

- bs= Block Size. This can be set to any number followed B for bytes, K for kilobytes, M for megabytes or G for gigabytes.
- count= The number of blocks to write.

#### Disk

We will create disk I/O by firstly creating a file, and then use a for loop to repeatedly copy it.

This command uses dd to generate a 1GB file of zeros:

```bash
dd if=/dev/zero of=loadfile bs=1M count=1024
```

The following command starts a for loop that runs 10 times. Each time it runs it will copy loadfile over loadfile1:

```bash
for i in {1..10}; do cp loadfile loadfile1; done
```

If you want it to run for a longer or shorter time change the second number in {1..10}.

If you prefer the process to run forever until you kill it with CTRL+C use the following command:

```bash
while true; do cp loadfile loadfile1; done
```

### Generate Gmail App Password

When Two-Factor Authentication (2FA) is enabled, Gmail is preconfigured to refuse connections from applications that don’t provide the second step of authentication. While this is an important security measure that is designed to restrict unauthorized users from accessing your account, it hinders sending mail through some SMTP clients as you’re doing here. Follow these steps to configure Gmail to create a Postfix-specific password:

1. Log in to your Google Account and navigate to the [Manage your account access and security settings](https://myaccount.google.com/security) page.

2. Scroll down to `Signing in to Google` section and enable `2-Step Verification`. You may be asked for your password and a verification code before continuing.

3. In that same section, click on [App passwords](https://security.google.com/settings/security/apppasswords) to generate a unique password that can be used with your application.

4. Click the `Select app` dropdown and choose `Other (custom name)`. Enter name of the service of app for which you want to generate a password and click `Generate`.

5. The newly generated password will appear. Write it down or save it somewhere secure that you’ll be able to find easily in the next steps, then click `Done`:

### Configure Postfix Server to send email through Gmail

Postfix is a Mail Transfer Agent (MTA) that can act as an SMTP server or client to send or receive email. I chose to use this method to avoid getting my mail to be flagged as spam if my current server’s IP has been added to a block list.

Install Postfix and libsasl2, a package which helps manage the Simple Authentication and Security Layer (SASL)

```bash
sudo apt-get update
sudo apt-get install libsasl2-modules postfix
```

When prompted, select `Internet Site` as the type of mail server the Postfix installer should configure. In the next screen, the `System Mail Name` should be set to the domain you’d like to send and receive email through.

Once the installation is complete, confirm that the `myhostname` parameter is configured with your server’s FQDN in `/etc/postfix/main.cf`

Generate an Gmail password as described in subsection [Generate Gmail App Password](#generate-gmail-app-password).

Usernames and passwords are stored in sasl_passwd in the `/etc/postfix/sasl/` directory. In this section, you’ll add your email login credentials to this file and to Postfix.

Open or create the `/etc/postfix/sasl/sasl_passwd` file and add the SMTP Host, username, and password information.

```bash
sudo nano /etc/postfix/sasl/sasl_passwd
```

The SMTP server address configuration `smtp.gmail.com` supports message submission over port `587`(StartTLS) and port `465(`SSL). Whichever protocol you choose, be sure the port number is the same in `/etc/postfix/sasl/sasl\\_passwd` and `/etc/postfix/main.cf`

```bash
[smtp.gmail.com]:587 username@gmail.com:password
```

Create the hash db file for Postfix by running the postmap command.

```bash
sudo postmap /etc/postfix/sasl/sasl_passwd
```

If all went well, a new file named `sasl_passwd.db` in the `/etc/postfix/sasl/` directory.

Secure Postfix has database and email password files by changing persmissions of `/etc/postfix/sasl/sasl_passwd` and the `/etc/postfix/sasl/sasl_passwd.db` so that only root user cand read from or write to them.

```bash
sudo chown root:root /etc/postfix/sasl/sasl_passwd /etc/postfix/sasl/sasl_passwd.db
sudo chmod 0600 /etc/postfix/sasl/sasl_passwd /etc/postfix/sasl/sasl_passwd.db
```

Next step is to configure the Postfix Relay Server to use Gmail's SMTP server.

Add or modify if exists the following parameters to Postfix configuration file `/etc/postfix/main.cf`

```bash
# make sure the port number is matching the one from /etc/postfix/sasl/sasl\\_passwd
relayhost = [smtp.gmail.com]:587

# Enable SASL authentication
smtp_sasl_auth_enable = yes
# Disallow methods that allow anonymous authentication
smtp_sasl_security_options = noanonymous
# Location of sasl_passwd
smtp_sasl_password_maps = hash:/etc/postfix/sasl/sasl_passwd
# Enable STARTTLS encryption
smtp_tls_security_level = encrypt
# Location of CA certificates
smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt
```

Save changes and restart Postfix server.

```bash
sudo systemctl restart postfix
```

Use Postfix’s sendmail implementation to send a test email. Enter lines similar to those shown below, and note that there is no prompt between lines until the . ends the process.

```bash
sudo sendmail recipient@elsewhere.com
From: you@example.com
Subject: Test mail
This is a test email
.
```

Check in a separate sesion the changes as they appear live with command below. Use `CRTL + C` to exit the log.

```bash
sudo tail -f /var/log/syslog
```

### Mail notifications for SSH dial-in

Install mail client

```bash
sudo apt-get update
sudo apt-get install mailutils
```

Edit sustem-wide `.profile` for Bourne compative shells

```bash
sudo nano /etc/profile
```

Add the following text at the end of the file

```bash
if [ -n "$SSH_CLIENT" ]; then
        echo -e 'Login details:\n  - Hostname:'  `hostname -f` '\n  - Date:' "`date`" '\n  - User:' "`who -m`" | mail -s "Login on `hostname` from `echo $SSH_CLIENT | awk '{print $1}'`" username@gmail.com
fi
```

## Proxmox - Virtualization server

### Proxmox - OS configuration

The following subsections from [General](#general) section should be performed in this order:

- [SSH configuration](#ssh-configuration)
- [Update system timezone](#update-system-timezone)
- [Generate Gmail App Password](#generate-gmail-app-password)
- [Configure Postfix Server to send email through Gmail](#configure-postfix-server-to-send-email-through-gmail)
- [Mail notifications for SSH dial-in](#mail-notifications-for-ssh-dial-in)

### Proxmox - NTP time server

Because clock accuracy within a VM is still really bad, I chose the barebone server where the virtualization server is running as my local NTP server. It's not ideal but until I decide to move the firewall from a VM to a dedicated HW this will have to do. I tried running NTP server on the pfSense VM but it acted strange.

Follow the instructions from subsection [[Ubuntu - Synchronize time with ntpd](#ubuntu---synchronize-time-with-ntpd) to install NTP server then make the modifications below.

Edit NTP server configuration file

```bash
sudo nano /etc/ntp.conf
```

Replace line

```bash
server 192.168.0.2 prefer iburst
```

with lines below.

```bash
server time1.google.com iburst
server time2.google.com iburst
server time3.google.com iburst
server time4.google.com iburst
```

Add the following lines to provide your current local time as a default should you temporarily lose Internet connectivity.

```bash
server 127.127.1.0
fudge 127.127.1.0 stratum 10
```

Configure NTP to act as time server for local LAN and VPN

```bash
# Allow LAN and VPN machines to synchronize with this ntp server
restrict 192.168.0.0 mask 255.255.255.0 nomodify notrap
restrict 192.168.1.0 mask 255.255.255.0 nomodify notrap
```

Restart NTP server and verify that it's running correctly

```bash
sudo service ntp stop
sudo service ntp start
sudo service ntp status
```

Verify time synchronization status with each defined server or pool and look for `*` near the servers listed by command below. Any server which is not marked with `*` is not syncronized.

```bash
ntpq -pn
```

### Proxmox - PCI Passthrough configuration

This section contains information that are specific to the HW on my server. Please keep in mind that you have to adapt the steps here to match the HW configuration of your own server.

Enable IOMMU

```bash
nano /etc/default/grub
```

Modify line that starts with `GRUB_CMDLINE_LINUX_DEFAULT` to

```bash
GRUB_CMDLINE_LINUX_DEFAULT="quiet intel_iommu=on iommu=pt pcie_acs_override=downstream,multifunction"
```

Update Grub by running command:

```bash
sudo update-grub
```

Reboot machine.

Verify `IOMMU` is enabled by running

```bash
sudo dmesg | grep -e DMAR -E IOMMU 
```

There should be a message that looks like `"DMAR: IOMMU enabled"`

Add to file `/etc/modules` the following lines and save it

```bash
vfio
vfio_iommu_type1
vfio_pci
vfio_virqfd
```

Check if IOMMU Interrupt remapping is needed by executing `sudo dmesg | grep 'remapping'`. If it shows `DMAR-IR: Enabled IRQ remapping in x2apic mode` it means that IOMMU Interrupt remapping is not needed.

### Proxmox - UPS monitoring software

In order to communicate with existing [ups](https://www.cyberpower.com/eu/ro/product/sku/cp1500epfclcd), I use the business version of the monitoring software offered by CyberPower called `CyberPower Panel Business V4`.

Download and install the latest 64bit version for Linux of [CyberPower Panel Business V4](https://www.cyberpowersystems.com/products/software/power-panel-business/). At the time this document was written the latest version was 4.7.0. The download link and the name of the script might change.

```bash
wget https://dl4jz3rbrsfum.cloudfront.net/software/ppb470-linux-x86_x64.sh
```

Make the script executable.

```bash
chmod +x ppb470-linux-x86_x64.sh
```

Execute the script in order to install the software.

```bash
sudo ./ppb470-linux-x86_x64.sh
```

Choose `5` or press `Enter` to select English as language. Confirm installation by pressing `o`.

In case the software is already installed on the system, the installer will detect this and will ask to to choose to update existing installation( option`1`) or make a new one(option `2`).

After agreeing with license, make sure to select local(option `1`) not remote version.

After finishing the installation, access the [web page](http://192.168.0.2:3052/local/login), login with default credentials and continue the configuration on the web interface. As long as the UPS is connected via the USB port to the server, it should be detected automatically by the application.

- user: admin
- pass: admin

#### SETTING -> NOTIFICATION CHANNELS

- Enable notification by email
- **Provider:** Other
- **SMTP server:** smtp.gmail.com
- **Connection Security:** SSL
- **Service port:** 465
- **Sender name:** UPS Serenity
- **Sender email:** personal email address
- **User name:** personal email address
- **Pass:** Gmail password. See [Generate Gmail App Password](#generate-gmail-app-password) subsection for details.

#### SETTING -> SNMP SETTINGS

Enable `SNMPv1` settings and make sure `SNMP Local Port` is `161`.

Create the public and private groups under SNP v1 profiles. Link them to IP address `0.0.0.0` and set them to read/write.

This means any computer on the network can query using SNMP protocol information from the UPS. It is usefull for integrating the UPS in [HomeAssistant - Home automation server](#homeassistant---home-automation-server).

### Proxmox - VNC client access configuration

It is possible to enable the VNC access for use with usual VNC clients as [RealVNC](https://www.realvnc.com/), [TightVNC](https://www.tightvnc.com/) or [Remmina](https://remmina.org/) Detailed information can be found [here](https://pve.proxmox.com/wiki/VNC_Client_Access)

VNC service for each vm can be accessed using `serenity.local:5900+display_number`. I use the following schema to determine the port for each VM: `6000+last 3 digits of IP`

Add in the VM´s configuration file `/etc/pve/local/qemu-server/<KVM ID>.conf` a line which specifies the VNC display number.

```script
pfSense(firewall.local): args: -vnc 0.0.0.0:101
PiHole (pihole.local): args: -vnc 0.0.0.0:203
TrueNAS (storage.local): args: -vnc 0.0.0.0:214
HomeAssistant (ha.local): args: -vnc 0.0.0.0:200
Hercules (hercules.local): args: -vnc 0.0.0.0:201
Nextcloud (nextcloud.local): args: - vnc 0.0.0.0:202
Windows11 (win10.local): args: -vnc 0.0.0.0:204
ArchLinux (archlinux.local): args: -vnc 0.0.0.0:205
UbuntuWorkstation (linux.local): args: -vnc 0.0.0.0:206
test-server1 (test-server1.local): args: -vnc 0.0.0.0:207
test-server2 (test-server2.local): args: -vnc 0.0.0.0:208
test-server3 (test-server3.local): args: -vnc 0.0.0.0:209
LinuxMint (mint.local): args: -vnc 0.0.0.0:210
Android-x86 (android.local): args: -vnc 0.0.0.0:211
KaliLinux (kali.local): args: -vnc 0.0.0.0:212
CodeServer (code.local): args: -vnc 0.0.0.0:213
WordPress(wordpress.local): args: - vnc 0.0.0.0:215
```

Reboot the VM to take into account the new configuration.

## pfSense - Firewall, DHCP and NTP server

### pfSense - VM configuration

- VM id: 100
- HDD: 32GB
- Sockets: 1
- Cores: 2
- RAM:
  - Min: 2048
  - Max: 2048
  - Ballooning Devices: enabled
- Machine: q35
- PCI Device
  - 0000:04:00.0 -> number located with `lspci` and search for `"Ethernet controller: Intel Corportation I350 Gigabit Network Connection`
  - All functions: enabled
  - ROM-Bar: enabled
- Network
  - LAN MAC address: e4:11:5b:97:04:B9
  - WAN: connected to Internet provider
  - Static ip assigned in pfSense: 192.168.0.1
  - Local domain record in piHole: pfsense .local
- Options:
  - Start at boot: enabled
    - Start/Shutdown order: oder=1,up=55
- OS: [pfSense+](https://www.pfsense.org/download/)

### pfSense - Setup

The server has a dedicated Intel Corporation I350 Gigabit Network adaptor with two interfaces which is passed to this VM. The board has to interfaces which are configured below:

- WAN interface -> PPoE
- LAN interface -> Ethernet connection

The LAN interface is physically located on the board near the text written on the metal plate.

Download [pfSense+](https://www.pfsense.org/download/), connect it to a CD-ROM on the VM and follow the installation procedure. Below are several parameters which I have customized during the installation procedure.

**Interface assignment:**

- igb0 - WAN - physical interface
  - Description: WAN
  - IPv4 Configuration Type: PPoe
- igb1 - LAN - physical interface
  - Description: LAN
  - IPv4 Configuration Type: Static IPv4
  - IPv4 Address: 192.168.0.1 / 24
- tun_wg0 - VPN - virtual interface
  - Description: VPN
  - MTU: 1420
  - MSS: 1420
  - IPv4 Configuration Type: Static IPv4
  - IPv4 Address: 192.168.1.1 / 24

**Hostname:** pfSense

**Domain:** localdomain - [TODO] Check if domain is correctly configured

**DNS Servers:** 192.168.0.103

**Timezone:** Europe/Bucharest

**Theme:** pfSense-dark

**Installed packages:**

- acme
- bandwith
- Status_Traffic_Totals
- Wireguard

### Firewall / NAT / Outbound

The configuration is done trough web interface in section `Firewall / NAT / Outbound`.

Select mode `Hybrid Outbound NAT rule generation`  in `Outbound NAT Mode` section.

- Rule for NAT anything out from firewall itself
  - Disabled: Unchecked
  - Do not NAT: Unchecked
  - Interface: WAN (make one of these rules for each WAN)
  - Protocol: any
  - Source: This Firewall (self)
  - Destination: any
  - Not: Unchecked
  - Translation Address: Interface Address
  - Port or Range: Blank
  - Description: NAT anything out from the firewall itself

### Firewall / NAT / Port Forward

The following NAT rules have been configured in pfSense. The rules marked with italic are disabled. The rules marked with normal font are active.

The configuration is done trough web interface in section `Firewall / NAT / Port Forward`

- Rule for Plex web connection
  - Interface: WAN
  - Address Family: IPv4
  - Protocol: TCP
  - Destination: WAN address
  - Destination port range: 32400 - 32400
  - Redirect target IP: Single Host - 192.168.0.101
  - Redirect target port: Other - 32400
  - Description: Plex web connection
- Rule for Transmission - Torrent client
  - Interface: WAN
  - Address Family: IPv4
  - Protocol: TCP/UDP
  - Destination: WAN address
  - Destination port range: 51413 - 51413
  - Redirect target IP: Single Host - 192.168.0.101
  - Redirect target port: Other - 51413
  - Description: Transmission - Torrent client
- Rule for SWAG - Let's Encrypt
  - Interface: WAN
  - Address Family: IPv4
  - Protocol: TCP
  - Destination: WAN address
  - Destination port range: HTTP
  - Redirect target IP: Single Host - 192.168.0.101
  - Redirect target port: HTTP
  - Description: SWAG - Let's Encrypt
- [DISABLED] *Rule for Hercules - Remote Desktop Connection to Windows 10 VM*
  - Interface: WAN
  - Address Family: IPv4
  - Protocol: TCP
  - Destination: WAN address
  - Destination port range: MS RDP
  - Redirect target IP: Single Host - 192.168.0.104
  - Redirect target port: Other - MS RDP
  - Description: Remote Desktop Connection to Windows 10 VM
- Rule for Hercules - HTTPS port forwarding
  - Interface: WAN
  - Address Family: IPv4
  - Protocol: TCP
  - Destination: WAN address
  - Destination port range: HTTPS(443)
  - Redirect target IP: Single Host - 192.168.0.101
  - Redirect target port: Other - HTTPS(443)
  - Description: Hercules - HTTPS port forwarding
- Rule for Hercules - SSH
  - Interface: WAN
  - Address Family: IPv4
  - Protocol: TCP
  - Destination: WAN address
  - Destination port range: Other - 8022 - 8022
  - Redirect target IP: Single Host - 192.168.0.101
  - Redirect target port: Other - 8022
  - Description: Hercules - SSH(22)
- [DISABLED] *Rule for HomeAssistant - MQQT*
  - Interface: WAN
  - Address Family: IPv4
  - Protocol: TCP
  - Destination: WAN address
  - Destination port range: Other - 1883 - 1883
  - Redirect target IP: Single Host - 192.168.0.100
  - Redirect target port: Other - Other - 1883
  - Description: HomeAssistant - MQQT
- [DISABLED] *Rule for SistemVideo - HTTP*
  - Interface: WAN
  - Address Family: IPv4
  - Protocol: TCP
  - Destination: WAN address
  - Destination port range: Other - 82 - 82
  - Redirect target IP: Single Host - 192.168.0.8
  - Redirect target port: Other 8000
  - Description: SistemVideo - HTTP
- [DISABLED] *Rule for SistemVideo - HTTPS*
  - Interface: WAN
  - Address Family: IPv4
  - Protocol: TCP
  - Destination: WAN address
  - Destination port range: MS DOS(445)
  - Redirect target IP: Single Host - 192.168.0.8
  - Redirect target port: Other - HTTPS(443)
  - Description: SistemVideo - HTTPS
- Sistem video - RTSP
  - Interface: WAN
  - Address Family: IPv4
  - Protocol: TCP
  - Destination: WAN address
  - Destination port range: Other - 554 - 554
  - Redirect target IP: Single Host - 192.168.0.8
  - Redirect target port: Other - Other - 554
  - Description: Sistem video - RTSP
- Sistem video - DDMS - UDP
  - Interface: WAN
  - Address Family: IPv4
  - Protocol: UDP
  - Destination: WAN address
  - Destination port range: Other - 37778 - 37778
  - Redirect target IP: Single Host - 192.168.0.8
  - Redirect target port: Other - Other - 37778
  - Description: Sistem video - DDMS - UDP
- Sistem video - DDMS - TCP
  - Interface: WAN
  - Address Family: IPv4
  - Protocol: TCP
  - Destination: WAN address
  - Destination port range: Other - 37777 - 37777
  - Redirect target IP: Single Host - 192.168.0.8
  - Redirect target port: Other - Other - 37777
  - Description: Sistem video - DDMS - TCP
- [DISABLED] *IP150_HTTPS*
  - Interface: WAN
  - Address Family: IPv4
  - Protocol: TCP
  - Destination: WAN address
  - Destination port range: Other - 444 - 444
  - Redirect target IP: Single Host - 192.168.0.3
  - Redirect target port: Other - HTTPS(443)
  - Description: IP150_HTTPS
- IP150 NeWare
  - Interface: WAN
  - Address Family: IPv4
  - Protocol: TCP
  - Destination: WAN address
  - Destination port range: Other - 10000 - 10000
  - Redirect target IP: Single Host - 192.168.0.3
  - Redirect target port: Other - Other - 10000
  - Description: IP150 NeWare

### pfSense - DHCP server setup

This machine acts as a DHCP server for my entire local network.

The configuration is done trough web interface in section `Services / DHCP Server / LAN`. Configuration parameters marked with italic below are set-up during initial configuratioon and cannot be changed, but I tought it was worth mentioning them.

**Subnet:** 192.168.0.0

**Subnet mask:** 255.255.255.0

**Available Range:** 192.168.0.150 - 192.168.0.200

**DNS servers:**

- 192.168.0.103
- 8.8.8.8

 **Gateway:** 192.168.0.1

 **Domain name:** local

 **NTP Server 1:** 192.168.0.2

**DHCP Static Mapping:**

```text
MAC address    IP address  Hostname         Description
34:97:f6:5a:be:cb 192.168.0.2   serenity             Proxmox server  
00:19:ba:0d:80:50 192.168.0.3   paradox              IP150 - Modul access internet de la centrala alarma Paradox  
54:a0:50:89:84:e8 192.168.0.4   adi                  Laptop personal Adi - ASUS ROG - Interfata wired  
80:19:34:a3:3e:e6 192.168.0.5   adiw                 Laptop personal Adi - ASUS ROG - interfata wireless  
d4:3b:04:67:e2:4c 192.168.0.6   work_adi_wireless    Laptop work Adi - Dell Precision 7530 - Interfata wireless  
c8:f7:50:38:3c:ac 192.168.0.7   work_adi_wired       Laptop work Adi - Dell Precision 7530 - Interfata wired  
14:a7:8b:d3:89:c5 192.168.0.8   ispy                 iSpy - Sistemul video exterior  
ac:d6:18:42:5d:63 192.168.0.9   adi_phone            Telefon mobil Adi - OnePlus 9 Pro  
30:ab:6a:57:e3:41 192.168.0.11  oli_phone            Telefon mobil Oli - Samsung Galaxy S10  
bc:7a:bf:96:8a:7c 192.168.0.15  adi_father_phone     Telefon mobil Tata Adi - Samsung Galaxy A51  
d8:47:32:f5:dc:e6 192.168.0.36  router               Router wireless - Tp Link Archer C80  
b0:4e:26:eb:8d:8c 192.168.0.37  repeater             Repeater mansarda - Tp Link TL-WA855RE  
d8:0f:99:12:7b:b3 192.168.0.38  tv_living_wireless   TV Living - Sony LED Bravia 138.8cm, 55XE8577 - wireless interface  
f4:f5:d8:05:d2:98 192.168.0.39  chromecast           TV Dormitor Alb - Chromecast  
c4:73:1e:ab:1a:12 192.168.0.40  tv_alb               TV Dormitor Alb - Samsung UE40H5030AW  
04:5d:4b:a0:8d:cd 192.168.0.41  tv_living_wired      TV Living - Sony LED Bravia 138.8cm, 55XE8577 - wired interface  
10:3d:1c:c1:bf:ec 192.168.0.46  work_oli             Laptop work Oli - Interfata wireless  
b8:70:f4:a4:f3:bd 192.168.0.99  acer_laptop          Laptop Acer Aspire - wired interface  
de:5c:a6:b6:4a:aa 192.168.0.100 ha                   Home Assistant VM  
c2:32:6d:99:f9:76 192.168.0.101 hercules             Ubuntu Server VM - used for running services in Docker  
86:11:99:9f:ff:b9 192.168.0.102 nextcloud            Ubuntu Server VM - used for hosting Nextcloud  
62:1b:ea:05:7f:1c 192.168.0.103 pihole               PhiHole VM - ad blocking filter, local DNS and DNS resolver  
02:d0:7f:f8:61:1c 192.168.0.104 win                  VM running Windows 11  
9a:ce:ab:cb:03:43 192.168.0.106 linux                VM running Ubuntu 20.10 Desktop  
d6:3d:c3:76:fc:ed 192.168.0.107 test-server1         Test server 1 running Ubuntu server 20.10  
6e:91:2f:17:b3:8d 192.168.0.108 test-server2         Test server 2 running Ubuntu server 20.10  
82:36:62:1f:59:2f 192.168.0.109 test-server3         Test server 3 running Ubuntu server 20.10  
7a:0d:69:93:42:6c 192.168.0.110 mint                 VM running LinuxMint Desktop  
26:8d:6e:7b:b6:b3 192.168.0.111 android              VM running Android X86 VM for development testing purposes  
ae:88:40:3c:fb:ce 192.168.0.112 kali                 VM running Kali Linux Desktop  
0e:04:4b:34:47:c4 192.168.0.113 code                 VM running Ubuntu server 20.10 used for remote code development  
fe:17:d2:92:c8:74 192.168.0.114 storage              VM used for storage management running TrueNAS Scale 
2a:56:f4:07:5d:3d 192.168.0.115 wordpress            Ubuntu Server VM - used for hosting Wordpress 
70:ee:50:55:0e:58 192.168.0.234 termostat            Termonstat Netatmo - NTH01-EN-EU  
70:03:9f:47:4d:4e 192.168.0.243 gate                 Switch Sonoff ESP_474D4E - poarta auto  
b4:e6:2d:15:7d:d0 192.168.0.244 sonoff_living        Switch  Sonoff ESP_157DD0 - Lampa canapea living  
bc:dd:c2:0f:5b:7c 192.168.0.245 sonoff_dormitor      Switch Sonoff ESP_0F5B7C - Lampi dormitor mare  
70:66:55:0d:b1:02 192.168.0.246 clima_masterbedroom  Clima dormitor mare - Daikin BRP069B43  
70:66:55:0d:5e:6a 192.168.0.247 clima_dormitor       Clima dormitor alb - Daikin BRP069B43  
70:66:55:0d:86:f5 192.168.0.248 clima_living         Clima living - Daikin BRP069B43  
40:31:3c:ab:e0:69 192.168.0.249 vacuum               Aspirator - Xiaomi Roborock S50
```

### pfSense - OpenVPN setup

## piHole - All-around DNS solution server

### piHole - VM configuration

### piHole - OS Configuration

The following subsections from [General](#general) section should be performed in this order:

- [SSH configuration](#ssh-configuration)
- [Ubuntu - Synchronize time with ntpd](#ubuntu---synchronize-time-with-ntpd)
- [Update system timezone](#update-system-timezone)
- [Correct DNS resolution](#correct-dns-resolution)
- [Generate Gmail App Password](#generate-gmail-app-password)
- [Configure Postfix Server to send email through Gmail](#configure-postfix-server-to-send-email-through-gmail)
- [Mail notifications for SSH dial-in](#mail-notifications-for-ssh-dial-in)

### piHole - Setup

### piHole - Ubound as a recursive DNS server

### piHole - Local DNS configuration

## TrueNAS - Storage management server

### TrueNAS - OS Configuration

### TrueNAS - VM configuration

- VM id: 102
- HDD: 32GB
- Sockets: 1
- Cores: 2
- RAM:
  - Min: 8192
  - Max: 16384
  - Ballooning Devices: enabled
- Machine: q35
- SCSI Controller: VirtIO SCSI
- Network
  - LAN MAC address: fe:17:d2:92:c8:74
  - Static ip assigned in pfSense: 192.168.0.114
  - Local domain record in piHole: storage .local
- Options:
  - Start at boot: enabled
  - Start/Shutdown order: oder=3,up=60
- OS: [TrueNAS Scale](https://www.truenas.com/download-tn-scale/)

### TrueNAS - HDD passtrough

It is not recommended to passtrough disks by they `sdax` name becaus the operating system can change it. The safest approach is to passtrough the disks by their id. Use following command to list the id of each disk.

```bash
ls -l /dev/disk/by-id/
```

Find the links that matches each drive

```bash
/dev/disk/by-id/ata-WDC_WD7500BPVT-22HXZT1_WD-WX91A61Y1825 -> ../../sdd -> 750GB
/dev/disk/by-id/ata-HGST_HTS721010A9E630_JR10006P0VSENF -> ../../sda -> 1TB
/dev/disk/by-id/ata-HGST_HTS721010A9E630_JR10006P0VSMXF -> ../../sdc -> 1TB
/dev/disk/by-id/ata-WDC_WD5000AZRX-00A8LB0_WD-WMC1U5239721 -> ../../sdb -> 500GB
```

Add the disk to VM by executing the commands below in Proxmox host shell

```bash
sudo qm set 102 -scsi1 /dev/disk/by-id/ata-WDC_WD7500BPVT-22HXZT1_WD-WX91A61Y1825
sudo qm set 102 -scsi2 /dev/disk/by-id/ata-HGST_HTS721010A9E630_JR10006P0VSENF
sudo qm set 102 -scsi3 /dev/disk/by-id/ata-HGST_HTS721010A9E630_JR10006P0VSMXF
sudo qm set 102 -scsi4 /dev/disk/by-id/ata-WDC_WD5000AZRX-00A8LB0_WD-WMC1U5239721
```

The outpot of each commands should be

```bash
update VM 102: -scsi1 /dev/disk/by-id/ata-WDC_WD7500BPVT-22HXZT1_WD-WX91A61Y1825
update VM 102: -scsi2 /dev/disk/by-id/ata-HGST_HTS721010A9E630_JR10006P0VSENF
update VM 102: -scsi3 /dev/disk/by-id/ata-HGST_HTS721010A9E630_JR10006P0VSMXF
update VM 102: -scsi4 /dev/disk/by-id/ata-WDC_WD5000AZRX-00A8LB0_WD-WMC1U5239721
```

Check if each disk has been attached succesfully

```bash
sudo grep WX91A61Y1825 /etc/pve/qemu-server/102.conf
sudo grep JR10006P0VSENF /etc/pve/qemu-server/102.conf
sudo grep JR10006P0VSMXF /etc/pve/qemu-server/102.conf
sudo grep WMC1U5239721 /etc/pve/qemu-server/102.conf
```

Output of each of the above command should be

```bash
scsi1: /dev/disk/by-id/ata-WDC_WD7500BPVT-22HXZT1_WD-WX91A61Y1825,size=732574584K
scsi2: /dev/disk/by-id/ata-HGST_HTS721010A9E630_JR10006P0VSENF,size=976762584K
scsi3: /dev/disk/by-id/ata-HGST_HTS721010A9E630_JR10006P0VSMXF,size=976762584K
scsi4: /dev/disk/by-id/ata-WDC_WD5000AZRX-00A8LB0_WD-WMC1U5239721,size=488386584K
```

Make sure to reboot the host server if the HDD's were previously managed by it otherwise you will not be able to add the new NFS shares from TrueNAS

### TrueNAS - Setup

Follow the installation guide from [here](https://www.truenas.com/docs/scale/).

Once the installation is completed, open the web interface and continue the rest of the configuration there - [https://192.168.0.114/](https://192.168.0.114/)

Make the following configuration in each page below.

#### System Settings -> General

Remove existing NTP servers and add local NPT server(192.168.0.2) with only option selected `iBurst` and Min/Max Pool set to 6/10.

Change `Timezone` in `Localication` to `Europe/Bucharest`

#### System Settings -> Services

Activate `SSH` service and make sure it is marked to be started automatically. Press the configure button and make sure `Log in as Root with Password` and `Allow Password Authentication` are unckeched.

#### Credentials -> Local Users

Add a new user called `sitram` with UID `1000`

Add my personal public key to user `root` so that I can log is with SSH securely.

#### Credentials -> Local Groups

Add a new group called `sitram` with GID `1000`

#### Network

In `Global Configuration` section change

- Hostname: `storage`
- Domain: `local`
- DNS: `192.168.0.101` and `8.8.8.8`
- Default Gateway: `192.168.0.1`

#### Shares

- Windows (SMB) Shares
  - Share 1
    - Name: `data`
    - Path: `/mnt/tank1/data`
    - Description: `Storage for critical data`
  - Share 2
    - Name: `media`
    - Path: `/mnt/tank2/media`
    - Description: `Storage for various media files(movies, tv series, music, torrents etc)`
- Unix (NFS) Shares
  - Share 1
    - Path: `/mnt/tank1/backup`
    - Description: `Backup for HomeLab VM's and CT's`
    - Maproot User: `root`
    - Maproot Group: `root`
    - Authorized Hosts and IP address: ``
  - Share 2
    - Path: `/mnt/tank1/data`
    - Description: `Storage for critical data`
    - Maproot User: `root`
    - Maproot Group: `root`
    - Authorized Hosts and IP address: `192.168.0.101` and `192.168.0.2` and `192.168.0.102` and `192.168.0.105` and `192.168.0.115` and `192.168.0.5` and `192.168.0.4`
  - Share 3
    - Path: `/mnt/tank2/media`
    - Description: `Storage for various media files(movies, tv series, music, torrents etc)`
    - Maproot User: `root`
    - Maproot Group: `root`
    - Authorized Hosts and IP address: ``
  - Share 4
    - Path: `/mnt/tank2/proxmox`
    - Description: `Storage for ISO and CT for Proxmox`
    - Maproot User: `root`
    - Maproot Group: `root`
    - Authorized Hosts and IP address: `192.168.0.2`
  - Share 5
    - Path: `/mnt/nicusor`
    - Description: `Personal storage for Nicusor Maciu`
    - Maproot User: `root`
    - Maproot Group: `root`
    - Authorized Hosts and IP address: `192.168.0.102` and `192.168.0.2` and `192.168.0.5` and `192.168.0.4` and `192.168.0.105`

## HomeAssistant - Home automation server

### HomeAssistant - VM configuration

- VM id: 104
- HDD:
  - don’t make any changes because it will be changed later with the Home Assistant QCOW2 installation file
- Sockets: 1
- Cores: 2
- RAM:
  - Min: 4084
  - Max: 4084
  - Ballooning Devices: enabled
- Machine: i440fx
- BIOS OVMF (UEFI)
- SCSI Controller: VirtIO SCSI
- Network
  - LAN MAC address: DE:5C:A6:B6:4A:AA
  - Static ip assigned in pfSense: 192.168.0.100
  - Local domain record in piHole: ha .local
- Options:
  - Start at boot: enabled
  - Start/Shutdown order: oder=6
- OS: [Home Assistant Operating System](https://www.home-assistant.io/installation/linux)

### HomeAssistant - Installation and setup

Download the QCOW2 image file from [Home Assistant Operating System](https://www.home-assistant.io/installation/linux) and upload it to Proxmox host via SSH in the `/root` home folder.

After the transfer completes, go back into the Proxmox web interface, click on the Proxmox server, and then Shell. To import the Home Assistant installation file to the VM that was created, enter the following command:

```bash
qm importdisk 104 /root/[hassos_file_name] local-lvm --format qcow2
```

When the import finishes, it should show that it was successfully imported as an unused disk.

```bash
Successfully imported disk as 'unused0:local-lvm:vm-104-disk-2'
```

Go back into the Home Assistant VM and then go into `Hardware`. The unused disk with the installation file would be at the bottom as `Unused Disk 0`. Click on the current active Hard Disk, `Hard Disk (scsi0)`, then click on `Detach`, and on the pop up click on `Yes`. That hard disk would then show up at the bottom as `unused disk 1`. Select that disk, then click on `Remove` and then click on `Yes`. Now, the `Unused Disk 0`, which is the one with the Home Assistant installation, double click it, and on the pop-up, click on Add.

The hard disk, by default, would only have 6GB available. So, to make it larger (32GB Recommended), click on `Resize disk` and add the additional amount that you want to add to the 6GB already available.

The configuration is now completed After powering on the Home Assistant VM, go into `Console` to verify that the installation is working as expected. The process can take several minutes. After the installation is finalized, go to `ha.local:8123`, and the Home Assistant initial configuration would come up.

### HomeAssistant - Other plugins

### HomeAssistant - Mosquitto broker(MQTT)

Open `Supervisor -> Add-on Store` and search for `Mosquitto broker` addon and install it.

Click `Mosquitto broker` and continue configuration there

- Info tab
  - Make sure `Start on boot`, `Watchdog` and `Auto update` options are active
- Configuration tab
  - add the following configuration

    ```yaml
    logins:
      - username: ha_mqtt
        password: HaMqttPass_123
    customize:
      active: false
      folder: mosquitto
    certfile: fullchain.pem
    keyfile: privkey.pem
    require_certificate: false
    ```

  - Normal MQTT TCP port - `1833`
  - MQTT over WebSocker port - `1884`
  - Normal MQTT with SSL port - `8883`
  - MQTT over WEbSocker with SSL - `8884`

Press the `Start`* button on the info page of the integration and check the `Log` section to make sure HomeAssistant connects succesfully to Paradox Alarm.

Add the following code in `configurations.yam`l file. Sensitive information is located in a separate file called `secrets.yaml`.

```yaml
# Configuration for connection to mqtt server on home server
mqtt:
  discovery: true
  discovery_prefix: homeassistant
  broker: !secret mqtt_host
  port: 1883
  client_id: home-assistant-1
  keepalive: 60
  username: !secret mqtt_username
  password: !secret mqtt_password
```

### HomeAssistant - Paradox Alarm integration

In order to communicated with Paradox Alarm you need the following preconditions:

- Pannels PC password
- IP150 connection connected to the Alarm interface
- Mosquitto broker addon installed and configured as described in section
[HomeAssistant - Mosquitto broker(MQTT)](#homeassistant---mosquitto-brokermqtt)
- Install an additional

Open `Supervisor -> Add-on Store` and click the three dots in the upper right corner. Select `Repositories` and add repository for `Paradox Alarm Interface Hass.io` from `https://github.com/ParadoxAlarmInterface/hassio-repository`

There should be 3 new integrations available in `Supervisor -> Add-on Store` section at the bottom of the page.

Click `Paradox Alarm Interface` and continue configuration there

- Info tab
  - Make sure `Start on boot`, `Watchdog` and `Auto update` options are active
- Configuration tab - add the following configuration. The configuration was made using the wiki from [here](https://github.com/ParadoxAlarmInterface/pai/wiki)

    ```yaml
    LOGGING_LEVEL_CONSOLE: 20
    LOGGING_LEVEL_FILE: 40
    CONNECTION_TYPE: IP
    SERIAL_PORT: /dev/ttyUSB0
    SERIAL_BAUD: 9600
    IP_CONNECTION_HOST: 192.168.0.3
    IP_CONNECTION_PORT: 10000
    IP_CONNECTION_PASSWORD: paradox
    KEEP_ALIVE_INTERVAL: 10
    LIMITS:
      zone: auto
      user: 1-10
      door: ''
      pgm: ''
      partition: '1'
      module: ''
      repeater: ''
      keypad: ''
      key-switch: ''
    SYNC_TIME: true
    SYNC_TIME_MIN_DRIFT: 120
    PASSWORD: 'xxx' -> replace with the panel PIN
    MQTT_ENABLE: true
    MQTT_HOST: 192.168.0.100
    MQTT_PORT: 1883
    MQTT_KEEPALIVE: 60
    MQTT_USERNAME: ha_mqtt
    MQTT_PASSWORD: HaMqttPass_123
    MQTT_HOMEASSISTANT_AUTODISCOVERY_ENABLE: true
    COMMAND_ALIAS:
      arm: partition all arm
      disarm: partition all disarm
    MQTT_COMMAND_ALIAS:
      armed_home: arm_stay
      armed_night: arm_sleep
      armed_away: arm
      disarmed: disarm
    HOMEASSISTANT_NOTIFICATIONS_EVENT_FILTERS:
      - live,alarm,-restore
      - live,trouble,-clock
      - live,tamper
    PUSHBULLET_CONTACTS: []
    PUSHBULLET_EVENT_FILTERS:
      - live,alarm,-restore
      - live,trouble,-clock
      - live,tamper
    PUSHOVER_EVENT_FILTERS:
      - live,alarm,-restore
      - live,trouble,-clock
      - live,tamper
    PUSHOVER_BROADCAST_KEYS: []
    SIGNAL_CONTACTS: []
    SIGNAL_EVENT_FILTERS:
      - live,alarm,-restore
      - live,trouble,-clock
      - live,tamper
    GSM_CONTACTS: []
    GSM_EVENT_FILTERS:
      - live,alarm,-restore
      - live,trouble,-clock
      - live,tamper
    IP_INTERFACE_ENABLE: false
    IP_INTERFACE_PASSWORD: paradox
    DUMMY_EVENT_FILTERS: []
    ```

- host TCP port - `10000`.

Press the `Start` button on the info page of the integration and check the `Log` section to make sure HomeAssistant connects succesfully to Paradox Alarm.

### HomeAssistant - UPS integration

In order to access different parameters of the UPS using the SNMP protocol, certain stepts need to be taken to identify the corresponding OID's.

Download the latest [MIB](https://www.cyberpowersystems.com/products/software/mib-files/) file from CyberPower.

Download and install a MIB browser to edit the file.

- Free MIB Browser
- [MIB Browser](https://www.ireasoning.com/mibbrowser.shtml)
- SNMP Browser.

Choose `File -> Open` and go to the folder where you stored the CyberPower MIB file and select it. Start by selecting your ip address or localhost as the address in the top right box.

Select from the tree explorer `private -> enterprises -> cps -> products -> ups` and double click a `leaf` on the tree to query the OID and return a value. The OID is listed at the bottom left. When double click on the OID, the values are shown on the right hand panel.

The OIDs from CyberPower need the `.0` at the end when used in another application. The values from viewer cannot be copied as they are.

In order to understand the units of an OID, look at the response data. It might be

- an integer
- ticks - e.g. time remaining in my example below
- a series of strings, e.g the 'Status', which  can then be used to develop the value_template in configuration.yaml.

Add the following code in `configurations.yaml` file to be able to monitor some usefull parameters.

```yaml
sensor:
  - platform: snmp
    host: 192.168.0.2
    baseoid: .1.3.6.1.4.1.3808.1.1.1.4.2.1.0
    community: public
    port: 161
    name: UPS Output Voltage
    value_template: '{{ (value | int / 10 ) }}'
    unit_of_measurement: "V"
  - platform: snmp
    host: 192.168.0.2
    baseoid: .1.3.6.1.4.1.3808.1.1.1.4.2.3.0
    community: public
    port: 161
    name: UPS Output Load
    value_template: '{{ (value | float) }}'
    unit_of_measurement: "%"
  - platform: snmp
    host: 192.168.0.2
    baseoid: .1.3.6.1.4.1.3808.1.1.1.1.1.1.0
    community: public
    port: 161
    name: UPS Model
  - platform: snmp
    host: 192.168.0.2
    baseoid: .1.3.6.1.4.1.3808.1.1.1.4.1.1.0
    community: public
    port: 161
    name: UPS Status
    value_template: >
      {% set vals = {'1': 'unknown', '2':'onLine', '3':'onBattery', '4':'onBoost', '5':'sleep', '6':'off', '7':'rebooting'} %}
      {{vals[value]}}
  - platform: snmp
    host: 192.168.0.2
    baseoid:  .1.3.6.1.4.1.3808.1.1.1.3.2.6.0
    community: public
    port: 161
    name: UPS Advanced Status
    value_template: >
      {% set vals = {'1': 'normal', '2':'Over Voltage', '3':'Under Voltage', '4':'Frequency failure', '5':'Blackout'} %}
      {{vals[value]}}
  - platform: snmp
    host: 192.168.0.2
    baseoid: .1.3.6.1.4.1.3808.1.1.1.2.1.1.0
    community: public
    port: 161
    name: UPS Battery Status
    value_template: >
      {% set vals = {'1': 'unknown', '2':'Normal', '3':'Battery Low', '4':'Battery Not Present'} %}
      {{vals[value]}}
  - platform: snmp
    host: 192.168.0.2
    baseoid: .1.3.6.1.4.1.3808.1.1.1.2.2.1.0
    community: public
    port: 161
    name: UPS Battery Capacity Raw
    value_template: '{{ (value | float) }}'
    unit_of_measurement: "%"
  - platform: snmp
    host: 192.168.0.2
    baseoid:  .1.3.6.1.4.1.3808.1.1.1.2.2.2.0
    community: public
    port: 161
    name: UPS Battery Voltage
    value_template: '{{ (value | int / 10 ) }}'
    unit_of_measurement: "V"
  - platform: snmp
    host: 192.168.0.2
    baseoid: .1.3.6.1.4.1.3808.1.1.1.2.2.4.0
    community: public
    port: 161
    name: UPS Run Time Remaining
    value_template: >-
      {% set time = (value | int) | int %}
      {% set minutes = ((time % 360000) / 6000) | int%}
      {% set hours = ((time % 8640000) / 360000) | int %}
      {% set days = (time / 8640000) | int %}
      {%- if time < 60 -%}
        Less then 1 min
        {%- else -%}
        {%- if days > 0 -%}
          {{ days }}d
        {%- endif -%}
        {%- if hours > 0 -%}
          {%- if days > 0 -%}
            {{ ' ' }}
          {%- endif -%}
          {{ hours }}hr
        {%- endif -%}
        {%- if minutes > 0 -%}
          {%- if days > 0 or hours > 0 -%}
            {{ ' ' }}
          {%- endif -%}
          {{ minutes }}min
        {%- endif -%}
      {%- endif -%}
  - platform: template
    sensors:
      ups_battery_capacity:
        unit_of_measurement: "%"
        value_template: "{{ states('sensor.ups_battery_capacity_raw') }}"
        friendly_name: "Battery Capacity"
        icon_template: >
          {% set level = states('sensor.ups_battery_capacity_raw') | float | multiply(0.1) | round(0,"floor") | multiply(10)| round(0) %}
          {% if is_state('sensor.ups_status', 'onLine') and is_state('sensor.ups_battery_capacity_raw' , '100.0' ) %}
            mdi:battery
          {% elif is_state('sensor.ups_status', 'onLine')  %}
            mdi:battery-charging-{{level}}
          {% else %}
            mdi:battery-{{level}}
          {% endif %}
```

Create a new tab in the `Overview` section called `UPS` and add a new `Entities Card` to it with the code below. Make sure an appropiate image with name `ups.png` is loaded in `/config/www/ups`

```yaml
type: entities
entities:
  - entity: sensor.ups_model
    name: Model
    icon: mdi:power-plug
  - entity: sensor.ups_status
    name: Status
    icon: mdi:power
  - entity: sensor.ups_battery_capacity
    name: Battery Capacity
  - entity: sensor.ups_run_time_remaining
    name: Run time remaining
    icon: mdi:av-timer
  - entity: sensor.ups_battery_status
    name: Battery Status
    icon: mdi:car-battery
  - entity: sensor.ups_battery_voltage
    name: Battery Voltage
    icon: mdi:car-battery
  - entity: sensor.ups_output_voltage
    name: Output Volts
    icon: mdi:power-socket-au
  - entity: sensor.ups_output_load
    name: Output Load
    icon: mdi:power-socket-au
  - entity: sensor.ups_advanced_status
    name: Advanced status
header:
  type: picture
  image: /local/ups/ups.png
  tap_action:
    action: none
  hold_action:
    action: none
```

### HomeAssistant - Integration of CCTV cameras

Add the following code in `configurations.yaml` file to be able to access the CCTV cameras connected to the Dahua DVR. Sensitive information is located in a separate file called `secrets.yaml`.

```yaml
# Configuration for CCTV camera with Dahua DVR
camera laterala:
  - platform: generic
    name: Camera laterala
    still_image_url: http://192.168.0.8:8000/cgi-bin/snapshot.cgi?channel=1
    stream_source: rtsp://admin:Darksourcer123@192.168.0.8:554/cam/realmonitor?channel=1&subtype=0
    username: !secret cctv_user
    password: !secret cctv_password
    authentication: digest
    verify_ssl: false
camera spate:
  - platform: generic
    name: Camera spate
    still_image_url: http://192.168.0.8:8000/cgi-bin/snapshot.cgi?channel=2
    stream_source: rtsp://admin:Darksourcer123@192.168.0.8:554/cam/realmonitor?channel=2&subtype=0
    username: !secret cctv_user
    password: !secret cctv_password
    authentication: digest
    verify_ssl: false
camera fata dreapta:
  - platform: generic
    name: Camera fata dreapta
    still_image_url: http://192.168.0.8:8000/cgi-bin/snapshot.cgi?channel=3
    stream_source: rtsp://admin:Darksourcer123@192.168.0.8:554/cam/realmonitor?channel=3&subtype=0
    username: !secret cctv_user
    password: !secret cctv_password
    authentication: digest
    verify_ssl: false
camera fata stanga:
  - platform: generic
    name: Camera fata stanga
    still_image_url: http://192.168.0.8:8000/cgi-bin/snapshot.cgi?channel=4
    stream_source: rtsp://admin:Darksourcer123@192.168.0.8:554/cam/realmonitor?channel=4&subtype=0
    username: !secret cctv_user
    password: !secret cctv_password
    authentication: digest
    verify_ssl: false
```

Open the `Overview` tab and add a new view with the followint configuration:

- Title: `Camere`
- Icon: `mdi:cctv`

 Add 4 `Picture Entity Card` with the following configuration:

- Entity: `camera.camera_fata_dreapta`
- Entity: `camera.camera_laterala`
- Entity: `camera.camera_fata_stanga`
- Entity: `camera.camera_spate`

### HomeAssistant - Google Assistant integration

To use Google Assistant, your Home Assistant configuration has to be externally accessible with a hostname and SSL certificate.

 1. Create a new project in the Actions on Google console.
    - Click `New Project` and give your project a name.
    - Click on the `Smart Home card`, then click the `Start Building` button.
    - Click `Name your Smart Home` action under Q`uick Setup` to give your Action a name - Home Assistant will appear in the Google Home app as `[test] <Action Name>`
    - Click on the Over`view tab at the top of the page to go back.
    - Click `Build your Action`, then click `Add Action(s)`.
    - Add Home Assistant URL: `https://ha.sitram.duckdns.org/api/google_assistant` in the `Fulfillment URL` box.
    - Click `Save`.
    - Click the three little dots (more) icon in the upper right corner, select `Project settings`
    - Make note of the `Project ID` that are listed on the `GENERAL` tab of the `Settings` page.
 2. `Account linking` is required for your app to interact with Home Assistant.
    - Start by going back to the `Overview` tab.
    - Click on `Setup account linking` under the `Quick Setup` section of the `Overview` page.
    - If asked, leave options as they default `No, I only want to allow account creation on my website` and select `Next`.
    - Then if asked, for the `Linking type` select `OAuth` and `Authorization Code`. Click `Next`
    - Enter the following:
      - Client ID: `https://oauth-redirect.googleusercontent.com/r/[YOUR_PROJECT_ID]`. (Replace [`YOUR_PROJECT_ID]` with your project ID from above)
      - Client Secret: Anything you like, Home Assistant doesn’t need this field.
      - Authorization URL: `https://[YOUR HOME ASSISTANT URL:PORT]/auth/authorize.` (Replace [`YOUR HOME ASSISTANT URL:PORT]` with your values.)
      - Token URL (replace with your actual URL): `https://[YOUR HOME ASSISTANT URL:PORT]/auth/token`. (Replace `[YOUR HOME ASSISTANT URL:PORT]` with your values.) Click `Next`, then `Next` again.
    - In the `Configure` your client `Scopes` textbox, type email and click `Add scope`, then type name and click `Add scope` again.
    - Do `NOT` check `Google to transmit clientID and secret via HTTP basic auth header`.
    - Click `Next`, then click `Save`
 3. Select the `Develop` tab at the top of the page, then in the upper right hand corner select the `Test` button to generate the draft version Test App. If you don’t see this option, go to the `Test` tab instead, click on the `Settings` button in the top right below the header, and ensure `On device testing` is enabled (if it isn’t, enable it).
 4. Add the `google_assistant` integration configuration to your `configuration.yaml` file and restart Home Assistant .
 5. Add services in the Google Home App (Note that app versions may be slightly different.)
    - Open the Google Home app.
    - Click the `+` button on the top left corner, click `Set up device`, in the “Set up a device” screen click “Works with Google”. You should have `[test] <Action Name>` listed under ‘Add new’. Selecting that should lead you to a browser to login your Home Assistant instance, then redirect back to a screen where you can set rooms and nicknames for your devices if you wish.
 6. If you want to allow other household users to control the devices:
    - Open the project you created in the [Actions on Google console](https://console.actions.google.com/).
    - Click `Test` on the top of the page, then click Simulator located to the page left, then click the three little dots (more) icon in the upper right corner of the console.
    - Click `Manage user access`. This redirects you to the Google Cloud Platform IAM permissions page.
    - Click `ADD` at the top of the page.
    - Enter the email address of the user you want to add.
    - Click `Select a role` and choose `Project < Viewer`.
    - Click `SAVE`
    - Copy and share the Actions project link `(https://console.actions.google.com/project/YOUR_PROJECT_ID/simulator)` with the new user.
    - Have the new user open the link with their own Google account, agree to the Terms of Service popup, then select `Start Testing`, select `VERSION - Draft` in the dropdown, and click `Done`.
    - Have the new user go to their `Google Assistant` app to add `[test] your app name` to their account.
 7. Enable Device sync
    - If you want to support active reporting of state to Google’s server (configuration option `report_state`) and synchronize Home Assistant devices with the Google Home app (`google_assistant.request_sync service`), you will need to create a service account. It is recommended to set up this configuration key as it also allows the usage of the following command, “Ok Google, sync my devices”. Once you have set up this component, you will need to call this service (or command) each time you add a new device in Home Assistant that you wish to control via the Google Assistant integration. This allows you to update devices without unlinking and relinking an account.
    - Service Account
        - In the Google Cloud Platform Console, go to the [Create Service account key](https://console.cloud.google.com/apis/credentials/serviceaccountkey) page.
        - At the top left of the page next to `Google Cloud Platform logo`, select your project created in the Actions on Google console. Confirm this by reviewing the project ID and it ensure it matches.
        - From the Service account list, select `CREATE SERVICE ACCOUNT`.
        - In the Service account name field, enter a name.
        - In the Service account ID field, enter an ID.
        - From the Role list, select `Service Accounts` > `Service Account Token Creator`.
        - Click `CONTINUE` and then `DONE`. You are returned to the service account list, and your new account is shown.
        - Click the three dots menu under `Actions` next to your new account, and click `Manage keys`. You are taken to a `Keys` page.
        - Click `ADD KEY` then `Create new key`. Leave the `key type` as `JSON` and click `CREATE`. A JSON file that contains your key downloads to your computer.
        - Use the information in this file or the file directly to add to the service_account key in the configuration.
        - Click   .
    - HomeGraph API
        - Go to the [Google API Console](https://console.cloud.google.com/apis/api/homegraph.googleapis.com/overview).
        - At the top left of the page next to `Google Cloud Platform` logo, select your project created in the `Actions` on Google console. Confirm this by reviewing the project ID and it ensure it matches.
        - Click `Enable HomeGraph API`.
        - Try `OK Google, sync my devices` - the Google Home app should import your exposed Home Assistant devices and prompt you to assign them to rooms.

Add the following code in `configurations.yaml` file with the devices in Home Assistant that you wish to control via the Google Assistant integration.

```yaml
# Google assistant integration
google_assistant:
  project_id: smart-home-e8da1
  service_account: !include service_account_google_assistant.json
  report_state: true
  secure_devices_pin: "xxxx" -> replace with alarm panel PIN
  exposed_domains:
    - alarm_control_panel
    - camera
    - climate
  entity_config:
    # Entities exposed to Google Assistant from the alarm_control_panel domain
    alarm_control_panel.toata_casa:
      name: House alarm
      room: Entryway
    # Entities exposed to Google Assistant from camera domain
    camera.camera_fata_dreapta:
      name: Security camera front right
      room: Frontyard
    camera.camera_fata_stanga:
      name: Security camera front left
      room: Frontyard
    camera.camera_laterala:
      name: Security camera lateral
      room: Frontyard
    camera.camera_spate:
      name: Security camera backyard
      room: Back yard
    # Entities exposed to Google Assistant from climate domain
    climate.ac_dormitor_alb:
      name: Guest bedroom AC
      room: Bedroom
    climate.ac_dormitor:
      name: Master Bedroom AC
      room: Master Bedroom
    climate.ac_living:
      name: Living Room AC
      room: Living Room
    climate.netatmo_smart_thermostat:
      name: Thermostat
      room: Living Room
```

Reload HomeAssistant configuration and test that the devices are visible in Home App on your mobile phone.

### HomeAssistant - Recorder integration

In order to reduce the size of the database the make the following changes to the Recorder configuration in `configuration.yaml`. Additional information can be found [here](https://community.home-assistant.io/t/how-to-reduce-your-database-size-and-extend-the-life-of-your-sd-card/205299).

Make sure that all the integration are configured before this step is done.

Only use includes or excludes for history or logbook. Do not use a mix of both in the one integration. The logic is completely busted. The recorder seems ok to mix includes and excludes.

Every time a new integration is added, review the recorder integration and decide if it's worth beeing added to the exclude or include list.

```yaml
# Settings for recorder integration in order to reduce the size of the database
# configuration was done based in information fron https://community.home-assistant.io/t/how-to-reduce-your-database-size-and-extend-the-life-of-your-sd-card/205299
recorder:
  purge_keep_days: 30
  exclude:
    domains:
      - automation
      - binary_sensor
      - camera
      - group
      - sensor
      - sun
      - switch
      - weather
      - zone
  include:
    domains:
      - climate
      - device_tracker
      - light
      - media_player
      - person
      - vacuum
    entities:
      - alarm_control_panel.toata_casa
      - binary_sensor.oneplus_a6013_is_charging
      - binary_sensor.samsung_s10_is_charging
      - sensor.oneplus_a6013_geocoded_location
      - sensor.samsung_s10_geocoded_location
      - sensor.ac_dormitor_alb_inside_temperature
      - sensor.ac_dormitor_inside_temperature
      - sensor.ac_living_inside_temperature
      - sensor.run_status
      - sensor.speedtest_download
      - sensor.speedtest_ping
      - sensor.speedtest_upload
      - sensor.ups_status
      - switch.sonoff_100111e4eb

history:
  include:
    domains:
      - climate
      - device_tracker
      - light
      - media_player
      - person
      - vacuum
    entities:
      - alarm_control_panel.toata_casa
      - binary_sensor.oneplus_a6013_is_charging
      - binary_sensor.samsung_s10_is_charging
      - sensor.oneplus_a6013_geocoded_location
      - sensor.samsung_s10_geocoded_location
      - sensor.ac_dormitor_alb_inside_temperature
      - sensor.ac_dormitor_inside_temperature
      - sensor.ac_living_inside_temperature
      - sensor.run_status
      - sensor.speedtest_download
      - sensor.speedtest_ping
      - sensor.speedtest_upload
      - sensor.ups_status
      - switch.sonoff_100111e4eb

logbook:
  include:
    domains:
      - climate
      - device_tracker
      - light
      - media_player
      - person
      - vacuum
    entities:
      - alarm_control_panel.toata_casa
      - binary_sensor.oneplus_a6013_is_charging
      - binary_sensor.samsung_s10_is_charging
      - sensor.oneplus_a6013_geocoded_location
      - sensor.samsung_s10_geocoded_location
      - sensor.ac_dormitor_alb_inside_temperature
      - sensor.ac_dormitor_inside_temperature
      - sensor.ac_living_inside_temperature
      - sensor.run_status
      - sensor.speedtest_download
      - sensor.speedtest_ping
      - sensor.speedtest_upload
      - sensor.ups_status
      - switch.sonoff_100111e4eb
```

## Nextcloud - Content collaboration server

### Nextcloud - VM configuration

- VM id: 106
- HDD: 60GB
- Sockets: 1
- Cores: 4
- RAM:
  - Min: 2048
  - Max: 8192
  - Ballooning Devices: enabled
- Network
  - MAC address: 86:11:99:9F:FF:B9
  - Static ip assigned in pfSense: 192.168.0.102
  - Local domain record in piHole: nextcloud.local
- Options:
  - Start at boot: enabled
  - Start/Shutdown: order=6
  - QEMU Guest agent: enabled - [Qemu-guest-agent](#qemu-guest-agent)
  - Run guest-trim after a disk move or VM migration: enabled
- OS: Ubuntu Server 21.04 amd64

### Nextcloud - OS Configuration

The following subsections from [General](#general) section should be performed in this order:

- [SSH configuration](#ssh-configuration)
- [Ubuntu - Synchronize time with ntpd](#ubuntu---synchronize-time-with-ntpd)
- [Update system timezone](#update-system-timezone)
- [Correct DNS resolution](#correct-dns-resolution)
- [Generate Gmail App Password](#generate-gmail-app-password)
- [Configure Postfix Server to send email through Gmail](#configure-postfix-server-to-send-email-through-gmail)
- [Mail notifications for SSH dial-in](#mail-notifications-for-ssh-dial-in)

Install the following packages as necessary basis for server operation:

```bash
sudo apt update -q4
sudo apt install -y curl gnupg2 git lsb-release ssl-cert ca-certificates apt-transport-https tree locate software-properties-common dirmngr screen htop net-tools zip unzip bzip2 ffmpeg ghostscript libfile-fcntllock-perl libfontconfig1 libfuse2 socat nfs-common
```

Add the following mounting points to `/etc/fstab/`

```bash
192.168.0.114:/mnt/tank1/data /mnt/data nfs rw 0 0
192.168.0.114:/mnt/nicusor /var/nc_data/nicusor nfs rw 0 0
```

Mount the newly added mount points

```bash
sudo mkdir /mnt/data
sudo mount -a
```

### Nextcloud - Installation and configuration of nginx web server

Add software source

```bash
cd /etc/apt/sources.list.d
sudo echo "deb http://nginx.org/packages/mainline/ubuntu $(lsb_release -cs) nginx" | sudo tee nginx.list
```

In order to be able to trust the sources, use the corresponding keys:

```bash
sudo curl -fsSL https://nginx.org/keys/nginx_signing.key | sudo apt-key add -
sudo apt-get update -q44
```

Ensure that no relics from previous installations disrupt the operation of the webserver

```bash
sudo apt remove nginx nginx-extras nginx-common nginx-full -y --allow-change-held-packages
sudo apt autoremove
```

Ensure the the counterpart (Apache2) of nginx web server is neither active or installed

```bash
sudo systemctl stop apache2.service
sudo systemctl disable apache2.service
```

Install the web server and configure the service for automatic start after a system restart

```bash
sudo apt install -y nginx
sudo systemctl enable nginx.service
```

Backup standard configuration in case we need it for later, create and edit a blank one

```bash
sudo mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak
sudo touch /etc/nginx/nginx.conf
sudo nano /etc/nginx/nginx.conf
```

Copy the following configuration in the text editor.

```bash
user www-data;
worker_processes auto;
pid /var/run/nginx.pid;

events {
        worker_connections 1024;
        multi_accept on;
        use epoll;
}

http {
        server_names_hash_bucket_size 64;
        access_log /var/log/nginx/access.log;
        error_log /var/log/nginx/error.log warn;
        #either use 127.0.0.1 or own subnet
        set_real_ip_from 192.168.0.1/24;
        real_ip_header X-Forwarded-For;
        real_ip_recursive on;
        include /etc/nginx/mime.types;
        default_type application/octet-stream;
        sendfile on;
        send_timeout 3600;
        tcp_nopush on;
        tcp_nodelay on;
        open_file_cache max=500 inactive=10m;
        open_file_cache_errors on;
        keepalive_timeout 65;
        reset_timedout_connection on;
        server_tokens off;
        #either use 127.0.0.1 or own dns server
        resolver 192.168.0.103 valid=30s;
        resolver_timeout 5s;
        include /etc/nginx/conf.d/*.conf;
}
```

Save the file and close it. Restart the web server afterwards and check if the server has been successfully started.

```bash
sudo service nginx restart
sudo service nginx status
```

Create web directories used by Nextcloud

```bash
sudo mkdir -p /var/nc_data
```

[OPTIONAL] Create the web directories used by the SSL certificates

```bash
sudo mkdir -p /var/www/letsencrypt/.well-known/acme-challenge 
sudo mkdir -p /etc/letsencrypt/rsa-certs
sudo mkdir -p /etc/letsencrypt/ecc-certs
```

[OPTIONAL] Update the self signed SSL certificate

```bash
make-ssl-cert generate-default-snakeoil -y
```

Assign the right permissions

```bash
sudo chown -R www-data:www-data /var/nc_data /var/www
```

### Nextcloud - Installation and configuration of PHP 8.0

Perform steps from chapter [Ubuntu - Configure PHP source list](#ubuntu---configure-php-source-list)

Install PHP8.0 and required modules

```bash
sudo apt install -y php8.0-{fpm,gd,mysql,curl,xml,zip,intl,mbstring,bz2,ldap,apcu,bcmath,gmp,imagick,igbinary,redis,smbclient,cli,common,opcache,readline} imagemagick ldap-utils nfs-common cifs-utils
```

Backup original configurations

```bash
sudo cp /etc/php/8.0/fpm/pool.d/www.conf /etc/php/8.0/fpm/pool.d/www.conf.bak
sudo cp /etc/php/8.0/fpm/php-fpm.conf /etc/php/8.0/fpm/php-fpm.conf.bak
sudo cp /etc/php/8.0/cli/php.ini /etc/php/8.0/cli/php.ini.bak
sudo cp /etc/php/8.0/fpm/php.ini /etc/php/8.0/fpm/php.ini.bak
sudo cp /etc/php/8.0/fpm/php-fpm.conf /etc/php/8.0/fpm/php-fpm.conf.bak
sudo cp /etc/php/8.0/mods-available/apcu.ini /etc/php/8.0/mods-available/apcu.ini.bak
sudo cp /etc/ImageMagick-6/policy.xml /etc/ImageMagick-6/policy.xml.bak
```

In order to adapt PHP to the configuration of the system, some parameters are calculated, using the lines below.

```bash
AvailableRAM=$(awk '/MemAvailable/ {printf "%d", $2/1024}' /proc/meminfo)
echo AvailableRAM = $AvailableRAM

AverageFPM=$(ps --no-headers -o 'rss,cmd' -C php-fpm8.0 | awk '{ sum+=$1 } END { printf ("%d\n", sum/NR/1024,"M") }')
echo AverageFPM = $AverageFPM

FPMS=$((AvailableRAM/AverageFPM))
echo FPMS = $FPMS

PMaxSS=$((FPMS*2/3))
echo PMaxSS = $PMaxSS

PMinSS=$((PMaxSS/2))
echo PMinSS = $PMinSS

PStartS=$(((PMaxSS+PMinSS)/2))
echo PStartS = $PStartS
```

Perform the following optimizations

```bash
sudo sed -i "s/;env\[HOSTNAME\] = /env[HOSTNAME] = /" /etc/php/8.0/fpm/pool.d/www.conf
sudo sed -i "s/;env\[TMP\] = /env[TMP] = /" /etc/php/8.0/fpm/pool.d/www.conf
sudo sed -i "s/;env\[TMPDIR\] = /env[TMPDIR] = /" /etc/php/8.0/fpm/pool.d/www.conf
sudo sed -i "s/;env\[TEMP\] = /env[TEMP] = /" /etc/php/8.0/fpm/pool.d/www.conf
sudo sed -i "s/;env\[PATH\] = /env[PATH] = /" /etc/php/8.0/fpm/pool.d/www.conf
sudo sed -i 's/pm.max_children =.*/pm.max_children = '$FPMS'/' /etc/php/8.0/fpm/pool.d/www.conf
sudo sed -i 's/pm.start_servers =.*/pm.start_servers = '$PStartS'/' /etc/php/8.0/fpm/pool.d/www.conf
sudo sed -i 's/pm.min_spare_servers =.*/pm.min_spare_servers = '$PMinSS'/' /etc/php/8.0/fpm/pool.d/www.conf
sudo sed -i 's/pm.max_spare_servers =.*/pm.max_spare_servers = '$PMaxSS'/' /etc/php/8.0/fpm/pool.d/www.conf
sudo sed -i "s/;pm.max_requests =.*/pm.max_requests = 1000/" /etc/php/8.0/fpm/pool.d/www.conf
sudo sed -i "s/allow_url_fopen =.*/allow_url_fopen = 1/" /etc/php/8.0/fpm/php.ini
```

```bash
sudo sed -i "s/output_buffering =.*/output_buffering = 'Off'/" /etc/php/8.0/cli/php.ini
sudo sed -i "s/max_execution_time =.*/max_execution_time = 3600/" /etc/php/8.0/cli/php.ini
sudo sed -i "s/max_input_time =.*/max_input_time = 3600/" /etc/php/8.0/cli/php.ini
sudo sed -i "s/post_max_size =.*/post_max_size = 10240M/" /etc/php/8.0/cli/php.ini
sudo sed -i "s/upload_max_filesize =.*/upload_max_filesize = 10240M/" /etc/php/8.0/cli/php.ini
sudo sed -i "s/;date.timezone.*/date.timezone = Europe\/\Bucharest/" /etc/php/8.0/cli/php.ini
```

```bash
sudo sed -i "s/memory_limit = 128M/memory_limit = 1024M/" /etc/php/8.0/fpm/php.ini
sudo sed -i "s/output_buffering =.*/output_buffering = 'Off'/" /etc/php/8.0/fpm/php.ini
sudo sed -i "s/max_execution_time =.*/max_execution_time = 3600/" /etc/php/8.0/fpm/php.ini
sudo sed -i "s/max_input_time =.*/max_input_time = 3600/" /etc/php/8.0/fpm/php.ini
sudo sed -i "s/post_max_size =.*/post_max_size = 10240M/" /etc/php/8.0/fpm/php.ini
sudo sed -i "s/upload_max_filesize =.*/upload_max_filesize = 10240M/" /etc/php/8.0/fpm/php.ini
sudo sed -i "s/;date.timezone.*/date.timezone = Europe\/\Bucharest/" /etc/php/8.0/fpm/php.ini
sudo sed -i "s/;session.cookie_secure.*/session.cookie_secure = True/" /etc/php/8.0/fpm/php.ini
sudo sed -i "s/;opcache.enable=.*/opcache.enable=1/" /etc/php/8.0/fpm/php.ini
sudo sed -i "s/;opcache.enable_cli=.*/opcache.enable_cli=1/" /etc/php/8.0/fpm/php.ini
sudo sed -i "s/;opcache.memory_consumption=.*/opcache.memory_consumption=128/" /etc/php/8.0/fpm/php.ini
sudo sed -i "s/;opcache.interned_strings_buffer=.*/opcache.interned_strings_buffer=8/" /etc/php/8.0/fpm/php.ini
sudo sed -i "s/;opcache.max_accelerated_files=.*/opcache.max_accelerated_files=10000/" /etc/php/8.0/fpm/php.ini
sudo sed -i "s/;opcache.revalidate_freq=.*/opcache.revalidate_freq=1/" /etc/php/8.0/fpm/php.ini
sudo sed -i "s/;opcache.save_comments=.*/opcache.save_comments=1/" /etc/php/8.0/fpm/php.ini
```

```bash
sudo sed -i "s|;emergency_restart_threshold.*|emergency_restart_threshold = 10|g" /etc/php/8.0/fpm/php-fpm.conf
sudo sed -i "s|;emergency_restart_interval.*|emergency_restart_interval = 1m|g" /etc/php/8.0/fpm/php-fpm.conf
sudo sed -i "s|;process_control_timeout.*|process_control_timeout = 10|g" /etc/php/8.0/fpm/php-fpm.conf
```

```bash
sudo sed -i '$aapc.enable_cli=1' /etc/php/8.0/mods-available/apcu.ini
```

```bash
sudo sed -i "s/rights=\"none\" pattern=\"PS\"/rights=\"read|write\" pattern=\"PS\"/" /etc/ImageMagick-6/policy.xml
sudo sed -i "s/rights=\"none\" pattern=\"EPS\"/rights=\"read|write\" pattern=\"EPS\"/" /etc/ImageMagick-6/policy.xml
sudo sed -i "s/rights=\"none\" pattern=\"PDF\"/rights=\"read|write\" pattern=\"PDF\"/" /etc/ImageMagick-6/policy.xml
sudo sed -i "s/rights=\"none\" pattern=\"XPS\"/rights=\"read|write\" pattern=\"XPS\"/" /etc/ImageMagick-6/policy.xml
```

Restart PHP and nginx and check that they are working correctly

```bash
sudo service php8.0-fpm restart
sudo service nginx restart

sudo service php8.0-fpm status
sudo service nginx status
```

[TODO] For troubleshooting of php-fpm check [here](https://www.c-rieger.de/nextcloud-und-php-troubleshooting/)

### Nextcloud - Installation and configuration of MariaDB database

[OPTIONAL] This step is optional and can be skipped if using MySQL or MariaDB in a docker instance on a dedicated server.

Add software source

```bash
cd /etc/apt/sources.list.d
sudo echo "deb http://ftp.hosteurope.de/mirror/mariadb.org/repo/10.6/ubuntu $(lsb_release -cs) main" | sudo tee mariadb.list
```

In order to be able to trust the sources, use the corresponding keys:

```bash
apt-key adv --recv-keys --keyserver hkps://keyserver.ubuntu.com:443 0xF1656F24C74CD1D8
sudo apt-update -q4
sudo make-ssl-cert generate-default-snakeoil -y
```

Install MariaDB

```bash
sudo apt install -y mariadb-server
```

Harden the database server using the supplied tool "mysql_secure_installation". When installing for the first time, there is no root password, so you can confirm the query with ENTER. It is recommended to set a password directly, the corresponding dialog appears automatically.

```bash
mysql_secure_installation
```

```bash
Enter current password for root (enter for none): <ENTER> or type the password
```

```bash
Switch to unix_socket authentication [Y/n] Y
```

```bash
Set root password? [Y/n] Y
```

```bash
Remove anonymous users? [Y/n] Y
Disallow root login remotely? [Y/n] Y
Remove test database and access to it? [Y/n] Y
Reload privilege tables now? [Y/n] Y
```

Stop the database server and then save the standard configuration

```bash
sudo service mysql stop
sudo mv /etc/mysql/my.cnf /etc/mysql/my.cnf.bak
sudo nano /etc/mysql/my.cnf
```

Copy the following configuration

```ini
[client]
    default-character-set = utf8mb4
    port = 3306
    socket = /var/run/mysqld/mysqld.sock

[mysqld_safe]
    log_error=/var/log/mysql/mysql_error.log
    nice = 0
    socket = /var/run/mysqld/mysqld.sock

[mysqld]
    basedir = /usr
    bind-address = 127.0.0.1
    binlog_format = ROW
    bulk_insert_buffer_size = 16M
    character-set-server = utf8mb4
    collation-server = utf8mb4_general_ci
    concurrent_insert = 2
    connect_timeout = 5
    datadir = /var/lib/mysql
    default_storage_engine = InnoDB
    expire_logs_days = 2
    general_log_file = /var/log/mysql/mysql.log
    general_log = 0
    innodb_buffer_pool_size = 1024M
    innodb_buffer_pool_instances = 1
    innodb_flush_log_at_trx_commit = 2
    innodb_log_buffer_size = 32M
    innodb_max_dirty_pages_pct = 90
    innodb_file_per_table = 1
    innodb_open_files = 400
    innodb_io_capacity = 4000
    innodb_flush_method = O_DIRECT
    innodb_read_only_compressed=OFF
    #Required from MariaDB 10.6, see [link](https://mariadb.com/kb/en/upgrading-from-mariadb-105-to-mariadb-106/#innodb-compressed-row-format)
    key_buffer_size = 128M
    lc_messages_dir = /usr/share/mysql
    lc_messages = en_US
    log_bin = /var/log/mysql/mariadb-bin
    log_bin_index = /var/log/mysql/mariadb-bin.index
    log_error = /var/log/mysql/mysql_error.log
    log_slow_verbosity = query_plan
    log_warnings = 2
    long_query_time = 1
    max_allowed_packet = 16M
    max_binlog_size = 100M
    max_connections = 200
    max_heap_table_size = 64M
    myisam_recover_options = BACKUP
    myisam_sort_buffer_size = 512M
    port = 3306
    pid-file = /var/run/mysqld/mysqld.pid
    query_cache_limit = 2M
    query_cache_size = 64M
    query_cache_type = 1
    query_cache_min_res_unit = 2k
    read_buffer_size = 2M
    read_rnd_buffer_size = 1M
    skip-external-locking
    skip-name-resolve
    slow_query_log_file = /var/log/mysql/mariadb-slow.log
    slow-query-log = 1
    socket = /var/run/mysqld/mysqld.sock
    sort_buffer_size = 4M
    table_open_cache = 400
    thread_cache_size = 128
    tmp_table_size = 64M
    tmpdir = /tmp
    transaction_isolation = READ-COMMITTED
    #unix_socket=OFF
    user = mysql
    wait_timeout = 600

[mysqldump]
    max_allowed_packet = 16M
    quick
    quote-names

[isamchk]
    key_buffer = 16M
```

Save and close the file, then restart the database server

```bash
service mysql restart
```

### Nextcloud - Database creation

Create Nextcloud database, user and password. Use `-h localhost` MariaDB is installed locally or `-h IP` if on a remote server

```bash
mysql -u root -p -h 192.168.0.101 -P 3306
```

```sql
CREATE DATABASE nextclouddb CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
CREATE USER nextclouddbuser@localhost identified by 'nextclouddbpassword';
GRANT ALL PRIVILEGES on nextclouddb.* to nextclouddbuser;
FLUSH privileges;
quit;
```

Check whether the isolation level (read commit) and the charset (utf8mb4) have been set correctly

```bash
mysql -h 192.168.0.101 -p 3306 -uroot -p -e "SELECT @@TX_ISOLATION; SELECT SCHEMA_NAME 'database', default_character_set_name 'charset', DEFAULT_COLLATION_NAME 'collation' FROM information_schema.SCHEMATA WHERE SCHEMA_NAME='nextclouddb'"
```

For MySQL use the following command:

```bash
mysql -h 192.168.0.101 -p 3306 -uroot -p -e "SELECT @@global.transaction_isolation; SELECT SCHEMA_NAME 'database', default_character_set_name 'charset', DEFAULT_COLLATION_NAME 'collation' FROM information_schema.SCHEMATA WHERE SCHEMA_NAME='nextcloud'"
```

If *READ-COMMITTED* and *utf8mb4_general_c i* appear in the output (resultset) everything has been set up correctly.

### Nextcloud - Installation of Redis server

Use Redis to increase the Nextcloud performance, as Redis reduces the load on the database.

This step is optional and can be skipped if using Redis runs in a docker instance on a separate server server

If the step is skipped then make sure the redis-tools are installed and connection with server wroks. Replace the host in the second command if needed.

```bash
sudo apt install -y redis-tools
redis-cli -h 192.168.0.101 -p 6379 ping
```

The reply to last command should be PONG.

In case Redis will be installed locally, execute command below.

```bash
sudo apt install -y redis-server
```

Adjust the redisk configuration by saving and adapting the configuration using the following commands

```bash
cp /etc/redis/redis.conf /etc/redis/redis.conf.bak
sed -i '0,/port 6379/s//port 0/' /etc/redis/redis.conf
sed -is/\#\ unixsocket/\unixsocket/g /etc/redis/redis.conf
sed -i "s/unixsocketperm 700/unixsocketperm 770/" /etc/redis/redis.conf
sed -i "s/# maxclients 10000/maxclients 10240/" /etc/redis/redis.conf
sudo usermod -aG redis www-data
```

Background save may file under low memory conditions. To fix this issue 'm.overcommit_memory' has to be set to 1.

```bash
sudo cp /etc/sysctl.conf /etc/sysctl.conf.bak
sudo sed -i '$ avm.overcommit_memory = 1' /etc/sysctl.conf
sudo reboot now
```

### Nextcloud - Installation and optimization of Nextcloud

We will now set up various vhost, i.e. server configuration files, and modify the standard vhost file persistently.

If exists, backup existing configuration. Create empty vhosts files. The empty "default.conf" file ensures that the standard configuration does not affect Nextcloud operation even when the web server is updated later.

```bash
[ -f /etc/nginx/conf.d/default.conf ] && sudo mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.bak
```

```bash
sudo touch /etc/nginx/conf.d/default.conf
sudo touch /etc/nginx/conf.d/http.conf
sudo touch /etc/nginx/conf.d/nextcloud.conf
```

Create the global vhost file to permanently redirect the http standard requests to https and optionally to enable SSL certificate communication with Let'sEncrypt.

```bash
sudo nano /etc/nginx/conf.d/http.conf
```

```bash
upstream php-handler {
    server unix:/run/php/php8.0-fpm.sock;
}

server {
    listen 80 default_server;
    listen [::]:80 default_server;

    server_name nextcloud.sitram.duckdns.org;
    
    root /var/www;
    location ^~ /.well-known/acme-challenge {
        default_type text/plain;
        root /var/www/letsencrypt;
    }

    location / {
        return 301 https://$host$request_uri;
    }
}
```

Generate

Copy all the following lines into the nextcloud.conf file and adjust the values if needed.

```bash
sudo nano /etc/nginx/conf.d/nextcloud.conf
```

```bash
server {
 listen 443 ssl http2;
 listen [::]:443 ssl http2;

 server_name nextcloud.sitram.duckdns.org;

    ssl_certificate /etc/ssl/certs/ssl-cert-snakeoil.pem;
    ssl_certificate_key /etc/ssl/private/ssl-cert-snakeoil.key;
    ssl_trusted_certificate /etc/ssl/certs/ssl-cert-snakeoil.pem;
    #ssl_certificate /etc/letsencrypt/rsa-certs/fullchain.pem;
    #ssl_certificate_key /etc/letsencrypt/rsa-certs/privkey.pem;
    #ssl_certificate /etc/letsencrypt/ecc-certs/fullchain.pem;
    #ssl_certificate_key /etc/letsencrypt/ecc-certs/privkey.pem;
    #ssl_trusted_certificate /etc/letsencrypt/ecc-certs/chain.pem;
    ssl_dhparam /etc/ssl/certs/dhparam.pem;
    ssl_session_timeout 1d;
    ssl_session_cache shared:SSL:50m;
    ssl_session_tickets off;
    ssl_protocols TLSv1.3 TLSv1.2;
    ssl_ciphers 'TLS-CHACHA20-POLY1305-SHA256:TLS-AES-256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA512:DHE-RSA-AES256-GCM-SHA512:ECDHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES256-GCM-SHA384';
    ssl_ecdh_curve X448:secp521r1:secp384r1;
    ssl_prefer_server_ciphers on;
    ssl_stapling on;
    ssl_stapling_verify on;
    
    client_max_body_size 10G;
    fastcgi_buffers 64 4K;
    
    gzip on;
    gzip_vary on;
    gzip_comp_level 4;
    gzip_min_length 256;
    gzip_proxied expired no-cache no-store private no_last_modified no_etag auth;
    gzip_types application/atom+xml application/javascript application/json application/ld+json application/manifest+json application/rss+xml application/vnd.geo+json application/vnd.ms-fontobject application/x-font-ttf application/x-web-app-manifest+json application/xhtml+xml application/xml font/opentype image/bmp image/svg+xml image/x-icon text/cache-manifest text/css text/plain text/vcard text/vnd.rim.location.xloc text/vtt text/x-component text/x-cross-domain-policy;    
    add_header Strict-Transport-Security            "max-age=15768000; includeSubDomains; preload;" always;
    add_header Permissions-Policy                   "interest-cohort=()";
    add_header Referrer-Policy                      "no-referrer"   always;
    add_header X-Content-Type-Options               "nosniff"       always;
    add_header X-Download-Options                   "noopen"        always;
    add_header X-Frame-Options                      "SAMEORIGIN"    always;
    add_header X-Permitted-Cross-Domain-Policies    "none"          always;
    add_header X-Robots-Tag                         "none"          always;
    add_header X-XSS-Protection                     "1; mode=block" always;
    fastcgi_hide_header X-Powered-By;

    root /var/www/nextcloud;

    index index.php index.html /index.php$request_uri;

    location = / {
      if ( $http_user_agent ~ ^DavClnt ) {
        return 302 /remote.php/webdav/$is_args$args;
      }
    }

    location = /robots.txt {
      allow all;
      log_not_found off;
      access_log off;
    }

    location ^~ /apps/rainloop/app/data {
      deny all;
    }

    location ^~ /.well-known {
      location = /.well-known/carddav { return 301 /remote.php/dav/; }
      location = /.well-known/caldav  { return 301 /remote.php/dav/; }
      location /.well-known/acme-challenge { try_files $uri $uri/ =404; }
      location /.well-known/pki-validation { try_files $uri $uri/ =404; }

      return 301 /index.php$request_uri;
    }

    location ~ ^/(?:build|tests|config|lib|3rdparty|templates|data)(?:$|/)  { return 404; }

    location ~ ^/(?:\.|autotest|occ|issue|indie|db_|console)                { return 404; }
    location ~ \.php(?:$|/) {
      rewrite ^/(?!index|remote|public|cron|core\/ajax\/update|status|ocs\/v[12]|updater\/.+|oc[ms]-provider\/.+|.+\/richdocumentscode\/proxy) /index.php$request_uri;
      fastcgi_split_path_info ^(.+?\.php)(/.*)$;
      set $path_info $fastcgi_path_info;
      try_files $fastcgi_script_name =404;
      include fastcgi_params;
      fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
      fastcgi_param PATH_INFO $path_info;
      fastcgi_param HTTPS on;
      fastcgi_param modHeadersAvailable true;
      fastcgi_param front_controller_active true;
      fastcgi_pass php-handler;
      fastcgi_intercept_errors on;
      fastcgi_request_buffering off;
      fastcgi_read_timeout 3600;
      fastcgi_send_timeout 3600;
      fastcgi_connect_timeout 3600;
    }

    location ~ \.(?:css|js|svg|gif|png|jpg|ico)$ {
      try_files $uri /index.php$request_uri;
      expires 6M;
      access_log off;
    }

    location ~ \.woff2?$ {
      try_files $uri /index.php$request_uri;
      expires 7d;
      access_log off;
    }

    location /remote {
      return 301 /remote.php$request_uri;
    }

    location / {
      try_files $uri $uri/ /index.php$request_uri;
    }
}
```

Extend the server and system security with the possibility of a secure key exchange using a Diffie-Hellman key(dhparam.pem)

```bash
sudo openssl dhparam -dsaparam -out /etc/ssl/certs/dhparam.pem 4096
```

Restart webserver

```bash
sudo service nginx restart
sudo service nginx status
```

Download the current Nextcloud release and the the files.

```bash
cd /usr/local/src
sudo wget https://download.nextcloud.com/server/releases/latest.tar.bz2
sudo wget https://download.nextcloud.com/server/releases/latest.tar.bz2.md5
md5sum -c latest.tar.bz2.md5 < latest.tar.bz2
```

The test should result in 'OK'

Unzip Nextcloud software into the web directy(/var/www) then set the right permissions.

```bash
sudo tar -xjf latest.tar.bz2 -C /var/www
sudo chown -R www-data:www-data /var/www/
sudo rm -f latest.tar.bz2
sudo rm -f latest.tar.bz2.md5
```

[OPTIONAL] Creationg an update of Let's Encrypt certificates is mandatory via http and port 80 so make sure the server can be reached from outside.

Create a dedicate user for certificate handling and add this user to www-data group

```bash
adduser --disabled-login acmeuser
usermod -a -G www-data acmeuser
```

Give this user the nessecary permission to start the web server when a certificate is renewed.

```bash
visudo
```

In the middle of the file, below

```bash
[..]
User privilege specification
root ALL=(ALL:ALL) ALL
[..]
```

add the following line

```bash
acmeuser ALL=NOPASSWD: /bin/systemctl reload nginx.service
```

After saving and exit, switch to the shell of the new user and install the certificate software.

```bash
su - acmeuser
curl https://get.acme.sh | sh
exit
```

Adjust the appropriate permissions to be able to save the new certificates in it.

```bash
sudo chmod -R 775 /var/www/letsencrypt
sudo chmod -R 770 /etc/letsencrypt
sudo chown -R www-data:www-data /var/www/ /etc/letsencrypt
```

Set Let's Encrypt as the default CA for your server

```bash
su - acmeuser -c ".acme.sh/acme.sh --set-default-ca --server letsencrypt
```

and then switch to the new user's shell again

```bash
su - acmeuser
```

Request the SSL certificates from Let's Encrypt and replace domain if needed

```bash
acme.sh --issue -d nextcloud.sitram.duckdns.org --server letsencrypt --keylength 4096 -w /var/www/letsencrypt --key-file /etc/letsencrypt/rsa-certs/privkey.pem --ca-file /etc/letsencrypt/rsa-certs/chain.pem --cert-file /etc/letsencrypt/rsa-certs/cert.pem --fullchain-file /etc/letsencrypt/rsa-certs/fullchain.pem --reloadcmd "sudo /bin/systemctl reload nginx.service"
```

```bash
acme.sh --issue -d nextcloud.sitram.duckdns.org --server letsencrypt --keylength ec-384 -w /var/www/letsencrypt --key-file /etc/letsencrypt/ecc-certs/privkey.pem --ca-file /etc/letsencrypt/ecc-certs/chain.pem --cert-file /etc/letsencrypt/ecc-certs/cert.pem --fullchain-file /etc/letsencrypt/ecc-certs/fullchain.pem --reloadcmd "sudo /bin/systemctl reload nginx.service"
```

exit new user's shell

```bash
exit
```

Create the file permissions.sh with the following contents

```bash
#!/bin/bash
sudo find /var/www/ -type f -print0 | xargs -0 chmod 0640
sudo find /var/www/ -type d -print0 | xargs -0 chmod 0750
sudo chmod -R 775 /var/www/letsencrypt
sudo chmod -R 770 /etc/letsencrypt 
sudo chown -R www-data:www-data /var/www /etc/letsencrypt
sudo chown -R www-data:www-data /var/nc_data
sudo chmod 0644 /var/www/nextcloud/.htaccess
sudo chmod 0644 /var/www/nextcloud/.user.ini
exit 0
```

Make script executable and run it

```bash
chmod + x /home/sitram/permissions.sh
/home/sitram/permissions.sh
```

Remove your previously used self-signed certificates from nginx and activate the new, full-fledged and already valid SSL certificates from Let's Encrypt. Then restart the web server.

```bash
sed -i '/ssl-cert-snakeoil/d' /etc/nginx/conf.d/nextcloud.conf
sed -i s/#\ssl/\ssl/g /etc/nginx/conf.d/nextcloud.conf
service nginx restart
```

In order to automatically renew the SSL certificates as well as to initiate the necessary web server restart, a cron job was automatically created.

```bash
crontab -l -u acmeuser
```

Set up the Nextcloud using the following "silent" installation command with database locally.

```bash
sudo -u www-data php /var/www/nextcloud/occ maintenance:install --database "mysql" --database-name "nextcloud_test" --database-user "root" --database-pass "rootpw" --admin-user "sitram" --admin-pass "YourNextcloudAdminPasssword" --data-dir "/var/nc_data"
```

```bash
sudo -u www-data php /var/www/nextcloud/occ maintenance:install --database "mysql" --database-host=192.168.0.101:3306 --database-name "nextclouddb" --database-user "sitram" --database-pass "sitram" --admin-user "sitram" --admin-pass "YourNextcloudAdminPasssword" --data-dir "/var/nc_data"
```

Wait until the installation of the Nextcloud has been completed and then adjust the central configuration file of the Nextcloud "config.php" as web user www-data.

Add your domain as a trusted domain

```bash
sudo -u www-data php /var/www/nextcloud/occ config:system:set trusted_domains 0 --value=nextcloud.sitram.duckdns.org
```

Set your domain as overwrite.cli.url

```bash
sudo -u www-data php /var/www/nextcloud/occ config:system:set overwrite.cli.url --value=https://nextcloud.sitram.duckdns.org
```

Save the existing config.php and then execute the following lines in a block

```bash
sudo -u www-data cp /var/www/nextcloud/config/config.php /var/www/nextcloud/config/config.php.bak 
sudo -u www-data sed -i 's/^[ ]*//' /var/www/nextcloud/config/config.php
sudo -u www-data sed -i '/);/d' /var/www/nextcloud/config/config.php
```

Edit config.php and add the following block of text at the end of the file

```php
'activity_expire_days' => 14,
'auth.bruteforce.protection.enabled' => true,
'blacklisted_files' => 
array (
    0 => '.htaccess',
    1 => 'Thumbs.db',
    2 => 'thumbs.db',
),
'cron_log' => true,
'default_phone_region' => 'RO',
'enable_previews' => true,
'enabledPreviewProviders' => 
array (
    0 => 'OC\Preview\PNG',
    1 => 'OC\Preview\JPEG',
    2 => 'OC\Preview\GIF',
    3 => 'OC\Preview\BMP',
    4 => 'OC\Preview\XBitmap',
    5 => 'OC\Preview\Movie',
    6 => 'OC\Preview\PDF',
    7 => 'OC\Preview\MP3',
    8 => 'OC\Preview\TXT',
    9 => 'OC\Preview\MarkDown',
),
'filesystem_check_changes' => 0,
'filelocking.enabled' => 'true',
'htaccess.RewriteBase' => '/',
'integrity.check.disabled' => false,
'knowledgebaseenabled' => false,
'logfile' => '/var/nc_data/nextcloud.log',
'loglevel' => 2,
'logtimezone' => 'Europe/Bucharest',
'log_rotate_size' => 104857600,
'maintenance' => false,
'memcache.local' => '\OC\Memcache\APCu',
'memcache.locking' => '\OC\Memcache\Redis',
'overwriteprotocol' => 'https',
'preview_max_x' => 1024,
'preview_max_y' => 768,
'preview_max_scale_factor' => 1,
'redis' => 
array (
    // For connecting to local Redis Server
    //'host' => '/var/run/redis/redis-server.sock',
    //'port' => 0,
    // For connecting to remote Redis Server
    //'host' => '192.168.0.101',
    //'port' => 6379,
    'timeout' => 0.0,
),
'quota_include_external_storage' => false,
'share_folder' => '/',
'skeletondirectory' => '',
'theme' => '',
'trashbin_retention_obligation' => 'auto, 7',
'updater.release.channel' => 'stable',
// Configure swag as trusted proxy if SWAG docker image is used
'trusted_proxies' =>
array (
    0 => 'swag',
),

);
```

Modify the ".user.ini"

```bash
sudo -u www-data sed -i "s/output_buffering=.*/output_buffering=0/" /var/www/nextcloud/.user.ini
```

Adapt the Nextcloud apps as user www-data

```bash
sudo -u www-data php /var/www/nextcloud/occ app:disable survey_client
sudo -u www-data php /var/www/nextcloud/occ app:disable firstrunwizard
sudo -u www-data php /var/www/nextcloud/occ app:enable admin_audit
sudo -u www-data php /var/www/nextcloud/occ app:enable files_pdfviewer
```

Nextcloud is now fully operational, optimized and secured. Restart all relevant services. 'redis-server' and 'mysql' can be skipped if they are running on other servers.

```bash
service nginx stop
service php8.0-fpm stop
service mysql restart
service php8.0-fpm restart
service redis-server restart
service nginx restart
```

Set up a cron job for Nextcloud as a "www-data" user

```bash
crontab -u www-data -e
```

Insert this line at the end of the file

```bash
*/5 * * * * php -f /var/www/nextcloud/cron.php > /dev/null 2>&1
```

Save and close the file and reconfigure the Nextcloud job from "Ajax" to "Cron" using the Nextclouds CLI

```bash
sudo -u www-data php /var/www/nextcloud/occ background:cron
```

### Nextcloud - Optimize and update using a script

Create a script to update and optimize the server, Nextcloud and the activated apps

```bash
nano update.sh
```

```bash
#!/bin/bash
# Update OS
sudo apt update -q4
sudo apt upgrade -V
sudo apt autoremove -y
sudo apt autoclean -y

# Reset folder permissions
sudo chown -R www-data:www-data /var/www/nextcloud
sudo find /var/www/nextcloud/ -type d -exec sudo chmod 750 {} \;
sudo find /var/www/nextcloud/ -type f -exec sudo chmod 640 {} \;

# Stop web server
sudo /usr/sbin/service nginx stop

# Update Nextcloud
sudo -u www-data php /var/www/nextcloud/updater/updater.phar
sudo -u www-data php /var/www/nextcloud/occ status
sudo -u www-data php /var/www/nextcloud/occ -V
sudo -u www-data php /var/www/nextcloud/occ db:add-missing-primary-keys
sudo -u www-data php /var/www/nextcloud/occ db:add-missing-indices
sudo -u www-data php /var/www/nextcloud/occ db:add-missing-columns
sudo -u www-data php /var/www/nextcloud/occ db:convert-filecache-bigint

# Make sure the user.ini has the needed modification
sudo sed -i "s/output_buffering=.*/output_buffering=0/" /var/www/nextcloud/.user.ini
sudo chown -R www-data:www-data /var/www/nextcloud

# Flush Redis server
redis-cli -h 192.168.0.101 -p 6379 <<EOF
FLUSHALL
quit
EOF

# Perform Nextcloud maintenance
sudo -u www-data php /var/www/nextcloud/occ files:scan --all
sudo -u www-data php /var/www/nextcloud/occ files:scan-app-data
sudo -u www-data php /var/www/nextcloud/occ app:update --all

# Restart PHP and Web server
sudo /usr/sbin/service php8.0-fpm restart
sudo /usr/sbin/service nginx restart

exit 0
```

Make the script executable

```bash
chmod +x update.sh
```

Execute it periodically.

### Nextcloud - Bash aliases for executing Nextcloud Toolset occ

Adjust file /home/sitram/.bash_aliases in order to be able to start the Nextcloud Toolset occ directly with nocc

```bash
if [ ! -f /home/sitram/.bash_aliases ]; then touch /home/sitram/.bash_aliases; fi
```

```bash
cat <<EOF >> /home/sitram/.bash_aliases
alias nocc="sudo -u www-data php /var/www/nextcloud/occ"
EOF
```

Log out of the current session and then log back in again. Now you can run Nextcloud Toolset occ directly via "nocc ... ".

### Nextcloud - Map user data directory to nfs share

Create user `nicusor` in Nextcloud web interface.

Createa a backup of the user data directory, preserving the permissions and ownership and empty the user folder

```bash
sudo cp -rp /var/nc_data/nicusor /var/nc_data/nicusor_bkp
sudo rm -r /var/nc_data/nicusor/*
```

Add the mounting point to the nfs share in `/etc/fstab/`

```bash
192.168.0.114:/mnt/nicusor /var/nc_data/nicusor nfs rw 0 0
```

Mount the newly added mount points

```bash
sudo mount -a
```

Copy the contents of the user directory to the nfs share and delete the backup.

```bash
sudo cp -rp /var/nc_data/nicusor_bkp/* /var/nc_data/nicusor
sudo rm -r /var/nc_data/nicusor_bkp
```

Restart PHP and Web server

```bash
sudo /usr/sbin/service php8.0-fpm restart
sudo /usr/sbin/service nginx restart
```

## Hercules - HomeLab services VM

### Hercules - VM configuration

### Hercules - OS Configuration

The following subsections from [General](#general) section should be performed in this order:

- [SSH configuration](#ssh-configuration)
- [Ubuntu - Synchronize time with systemd-timesyncd](#ubuntu---synchronize-time-with-systemd-timesyncd)
- [Update system timezone](#update-system-timezone)
- [Correct DNS resolution](#correct-dns-resolution)
- [Generate Gmail App Password](#generate-gmail-app-password)
- [Configure Postfix Server to send email through Gmail](#configure-postfix-server-to-send-email-through-gmail)
- [Mail notifications for SSH dial-in](#mail-notifications-for-ssh-dial-in)

Add the following mounting points to `/etc/fstab/`

```bash
192.168.0.114:/mnt/tank1/data /home/sitram/data nfs rw 0 0
192.168.0.114:/mnt/tank2/media /home/sitram/media nfs rw 0 0
```

### Hercules - Docker installation and docker-compose

I used for a while the Docker Engine from Ubuntu apt repository, until a container stopped working because it needed the latest version which was not yet available. I decided to switch from Ubuntu's apt version of docker to the official one from [here](https://docs.docker.com/engine/install/ubuntu/#set-up-the-repository) and it has been working great so far.

I launch all containers from a single docker-compose file called `docker-compose.yml` which I store in `/home/sitram/data`. Together with the yaml file, I store a `.env` file which contains the stack name:

```bash
echo COMPOSE_PROJECT_NAME=serenity >> /home/sitram/data/.env
```

The configuration of each container is stored in `/home/sitram/docker` in a folder named after each container. I have a job running on the host server, which periodically creates a backup of this VM to a Raid 1 so I should be protected in case of some failures.

[TODO] move the containers docker configuration to my tank1 in order to reduce the wear on the SSD.

#### Hercules - Remove docker packages from Ubuntu repository

Identify what docker related packages are installed on your system

```bash
dpkg -l | grep -i docker
```

Remove any docker related packages installed from Ubuntu repository. This will not remove images, containers, volumes, or user created configuration files on your host.

```bash
sudo apt-get purge -y docker-engine docker docker.io docker-ce docker-ce-cli docker-compose-plugin
sudo apt-get autoremove -y --purge docker-engine docker docker.io docker-ce docker-compose-plugin
```

If you wish to delete all images, containers, and volumes run the following commands:

```bash
sudo rm -rf /var/lib/docker /etc/docker
sudo rm /etc/apparmor.d/docker
sudo groupdel docker
sudo rm -rf /var/run/docker.sock
```

#### Hercules - set up Docker repository

Update the `apt` package index and install packages to allow apt to use a repository over HTTPS:

```bash
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
```

Add Docker’s official GPG key:

```bash
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
```

Use the following command to set up the repository:

```bash
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

#### Hercules - Install Docker Engine

Update the apt package index:

```bash
sudo apt-get update
```

Install the latest version of Docker Engine

```bash
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
```

Verify that the Docker Engine installation is successful by running the hello-world image

```bash
sudo docker run hello-world
```

### Hercules - Watchtower docker container

I keep my containers updated using [Watchtower](https://containrrr.dev/watchtower/). It runs every night and sends notifications over telegram.

The container has:

- a volume mapped to `/var/run/docker.sock` used to access Docker via Unix sockets

Below is the docker-compose I used to launch the container.

```yaml
#Watchtower every night with telegram notification - https://containrrr.dev/watchtower/
#Chron Expression format - https://pkg.go.dev/github.com/robfig/cron@v1.2.0#hdr-CRON_Expression_Format
  watchtower:
    image: containrrr/watchtower:latest
    container_name: watchtower_schedule_telegram
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    restart: unless-stopped
    command: 
      --cleanup
      --include-stopped
      --notifications shoutrrr 
      --notification-url "xxxxxxx"
      --schedule "0 0 0 * * *"
```

### Hercules - Heimdall docker container

I use [Heimdall](https://hub.docker.com/r/linuxserver/heimdall) as a web portal for managing al the services running on my HomeLab.

The container has:

- a volume mapped to `/home/sitram/docker/heimdall` used to store the configuration of the application

Below is the docker-compose I used to launch the container.

```yaml
#Heimdall - Web portal for managing home lab services - https://hub.docker.com/r/linuxserver/heimdall
  heimdall:
    image: ghcr.io/linuxserver/heimdall
    container_name: heimdall
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Bucharest
    volumes:
      - /home/sitram/docker/heimdall:/config
    ports:
      - 81:80
      - 441:443
    restart: unless-stopped
```

### Hercules - Portainer docker container

I use [Portainer](https://www.portainer.io/) as a web interface for managing my docker containers. It helps me tocheck container logs, login to a shell inside the container and perform other various debugging activities.

The container has:

- a volume mapped to `/home/sitram/docker/portainer` used to store the configuration of the application
- a volume mapped to `/var/run/docker.sock` used to access Docker via Unix sockets

Below is the docker-compose I used to launch the container.

```yaml
#Portainer - a web interface for managing docker containers
  portainer:
    image: portainer/portainer-ce:latest
    container_name: portainer
    command: -H unix:///var/run/docker.sock
    restart: always
    ports:
      - 9000:9000
      - 8000:8000
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - /home/sitram/docker/portainer:/data
```

### Hercules - Calibre docker container

I use [Calibre](https://hub.docker.com/r/linuxserver/calibre) as a book management application. My book library is stored in the mounted volume.

The container has:

- a volume mapped to `/home/sitram/docker/calibre` used to store the configuration of the application

Below is the docker-compose I used to launch the container.

```yaml
#Calibre - Books management application - https://hub.docker.com/r/linuxserver/calibre
  calibre: 
    image: ghcr.io/linuxserver/calibre:latest
    container_name: calibre
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Bucharest
      - UMASK_SET=022 #optional
    volumes:
      - /home/sitram/docker/calibre:/config
    ports:
      - 8080:8080
      - 8081:8081
      - 9090:9090
    restart: unless-stopped
```

### Hercules - Calibre-web docker container

I use [Calibre-web](https://hub.docker.com/r/linuxserver/calibre-web) as a web app providing a clean interface for browsing, reading and downloading eBooks using an existing Calibre datavase.

The container has:

- a volume mapped to `/home/sitram/docker/calibre-web` used to store the configuration of the application
- a volume mapped to `/home/sitram/docker/calibre/Calibre Library` where the Calibre database is located.

Below is the docker-compose I used to launch the container.

```yaml
#Calibre-web - web app providing a clean interface for browsing, reading and downloading eBooks using an existing Calibre database. - https://hub.docker.com/r/linuxserver/calibre-web
  calibre-web: 
    image: ghcr.io/linuxserver/calibre-web
    container_name: calibre-web
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Bucharest
      - DOCKER_MODS=linuxserver/calibre-web:calibre
    volumes:
      - /home/sitram/docker/calibre-web:/config
      - "/home/sitram/docker/calibre/Calibre Library:/books"
    ports:
      - 8086:8083
    restart: unless-stopped
```

### Hercules - qBitTorrent docker container

I use [qBitTorrent](https://hub.docker.com/r/linuxserver/qbittorrent/) as my main torrent client accessible to the entire LAN network. I use an older version(14.3.9) because the latest immage is causing some issues which I couldn't figure how to solve.

The container has:

- a volume mapped to `/home/sitram/docker/qbittorrent` used to store the configuration of the application
- a volume mapped to `/home/sitram/media/torrents` where all downloaded torrents are storred to preserve the life of the host SSD
- a volume mapped to `/home/sitram/media/torrents/torrents` where I can add any `.torrent` file and it will be automatically started by the client.

Below is the docker-compose I used to launch the container.

```yaml
#qBitTorrent - Torrent client - https://hub.docker.com/r/linuxserver/qbittorrent/
# 2022.07.08 - Latest docker image caused torrents to go into error and wouldn't download.
  qbittorrent:
    image: lscr.io/linuxserver/qbittorrent:14.3.9
    #image: lscr.io/linuxserver/qbittorrent:latest
    container_name: qbittorrent
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Bucharest
      - WEBUI_PORT=9093
    volumes:
      - /home/sitram/docker/qbittorrent:/config
      - /home/sitram/media/torrents:/downloads
      - /home/sitram/media/torrents/torrents:/watch
    ports:
      - 51413:51413
      - 51413:51413/udp
      - 9093:9093
    restart: unless-stopped
```

### Hercules - Jackett docker container

I use [Jackett]( https://ghcr.io/linuxserver/jackett) as a proxy server: it translates queries from apps (Sonarr, SickRage, CouchPotato, Mylar, etc) into tracker-site-specific http queries, parses the html response, then sends results back to the requesting software.

The container has:

- a volume mapped to `/home/sitram/docker/jackett` used to store the configuration of the application
- a volume mapped to `/home/sitram/media/torrents` where all downloaded torrents are storred to preserve the life of the host SSD

Below is the docker-compose I used to launch the container.

```yaml
# Jackett - works as a proxy server: it translates queries from apps (Sonarr, SickRage, CouchPotato, Mylar, etc) into tracker-site-specific http queries, parses the html response, then sends results back to the requesting software. - https://ghcr.io/linuxserver/jackett
  jackett: 
    image: ghcr.io/linuxserver/jackett
    container_name: jackett
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Bucharest
      - AUTO_UPDATE=true #optional
    volumes:
      - /home/sitram/docker/jackett:/config
      - /home/sitram/media/torrents:/downloads
    ports:
      - 9117:9117
    restart: unless-stopped
```

### Hercules - Sonarr docker container

I use [Sonarr](https://ghcr.io/linuxserver/sonarr) as a web application to mnitor multiple sources for favourite tv shows.

The container has:

- a volume mapped to `/home/sitram/docker/sonarr` used to store the configuration of the application
- a volume mapped to `/home/sitram/media/tvseries` used to store all TV shows
- a volume mapped to `/home/sitram/media/torrents` where all downloaded torrents are storred to preserve the life of the host SSD

Below is the docker-compose I used to launch the container.

```yaml
#Sonarr - Monitor multiple sources for favourite tv shows - https://ghcr.io/linuxserver/sonarr
  sonarr:
    image: ghcr.io/linuxserver/sonarr
    container_name: sonarr
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Bucharest
      - UMASK_SET=022 #optional
    volumes:
      - /home/sitram/docker/sonarr:/config
      - /home/sitram/media/tvseries:/tv
      - /home/sitram/media/torrents:/downloads
    ports:
      - 8989:8989
    depends_on:
      - jackett
      - qbittorrent
    restart: unless-stopped
```

### Hercules - Radarr docker container

I use [Radarr](https://ghcr.io/linuxserver/radarr) as a web application to mnitor multiple sources for favourite movies.

The container has:

- a volume mapped to `/home/sitram/docker/radarr` used to store the configuration of the application
- a volume mapped to `/home/sitram/media/movies` used to store all the movies
- a volume mapped to `/home/sitram/media/torrents` where all downloaded torrents are storred to preserve the life of the host SSD

Below is the docker-compose I used to launch the container.

```yaml
#Radarr - A fork of Sonarr to work with movies https://ghcr.io/linuxserver/radarr
  radarr:
    image: ghcr.io/linuxserver/radarr:nightly-alpine
    container_name: radarr
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Bucharest
      - UMASK_SET=022 #optional
    volumes:
      - /home/sitram/docker/radarr:/config
      - /home/sitram/media/movies:/movies
      - /home/sitram/media/torrents:/downloads
    ports:
      - 7878:7878
    depends_on:
      - jackett
      - qbittorrent
    restart: unless-stopped
```

### Hercules - Bazarr docker container

I use [Bazarr](https://ghcr.io/linuxserver/bazarr) as a web application companion to Sonarr and Radarr. It can manage and download subtitles based on your requirements.

The container has:

- a volume mapped to `/home/sitram/docker/bazarr` used to store the configuration of the application
- a volume mapped to `/home/sitram/media/movies` used to store all the movies
- a volume mapped to `/home/sitram/media/tvseries` used to store all TV shows

Below is the docker-compose I used to launch the container.

```yaml
#Bazarr is a companion application to Sonarr and Radarr. It can manage and download subtitles based on your requirements. - https://hub.docker.com/r/linuxserver/bazarr
  bazarr:
    image: ghcr.io/linuxserver/bazarr
    container_name: bazarr
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Bucharest
    volumes:
      - /home/sitram/docker/bazarr:/config
      - /home/sitram/media/movies:/movies
      - /home/sitram/media/tvseries:/tv
    ports:
      - 6767:6767
    depends_on:
      - radarr
      - sonarr
    restart: unless-stopped
```

### Hercules - Lidarr docker container

I use [Lidarr](https://hub.docker.com/r/linuxserver/lidarr) as a web application to manage my music collection.

The container has:

- a volume mapped to `/home/sitram/docker/lidarr` used to store the configuration of the application
- a volume mapped to `/home/sitram/media/music` used to store all the music
- a volume mapped to `/home/sitram/media/torrents` where all downloaded torrents are storred to preserve the life of the host SSD

Below is the docker-compose I used to launch the container.

```yaml
#Lidarr is a music collection manager for Usenet and BitTorrent users. - https://hub.docker.com/r/linuxserver/lidarr
  lidarr:
    image: ghcr.io/linuxserver/lidarr
    container_name: lidarr
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Bucharest
    volumes:
      - /home/sitram/docker/lidarr:/config
      - /home/sitram/media/music:/music
      - /home/sitram/media/torrents:/downloads
    ports:
      - 8686:8686
    depends_on:
      - jackett 
      - qbittorrent
    restart: unless-stopped
```

### Hercules - Overseerr docker container

I use [Overseerr](https://hub.docker.com/r/sctx/overseerr) as a free and open source web application for managing requests for my media library. It integrates with your existing services, such as Sonarr, Radarr, and Plex.

The container has:

- a volume mapped to `/home/sitram/docker/overseerr` used to store the configuration of the application

Below is the docker-compose I used to launch the container.

```yaml
#Overseerr is a free and open source software application for managing requests for your media library. 
# It integrates with your existing services, such as Sonarr, Radarr, and Plex!
# https://hub.docker.com/r/sctx/overseerr
  overseerr:
    image: sctx/overseerr:latest
    container_name: overseerr
    environment:
      - LOG_LEVEL=debug
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Bucharest
    ports:
      - 5055:5055
    volumes:
      - /home/sitram/docker/overseerr:/app/config
    restart: unless-stopped
```

### Hercules - DuckDNS docker container

I use [DuckDNS](http://ghcr.io/linuxserver/duckdns) to point the subdomain I reserved on duckdns to the dinamically assigned IP address by my ISP.

The container has:

- a volume mapped to `/home/sitram/docker/duckdns` used to store the configuration of the application

Below is the docker-compose I used to launch the container.

```yaml
#DuckDNS - point the subdomain to my IP address - http://ghcr.io/linuxserver/duckdns
  duckdns:
    image: ghcr.io/linuxserver/duckdns
    container_name: duckdns
    environment:
      - PUID=1000 #optional
      - PGID=1000 #optional
      - TZ=Europe/Bucharest
      - SUBDOMAINS=xxxxx #to be filled with the subdomain
      - TOKEN=xxxxxxxx #to be filled with the real token
      - LOG_FILE=true #optional
      - DOCKER_MODS=linuxserver/mods:universal-wait-for-internet
    volumes:
      - /home/sitram/docker/duckdns:/config #optional
    dns: 192.168.0.103
    restart: unless-stopped
```

### Hercules - SWAG - Secure Web Application Gateway docker container

I use [SWAG - Secure Web Application Gateway](https://ghcr.io/linuxserver/swag) as a free and open source application that sets a Nginx webserver and reverse proxy with php support and a built-in certbot client that automates free SSL server certificate generation and renewal processes.

The container has:

- a volume mapped to `/home/sitram/docker/swag` used to store the configuration of the application

Below is the docker-compose I used to launch the container.

```yaml
#SWAG - Secure Web Application Gateway sets up an Nginx webserver and reverse proxy with php support and a built-in certbot client that automates free SSL server certificate generation and renewal processes. - https://ghcr.io/linuxserver/swag
  swag:
    image: ghcr.io/linuxserver/swag
    container_name: swag
    cap_add:
      - NET_ADMIN
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Bucharest
      - URL=xxxxx #to be filled with the subdomain
      - SUBDOMAINS=wildcard
      - VALIDATION=duckdns
      - DUCKDNSTOKEN=xxxxxxxx #to be filled with the real token
      - EMAIL=xxx@gmail.com # to be filled with real email
      - ONLY_SUBDOMAINS=false
      - STAGING=false
      - DOCKER_MODS=linuxserver/mods:swag-auto-reload|linuxserver/mods:universal-wait-for-internet
    volumes:
      - /home/sitram/docker/swag:/config
    ports:
      - 443:443
      - 80:80
    depends_on: 
      - duckdns
    restart: unless-stopped
```

### Hercules - Plex docker container

### Hercules - Guacamole docker container

### Hercules - Adminer docker container

### Hercules - PGAdmin docker container

### Hercules - PostgressSQL database docker container

### Hercules - MySQL database docker container

### Hercules - Redis docker container

### Hercules - Jenkins CI docker container

### Hercules - LibreSpeed docker container

### Hercules - PortfolioPerformance docker container

## Windows11 - Virtual Windows Desktop VM

### Windows11 - VM configuration

### Windows11 - Windows installation

### Windows11 - Remote Desktop Connection configuration

## Code - coding VM

### Code - VM configuration

- VM id: 159
- HDD: 32GB
- Sockets: 1
- Cores: 30
- RAM:
  - Min: 2048
  - Max: 16384
  - Ballooning Devices: enabled
- Machine: i440fx
- Network
  - LAN MAC address: 0E:04:4B:34:47:C4
  - Static ip assigned in pfSense: 192.168.0.113
  - Local domain record in piHole: code .local
- Options:
  - Start at boot: enabled
  - Start/Shutdown order: order=9
  - QEMU Guest Agent: enabled, guest trim
- OS: [Ubuntu Server](https://ubuntu.com/download/server)

### Code - OS Configuration

The following subsections from [General](#general) section should be performed in this order:

- [SSH configuration](#ssh-configuration)
- [Ubuntu - Synchronize time with ntpd](#ubuntu---synchronize-time-with-ntpd)
- [Update system timezone](#update-system-timezone)
- [Correct DNS resolution](#correct-dns-resolution)
- [Generate Gmail App Password](#generate-gmail-app-password)
- [Configure Postfix Server to send email through Gmail](#configure-postfix-server-to-send-email-through-gmail)
- [Mail notifications for SSH dial-in](#mail-notifications-for-ssh-dial-in)

### Code - CodeServer installation and configuration

Preview what occurs during the install process using

```bash
curl -fsSL https://code-server.dev/install.sh | sh -s -- --dry-run
```

To install CodeServer using the command below. The same command can be used to update to a newer version

```bash
curl -fsSL https://code-server.dev/install.sh | sh
```

To have `systemd` start code-server now and restart on boot:

```bash
sudo systemctl enable --now code-server@$USER
```

Edit configuration file with ```nano /home/sitram/.config/code-server/config.yaml``` and add the parameters below.

```yaml
bind-addr: 0.0.0.0:8080
auth: none
cert: false
```

Restart code-server service.

```bash
sudo systemctl restart code-server@$USER
```

### Code - Accessing CodeServer from outside local network

## ArchLinux - Desktop VM

### ArchLinux - VM configuration

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

### ArchLinux - OS Configuration

Install iNet Wireless daemon and set a delay for iwd service start

```bash
sudo pacman -S iwd
sudo systemctl enable iwd
sudo systemctl edit iwd
#add the following text
[Service]
ExecStartPre=sleep 3
```

To enable multilib repository, uncomment the `[multilib]` section in `/etc/pacman.conf`:

```bash
/etc/pacman.conf
[multilib]
Include = /etc/pacman.d/mirrorlist
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

```bash
sudo pacman -S grub os-prober network-manager base-devel linux-headers nfs-utils bash-completition xdg-user-dirs xdg-utils openssh reflector rsync acpi acpi_call pacman-contrib tree flatpak iftop docker htop neofetch
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

Add the following mounting points to `/etc/fstab/`

```bash
192.168.0.114:/mnt/tank1/data /home/sitram/mounts/data nfs defaults,auto 0 0
192.168.0.114:/mnt/tank2/media /home/sitram/mounts/media nfs defaults,auto 0 0
```

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

Uninstall graphics driver for intel because it interferes with cinnamon

```bash
sudo pacman -R xf86-video-intel
```

Disable bluetooth service and remove the existing package

```bash
sudo systemctl disable bluetooth
sudo pacman -R bluez bluez-utils pulseaudio-bluetooth
```

Desktop environment installation(Cinnamon)

- **display server**: xorg-server
- **display manager**: lightdm
- **greeter**: lightdm-webkit2-greeter lightdm-gtk-greeter lightdm-pantheon-greeter lightdm-slick-greeter
- **greeter settings editor**: lightdm-gtk-greeter-settings
- **desktop environment**: cinnamon
- **window manager(used by cinnamon as fallback in case cinnamon fails)**: metacity
- **terminal(gnome doesn't come with one)**: gnome-terminal
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

Desktop environment installation(Gnome)

- **display server**: xorg-server
- **display manager**: gdm
- **greeter**: lightdm-webkit2-greeter lightdm-gtk-greeter lightdm-slick-greeter lightdm-slick-greeter
- **greeter settings editor**: lightdm-gtk-greeter-settings
- **desktop environment**: gnome
- **window manager(used by cinnamon as fallback in case cinnamon fails)**: metacity

```bash
sudo pacman -S xorg-server gdm lightdm-webkit2-greeter lightdm-gtk-greeter lightdm-pantheon-greeter lightdm-slick-greeter lightdm-gtk-greeter-settings gnome metacity
```

Desktop environment installation(KDE)

- **display server**: xorg-server
- **display manager**: lightdm
- **greeter**: lightdm-webkit2-greeter lightdm-gtk-greeter lightdm-slick-greeter lightdm-slick-greeter
- **greeter settings editor**: lightdm-gtk-greeter-settings
- **desktop environment**: plasma
- **password manager**: gnome-keyring

```bash
sudo pacman -S xorg-server lightdm lightdm-webkit2-greeter lightdm-gtk-greeter lightdm-pantheon-greeter lightdm-slick-greeter lightdm-gtk-greeter-settings plasma gnome-terminal gnome-keyring
```

Common apps for all desktop environments:

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
- **Nvidia driver**: nvidia
- **Nvidia settings applet**: nvidia-settings
- **wallpapers**: archlinux-wallpaper
- **wine**: wine
- **wine packages for applications that depend on Internet Explorer and .NET**: wine-geko wine-mono
- **wine libraries**: lib32-libpulse
- **steam**: steam
- **icons**: papirus-icon-theme
- **themes**: arc-gtk-theme
- **fonts bor Bootstrap**: ttf-font-awesome
- **Spice agent xorg client that enables copy and paste between client and X-session and more**: spice-vdagent
- **Gnome virtual filesystems implementation**: gvfs
- **Windows File and printer sharing for Non-KDE desktops**: gvfs-smb
- **GUI system monitor**: gnome-system-monitor
- **Telegram - instant messaging system**: telegram-desktop
- **Utility to modify video**: v4l-utils
- **Live streaming and recording software**: obs-studio
- **Remote desktop client and plugins**: remmina spice-gtk freerdp
- **LightDM display manager configuration tool**: lightdm-settings

```bash
sudo pacman -S alsa-utils flameshot network-manager-applet blueberry system-config-printer libreoffice thunar file-roller thunar-archive-plugin thunar-volman thunar-media-tags-plugin okular qalculate-gtk gimp nomacs smplayer-themes smplayer-skins smtube yt-dlp shotcut handbrake nvidia nvidia-settings archlinux-wallpaper wine wine-gecko wine-mono lib32-libpulse steam papirus-icon-theme arc-gtk-theme arc-gtk-theme spice-vdagent gvfs gvfs-smb gnome-system-monitor telegram-desktop v4l-utils obs-studio remmina spice-gtk freerdp lightdm-settings
```

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

Configure [PulseAudio](https://wiki.archlinux.org/title/PulseAudio) multimedia framework

- **General-purpose sound server**: pulseaudio
- **ALSA Configuration for PulseAudio**: pulseaudio-alsa
- **Bluetooth support for PulseAudio**: pulseaudio-bluetooth
- **A GTK volume control for PulseAudio**: pacucontrol

```bash
sudo pacman -S pulseaudio pulseaudio-alsa pulseaudio-bluetooth
yay -S pavucontrol
```

Configure `lightdm` greeter by editing `lightdm.conf`. A list of all greeter-session installed on the system can be found by listing the contents of `/usr/share/xgreeters`

```bash
sudo nano /etc/lightdm/lightdm.conf

# Select the installed greeter
greeter-session = lightdm-webkit2-greeter
#Change display output for VM's only
display-setup-script=xrandr --output Virtual-1 --mode 1920x1080
```

```bash
sudo systemctl restart lightdm.service
```

Install AUR packages:

- **greeter theme**: lightdm-webkit-theme-aether
- **Google Chrome**: google-chrome
- **Zip archiver**: 7-zip
- **Visual Studio Code**: visual-studio-code-bin
- **Sublime text editor**: sublime-text-4
- **icons**: tela-icon-theme
- **themes**: mint-themes
- **Optimus Manager for systems with integrated and dedicated GPU + applet**: optimus-manager optimus-manager-qt
- **Teamviewer**: teamviewer
- **Nextcloud desktop client**: nextcloud-client
- **system information tool + helpers**: [archey4](https://github.com/HorlogeSkynet/archey4) virt-what dmidecode wmctrl pciutils lm_sensors
- **system restore utility**: timeshift
- **Pacman GUI**: pamac-aur
- **Snap**: snapd
- **InterractiveBrokers client**: ib-tws
- **Disk analyzer tool**: qdirstat

```bash
yay -S lightdm-webkit-theme-aether google-chrome 7-zip visual-studio-code-bin sublime-text-4 tela-icon-theme mint-themes optimus-manager optimus-manager-qt teamviewer nextcloud-client archey4 virt-what dmidecode wmctrl pciutils lm_sensors timeshift snapd ib-tws qdirstat
```

Enable various services:

- **NetworkManager**
- **display manager**
- **Bluetooth**
- **SSH server**
- **Reflector timer to update periodically the pacman mirrorlist**
- **Daemon for delivering ACPI events**
- **Qemu guest agent for VM's**
- **Systemd Network daemon**
- **Teamviewer daemon**
- **Optimus Manager daemon for switching between integrated and dedicated GPU**

```bash
sudo systemctl enable NetworkManager
sudo systemctl enable lightdm
sudo systemctl enable bluetooth
sudo systemctl enable sshd
sudo systemctl enable reflector.timer
sudo systemctl enable acpid
sudo systemctl enable qemu-guest-agent
sudo systemctl enable systemd-networkd
sudo systemctl enable teamviewerd
sudo systemctl enable optimus-manager.service
sudo systemctl enable docker
```

Check what graphics driver is used with `nvidia-smi`

List AUR installed packages

```bash
pacman -Qm
```

Check all enabled services

```bash
sudo systemctl list-unit-files --state=enabled
```

### ArchLinux - Network configuration

#### ArchLinux - systemd-networkd

#### ArchLinux - NetworkManager

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

### ArchLinux - Troubleshoot sound issues

```bash
dmesg | grep snd
#FWIW to properly debug pulse
systemctl --user mask pulseaudio.socket
pulseaudio -k
pulseaudio -vvv
systemctl --user mask pulseaudio.socket
```

### ArchLinux - I3 installation & Customization

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
sudo pacman -S i3-wm i3lock i3status i3blocks picom lxappearance dmenu terminator feh arandr rofi numlockx
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

### ArchLinux - ZSH shell

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

### Using pacman cache

If a package was installed at an earlier stage, and the pacman cache was not cleaned, an earlier version from `/var/cache/pacman/pkg/` can be installed.

This process will remove the current package and install the older version. Dependency changes will be handled, but pacman will not handle version conflicts. If a library or other package needs to be downgraded with the packages, please be aware that you will have to downgrade this package yourself as well.

```bash
pacman -U /var/cache/pacman/pkg/package-old_version.pkg.tar.zst
```

`old_version` could be something like `x.y.z-x86_64` where the last part is the architecture for which the package is installed.

### Using Arch Linux archive

The [Arch Linux Archive](https://wiki.archlinux.org/title/Arch_Linux_Archive) is a daily snapshot of the official repositories. It can be used to install a previous package version, or restore the system to an earlier date.

```bash
pacman -U https://archive.archlinux.org/packages/path/package-old_version.pkg.tar.zst
```

### Restore system to an earlier date

To restore all packages to their version at a specific date, let us say 30 March 2014, you have to direct pacman to this date, by replacing your `/etc/pacman.d/mirrorlist` with the following content:

```bash
##                                                                              
## Arch Linux repository mirrorlist                                             
## Generated on 2042-01-01                                                      
##
Server=https://archive.archlinux.org/repos/2014/03/30/$repo/os/$arch
```

Update the database and force downgrade:

```bash
pacman -Syyuu
```

If you get errors complaining about corrupted/invalid packages due to PGP signature, try to first update separately `archlinux-keyring` and `ca-certificates`.

## WordPress - WorPress server VM

### WordPress - VM configuration

- VM id: 160
- HDD: 16GB
- Sockets: 1
- Cores: 12
- RAM:
  - Min: 2046
  - Max: 8192
  - Ballooning Devices: enabled
- Machine: i440fx
- Network
  - LAN MAC address: 2A:56:F4:07:5D:3D
  - Static ip assigned in pfSense: 192.168.0.115
  - Local domain record in piHole: wordpress .local
- Options:
  - Start at boot: disabled
  - QEMU Guest Agent: enabled, guest trim
- OS: [Ubuntu Server](https://ubuntu.com/download/server)

### WordPress - OS Configuration

The following subsections from [General](#general) section should be performed in this order:

- [SSH configuration](#ssh-configuration)
- [Ubuntu - Synchronize time with ntpd](#ubuntu---synchronize-time-with-ntpd)
- [Update system timezone](#update-system-timezone)
- [Correct DNS resolution](#correct-dns-resolution)
- [Generate Gmail App Password](#generate-gmail-app-password)
- [Configure Postfix Server to send email through Gmail](#configure-postfix-server-to-send-email-through-gmail)
- [Mail notifications for SSH dial-in](#mail-notifications-for-ssh-dial-in)

Install the following packages as necessary basis for server operation:

```bash
sudo apt update -q4
sudo apt install -y curl gnupg2 git lsb-release ssl-cert ca-certificates apt-transport-https tree locate software-properties-common dirmngr screen htop net-tools zip unzip bzip2 ffmpeg nfs-common
```

Add the following mounting points to `/etc/fstab/`

```bash
192.168.0.114:/mnt/tank1/data /home/sitram/data nfs rw 0 0
```

Mount the newly added mount points

```bash
mkdir /home/sitram/data
sudo mount -a
```

### WordPress - Installation and configuration of nginx web server

Add software source

```bash
cd /etc/apt/sources.list.d
sudo echo "deb http://nginx.org/packages/mainline/ubuntu $(lsb_release -cs) nginx" | sudo tee nginx.list
```

In order to be able to trust the sources, use the corresponding keys:

```bash
sudo curl -fsSL https://nginx.org/keys/nginx_signing.key | sudo apt-key add -
sudo apt-get update -q4
```

Ensure that no relics from previous installations disrupt the operation of the webserver

```bash
sudo apt remove nginx nginx-extras nginx-common nginx-full -y --allow-change-held-packages
sudo apt autoremove
```

Ensure the the counterpart (Apache2) of nginx web server is neither active or installed

```bash
sudo systemctl stop apache2.service
sudo systemctl disable apache2.service
```

Install the web server and configure the service for automatic start after a system restart

```bash
sudo apt install -y nginx
sudo systemctl enable nginx.service
```

Backup standard configuration in case we need it for later, create and edit a blank one

```bash
sudo mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak
sudo touch /etc/nginx/nginx.conf
sudo nano /etc/nginx/nginx.conf
```

Copy the following configuration in the text editor.

```bash
user www-data;
worker_processes auto;
pid /var/run/nginx.pid;

events {
        worker_connections 1024;
        multi_accept on;
        use epoll;
}

http {
        server_names_hash_bucket_size 64;
        access_log /var/log/nginx/access.log;
        error_log /var/log/nginx/error.log warn;
        #either use 127.0.0.1 or own subnet
        set_real_ip_from 192.168.0.1/24;
        real_ip_header X-Forwarded-For;
        real_ip_recursive on;
        include /etc/nginx/mime.types;
        default_type application/octet-stream;
        sendfile on;
        send_timeout 3600;
        tcp_nopush on;
        tcp_nodelay on;
        open_file_cache max=500 inactive=10m;
        open_file_cache_errors on;
        keepalive_timeout 65;
        reset_timedout_connection on;
        server_tokens off;
        #either use 127.0.0.1 or own dns server
        resolver 192.168.0.103 valid=30s;
        resolver_timeout 5s;
        include /etc/nginx/conf.d/*.conf;
}
```

Save the file and close it. Restart the web server afterwards and check if the server has been successfully started.

```bash
sudo service nginx restart
sudo service nginx status
```

Create web directories used by Wordpress

```bash
sudo mkdir -p /home/sitram/wordpress/myblog
sudo mkdir -p /var/www
```

[OPTIONAL] Create the web directories used by the SSL certificates

```bash
sudo mkdir -p /var/www/letsencrypt/.well-known/acme-challenge 
sudo mkdir -p /etc/letsencrypt/rsa-certs
sudo mkdir -p /etc/letsencrypt/ecc-certs
```

[OPTIONAL] Update the self signed SSL certificate

```bash
make-ssl-cert generate-default-snakeoil -y
```

Assign the right permissions

```bash
sudo chown -R www-data:www-data /var/www /home/sitram/data/wordpress
```

### WordPress - Installation and configuration of PHP 8.0

Perform steps from chapter [Ubuntu - Configure PHP source list](#ubuntu---configure-php-source-list

Install PHP8.0 and required modules

```bash
sudo apt install -y php8.0-{fpm,mysql,curl,gd,common,imagick,mbstring,bcmath,xml,zip,intl,mcrypt,igbinary,redis} imagemagick
```

Backup original configurations

```bash
sudo cp /etc/php/8.0/fpm/pool.d/www.conf /etc/php/8.0/fpm/pool.d/www.conf.bak
sudo cp /etc/php/8.0/fpm/php-fpm.conf /etc/php/8.0/fpm/php-fpm.conf.bak
sudo cp /etc/php/8.0/cli/php.ini /etc/php/8.0/cli/php.ini.bak
sudo cp /etc/php/8.0/fpm/php.ini /etc/php/8.0/fpm/php.ini.bak
sudo cp /etc/php/8.0/fpm/php-fpm.conf /etc/php/8.0/fpm/php-fpm.conf.bak
sudo cp /etc/ImageMagick-6/policy.xml /etc/ImageMagick-6/policy.xml.bak
```

In order to adapt PHP to the configuration of the system, some parameters are calculated, using the lines below.

```bash
AvailableRAM=$(awk '/MemAvailable/ {printf "%d", $2/1024}' /proc/meminfo)
echo AvailableRAM = $AvailableRAM

AverageFPM=$(ps --no-headers -o 'rss,cmd' -C php-fpm8.0 | awk '{ sum+=$1 } END { printf ("%d\n", sum/NR/1024,"M") }')
echo AverageFPM = $AverageFPM

FPMS=$((AvailableRAM/AverageFPM))
echo FPMS = $FPMS

PMaxSS=$((FPMS*2/3))
echo PMaxSS = $PMaxSS

PMinSS=$((PMaxSS/2))
echo PMinSS = $PMinSS

PStartS=$(((PMaxSS+PMinSS)/2))
echo PStartS = $PStartS
```

Perform the following optimizations

```bash
sudo sed -i "s/;env\[HOSTNAME\] = /env[HOSTNAME] = /" /etc/php/8.0/fpm/pool.d/www.conf
sudo sed -i "s/;env\[TMP\] = /env[TMP] = /" /etc/php/8.0/fpm/pool.d/www.conf
sudo sed -i "s/;env\[TMPDIR\] = /env[TMPDIR] = /" /etc/php/8.0/fpm/pool.d/www.conf
sudo sed -i "s/;env\[TEMP\] = /env[TEMP] = /" /etc/php/8.0/fpm/pool.d/www.conf
sudo sed -i "s/;env\[PATH\] = /env[PATH] = /" /etc/php/8.0/fpm/pool.d/www.conf
sudo sed -i 's/pm.max_children =.*/pm.max_children = '$FPMS'/' /etc/php/8.0/fpm/pool.d/www.conf
sudo sed -i 's/pm.start_servers =.*/pm.start_servers = '$PStartS'/' /etc/php/8.0/fpm/pool.d/www.conf
sudo sed -i 's/pm.min_spare_servers =.*/pm.min_spare_servers = '$PMinSS'/' /etc/php/8.0/fpm/pool.d/www.conf
sudo sed -i 's/pm.max_spare_servers =.*/pm.max_spare_servers = '$PMaxSS'/' /etc/php/8.0/fpm/pool.d/www.conf
sudo sed -i "s/;pm.max_requests =.*/pm.max_requests = 1000/" /etc/php/8.0/fpm/pool.d/www.conf
sudo sed -i "s/allow_url_fopen =.*/allow_url_fopen = 1/" /etc/php/8.0/fpm/php.ini
```

```bash
sudo sed -i "s/output_buffering =.*/output_buffering = 'Off'/" /etc/php/8.0/cli/php.ini
sudo sed -i "s/max_execution_time =.*/max_execution_time = 3600/" /etc/php/8.0/cli/php.ini
sudo sed -i "s/max_input_time =.*/max_input_time = 3600/" /etc/php/8.0/cli/php.ini
sudo sed -i "s/post_max_size =.*/post_max_size = 10240M/" /etc/php/8.0/cli/php.ini
sudo sed -i "s/upload_max_filesize =.*/upload_max_filesize = 10240M/" /etc/php/8.0/cli/php.ini
sudo sed -i "s/;date.timezone.*/date.timezone = Europe\/\Bucharest/" /etc/php/8.0/cli/php.ini
```

```bash
sudo sed -i "s/memory_limit = 128M/memory_limit = 1024M/" /etc/php/8.0/fpm/php.ini
sudo sed -i "s/output_buffering =.*/output_buffering = 'Off'/" /etc/php/8.0/fpm/php.ini
sudo sed -i "s/max_execution_time =.*/max_execution_time = 3600/" /etc/php/8.0/fpm/php.ini
sudo sed -i "s/max_input_time =.*/max_input_time = 3600/" /etc/php/8.0/fpm/php.ini
sudo sed -i "s/post_max_size =.*/post_max_size = 10240M/" /etc/php/8.0/fpm/php.ini
sudo sed -i "s/upload_max_filesize =.*/upload_max_filesize = 10240M/" /etc/php/8.0/fpm/php.ini
sudo sed -i "s/;date.timezone.*/date.timezone = Europe\/\Bucharest/" /etc/php/8.0/fpm/php.ini
sudo sed -i "s/;session.cookie_secure.*/session.cookie_secure = True/" /etc/php/8.0/fpm/php.ini
sudo sed -i "s/;opcache.enable=.*/opcache.enable=1/" /etc/php/8.0/fpm/php.ini
sudo sed -i "s/;opcache.enable_cli=.*/opcache.enable_cli=1/" /etc/php/8.0/fpm/php.ini
sudo sed -i "s/;opcache.memory_consumption=.*/opcache.memory_consumption=128/" /etc/php/8.0/fpm/php.ini
sudo sed -i "s/;opcache.interned_strings_buffer=.*/opcache.interned_strings_buffer=8/" /etc/php/8.0/fpm/php.ini
sudo sed -i "s/;opcache.max_accelerated_files=.*/opcache.max_accelerated_files=10000/" /etc/php/8.0/fpm/php.ini
sudo sed -i "s/;opcache.revalidate_freq=.*/opcache.revalidate_freq=1/" /etc/php/8.0/fpm/php.ini
sudo sed -i "s/;opcache.save_comments=.*/opcache.save_comments=1/" /etc/php/8.0/fpm/php.ini
```

```bash
sudo sed -i "s|;emergency_restart_threshold.*|emergency_restart_threshold = 10|g" /etc/php/8.0/fpm/php-fpm.conf
sudo sed -i "s|;emergency_restart_interval.*|emergency_restart_interval = 1m|g" /etc/php/8.0/fpm/php-fpm.conf
sudo sed -i "s|;process_control_timeout.*|process_control_timeout = 10|g" /etc/php/8.0/fpm/php-fpm.conf
```

```bash
sudo sed -i '$aapc.enable_cli=1' /etc/php/8.0/mods-available/apcu.ini
```

```bash
sudo sed -i "s/rights=\"none\" pattern=\"PS\"/rights=\"read|write\" pattern=\"PS\"/" /etc/ImageMagick-6/policy.xml
sudo sed -i "s/rights=\"none\" pattern=\"EPS\"/rights=\"read|write\" pattern=\"EPS\"/" /etc/ImageMagick-6/policy.xml
sudo sed -i "s/rights=\"none\" pattern=\"PDF\"/rights=\"read|write\" pattern=\"PDF\"/" /etc/ImageMagick-6/policy.xml
sudo sed -i "s/rights=\"none\" pattern=\"XPS\"/rights=\"read|write\" pattern=\"XPS\"/" /etc/ImageMagick-6/policy.xml
```

Restart PHP and nginx and check that they are working correctly

```bash
sudo service php8.0-fpm restart
sudo service nginx restart

sudo service php8.0-fpm status
sudo service nginx status
```

[TODO] For troubleshooting of php-fpm check [here](https://www.c-rieger.de/nextcloud-und-php-troubleshooting/)

### Wordpress - Installation and configuration of MariaDB database

[OPTIONAL] This step is optional and can be skipped if using MySQL or MariaDB in a docker instance on a dedicated server.

Add software source

```bash
cd /etc/apt/sources.list.d
sudo echo "deb http://ftp.hosteurope.de/mirror/mariadb.org/repo/10.6/ubuntu $(lsb_release -cs) main" | sudo tee mariadb.list
```

In order to be able to trust the sources, use the corresponding keys:

```bash
apt-key adv --recv-keys --keyserver hkps://keyserver.ubuntu.com:443 0xF1656F24C74CD1D8
sudo apt-get update -q4
sudo make-ssl-cert generate-default-snakeoil -y
```

Install MariaDB

```bash
sudo apt install -y mariadb-server
```

Harden the database server using the supplied tool "mysql_secure_installation". When installing for the first time, there is no root password, so you can confirm the query with ENTER. It is recommended to set a password directly, the corresponding dialog appears automatically.

```bash
mysql_secure_installation
```

```bash
Enter current password for root (enter for none): <ENTER> or type the password
```

```bash
Switch to unix_socket authentication [Y/n] Y
```

```bash
Set root password? [Y/n] Y
```

```bash
Remove anonymous users? [Y/n] Y
Disallow root login remotely? [Y/n] Y
Remove test database and access to it? [Y/n] Y
Reload privilege tables now? [Y/n] Y
```

Stop the database server and then save the standard configuration

```bash
sudo service mysql stop
sudo mv /etc/mysql/my.cnf /etc/mysql/my.cnf.bak
sudo nano /etc/mysql/my.cnf
```

Copy the following configuration

```ini
[client]
    default-character-set = utf8mb4
    port = 3306
    socket = /var/run/mysqld/mysqld.sock

[mysqld_safe]
    log_error=/var/log/mysql/mysql_error.log
    nice = 0
    socket = /var/run/mysqld/mysqld.sock

[mysqld]
    basedir = /usr
    bind-address = 127.0.0.1
    binlog_format = ROW
    bulk_insert_buffer_size = 16M
    character-set-server = utf8mb4
    collation-server = utf8mb4_general_ci
    concurrent_insert = 2
    connect_timeout = 5
    datadir = /var/lib/mysql
    default_storage_engine = InnoDB
    expire_logs_days = 2
    general_log_file = /var/log/mysql/mysql.log
    general_log = 0
    innodb_buffer_pool_size = 1024M
    innodb_buffer_pool_instances = 1
    innodb_flush_log_at_trx_commit = 2
    innodb_log_buffer_size = 32M
    innodb_max_dirty_pages_pct = 90
    innodb_file_per_table = 1
    innodb_open_files = 400
    innodb_io_capacity = 4000
    innodb_flush_method = O_DIRECT
    innodb_read_only_compressed=OFF
    #Required from MariaDB 10.6, see [link](https://mariadb.com/kb/en/upgrading-from-mariadb-105-to-mariadb-106/#innodb-compressed-row-format)
    key_buffer_size = 128M
    lc_messages_dir = /usr/share/mysql
    lc_messages = en_US
    log_bin = /var/log/mysql/mariadb-bin
    log_bin_index = /var/log/mysql/mariadb-bin.index
    log_error = /var/log/mysql/mysql_error.log
    log_slow_verbosity = query_plan
    log_warnings = 2
    long_query_time = 1
    max_allowed_packet = 16M
    max_binlog_size = 100M
    max_connections = 200
    max_heap_table_size = 64M
    myisam_recover_options = BACKUP
    myisam_sort_buffer_size = 512M
    port = 3306
    pid-file = /var/run/mysqld/mysqld.pid
    query_cache_limit = 2M
    query_cache_size = 64M
    query_cache_type = 1
    query_cache_min_res_unit = 2k
    read_buffer_size = 2M
    read_rnd_buffer_size = 1M
    skip-external-locking
    skip-name-resolve
    slow_query_log_file = /var/log/mysql/mariadb-slow.log
    slow-query-log = 1
    socket = /var/run/mysqld/mysqld.sock
    sort_buffer_size = 4M
    table_open_cache = 400
    thread_cache_size = 128
    tmp_table_size = 64M
    tmpdir = /tmp
    transaction_isolation = READ-COMMITTED
    #unix_socket=OFF
    user = mysql
    wait_timeout = 600

[mysqldump]
    max_allowed_packet = 16M
    quick
    quote-names

[isamchk]
    key_buffer = 16M
```

Save and close the file, then restart the database server

```bash
service mysql restart
```

### Wordpress - Database creation

Create Nextcloud database, user and password. Use `-h localhost` MariaDB is installed locally or `-h IP` if on a remote server

```bash
mysql -u root -p -h 192.168.0.101 -P 3306
```

```sql
CREATE DATABASE wordpress_myblog CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
CREATE USER nwordpress_myblog_user@localhost identified by 'wordpress_myblog_password';
GRANT ALL PRIVILEGES on wordpress_myblog.* to nwordpress_myblog_user;
FLUSH privileges;
quit;
```

### Wordpress - Installation and optimization

We will now set up various vhost, i.e. server configuration files, and modify the standard vhost file persistently.

If exists, backup existing configuration. Create empty vhosts files. The empty "default.conf" file ensures that the standard configuration does not affect Wordpress operation even when the web server is updated later.

```bash
[ -f /etc/nginx/conf.d/default.conf ] && sudo mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.bak
```

```bash
sudo touch /etc/nginx/conf.d/default.conf
sudo touch /etc/nginx/conf.d/http.conf
sudo touch /etc/nginx/conf.d/myblog.conf
```

Create the global vhost file to permanently redirect the http standard requests to https and optionally to enable SSL certificate communication with Let's Encrypt.

```bash
sudo nano /etc/nginx/conf.d/http.conf
```

```bash
upstream php-handler {
    server unix:/run/php/php8.0-fpm.sock;
}

server {
    listen 80 default_server;
    listen [::]:80 default_server;

    server_name sitram.duckdns.org www.sitram.duckdns.org;
    
    root /home/sitram/data/wordpress;
    # Uncomment the lines below to enable SSL certificate communication with Let's Encrypt
    #location ^~ /.well-known/acme-challenge {
    #    default_type text/plain;
    #    root /home/sitram/data/wordpress/letsencrypt;
    #}

    location / {
        return 301 https://$host$request_uri;
    }
}
```

For every wordpress instance, create a new .conf file, copy the following lines and adjust the values if needed.

```bash
sudo nano /etc/nginx/conf.d/myblog.conf
```

```bash
server {
   listen 443 ssl http2;
   listen [::]:443 ssl http2;

   server_name blog.*;

   ssl_certificate /etc/ssl/certs/ssl-cert-snakeoil.pem;
   ssl_certificate_key /etc/ssl/private/ssl-cert-snakeoil.key;
   ssl_trusted_certificate /etc/ssl/certs/ssl-cert-snakeoil.pem;
   #ssl_certificate /etc/letsencrypt/rsa-certs/fullchain.pem;
   #ssl_certificate_key /etc/letsencrypt/rsa-certs/privkey.pem;
   #ssl_certificate /etc/letsencrypt/ecc-certs/fullchain.pem;
   #ssl_certificate_key /etc/letsencrypt/ecc-certs/privkey.pem;
   #ssl_trusted_certificate /etc/letsencrypt/ecc-certs/chain.pem;
   ssl_dhparam /etc/ssl/certs/dhparam.pem;
   ssl_session_timeout 1d;
   ssl_session_cache shared:SSL:50m;
   ssl_session_tickets off;
   ssl_protocols TLSv1.3 TLSv1.2;
   ssl_ciphers 'TLS-CHACHA20-POLY1305-SHA256:TLS-AES-256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA512:DHE-RSA-AES256-GCM-SHA512:ECDHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES256-GCM-SHA384';
   ssl_ecdh_curve X448:secp521r1:secp384r1;
   ssl_prefer_server_ciphers on;
   ssl_stapling on;
   ssl_stapling_verify on;

   client_max_body_size 10G;
   fastcgi_buffers 64 4K;
    
   gzip on;
   gzip_vary on;
   gzip_comp_level 4;
   gzip_min_length 256;
   gzip_proxied expired no-cache no-store private no_last_modified no_etag auth;
   gzip_types application/atom+xml application/javascript application/json application/ld+json application/manifest+json application/rss+xml application/vnd.geo+json application/vnd.ms-fontobject application/x-font-ttf application/x-web-app-manifest+json application/xhtml+xml application/xml font/opentype image/bmp image/svg+xml image/x-icon text/cache-manifest text/css text/plain text/vcard text/vnd.rim.location.xloc text/vtt text/x-component text/x-cross-domain-policy;    
   
   add_header Strict-Transport-Security            "max-age=15768000; includeSubDomains; preload;" always;
   add_header Permissions-Policy                   "interest-cohort=()";
   add_header Referrer-Policy                      "no-referrer"   always;
   add_header X-Content-Type-Options               "nosniff"       always;
   add_header X-Download-Options                   "noopen"        always;
   add_header X-Frame-Options                      "SAMEORIGIN"    always;
   add_header X-Permitted-Cross-Domain-Policies    "none"          always;
   add_header X-Robots-Tag                         "none"          always;
   add_header X-XSS-Protection                     "1; mode=block" always;
   
   fastcgi_hide_header X-Powered-By;

   root /home/sitram/data/wordpress/myblog;

   index index.php;

   location = /favicon.ico {
       log_not_found off;
       access_log off;
   }

   location = /robots.txt {
       allow all;
       log_not_found off;
       access_log off;
   }

   location / {
       # This is cool because no php is touched for static content.
       # include the "?$args" part so non-default permalinks doesn't break when using query string
       try_files $uri $uri/ /index.php?$args;
   }

   location ~ \.php$ {
       #NOTE: You should have "cgi.fix_pathinfo = 0;" in php.ini
       include fastcgi_params;
       fastcgi_pass php-handler;
       fastcgi_intercept_errors on;
       #The following parameter can be also included in fastcgi_parms file
       fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    }

    location ~* \.(js|css|png|jpg|jpeg|gif|ico)$ {
       expires max;
       log_not_found off;
   }
}
```

Extend the server and system security with the possibility of a secure key exchange using a Diffie-Hellman key(dhparam.pem)

```bash
sudo openssl dhparam -dsaparam -out /etc/ssl/certs/dhparam.pem 4096
```

Restart webserver

```bash
sudo service nginx restart
sudo service nginx status
```

Download the current Wordpress release.

```bash
cd /usr/local/src
sudo wget https://wordpress.org/latest.tar.gz
```

Unzip Wordpress software into the web directy(/home/sitram/data/wordpress/myblog) then set the right permissions.

```bash
sudo tar -xzf latest.tar.gz -C /home/sitram/data/wordpress/myblog
sudo mv /home/sitram/data/wordpress/myblog/wordpress/* /home/sitram/data/wordpress/myblog
sudo chown -R www-data:www-data /home/sitram/data/wordpress/myblog
sudo rm -f latest.tar.gz 
sudo rm -R /home/sitram/data/wordpress/myblog/wordpress
```

[OPTIONAL] Creationg an update of Let's Encrypt certificates is mandatory via http and port 80 so make sure the server can be reached from outside.

Create a dedicate user for certificate handling and add this user to www-data group

```bash
adduser --disabled-login acmeuser
usermod -a -G www-data acmeuser
```

Give this user the nessecary permission to start the web server when a certificate is renewed.

```bash
visudo
```

In the middle of the file, below

```bash
[..]
User privilege specification
root ALL=(ALL:ALL) ALL
[..]
```

add the following line

```bash
acmeuser ALL=NOPASSWD: /bin/systemctl reload nginx.service
```

After saving and exit, switch to the shell of the new user and install the certificate software.

```bash
su - acmeuser
curl https://get.acme.sh | sh
exit
```

Adjust the appropriate permissions to be able to save the new certificates in it.

```bash
sudo chmod -R 775 /home/sitram/wordpress/ letsencrypt
sudo chmod -R 770 /etc/letsencrypt
sudo chown -R www-data:www-data /home/sitram/wordpress/ /etc/letsencrypt
```

Set Let's Encrypt as the default CA for your server

```bash
su - acmeuser -c ".acme.sh/acme.sh --set-default-ca --server letsencrypt
```

and then switch to the new user's shell again

```bash
su - acmeuser
```

Request the SSL certificates from Let's Encrypt and replace domain if needed

```bash
acme.sh --issue -d blog.sitram.duckdns.org --server letsencrypt --keylength 4096 -w /home/sitram/wordpress/letsencrypt --key-file /etc/letsencrypt/rsa-certs/privkey.pem --ca-file /etc/letsencrypt/rsa-certs/chain.pem --cert-file /etc/letsencrypt/rsa-certs/cert.pem --fullchain-file /etc/letsencrypt/rsa-certs/fullchain.pem --reloadcmd "sudo /bin/systemctl reload nginx.service"
```

```bash
acme.sh --issue -d blog.sitram.duckdns.org --server letsencrypt --keylength ec-384 -w /home/sitram/wordpress/letsencrypt --key-file /etc/letsencrypt/ecc-certs/privkey.pem --ca-file /etc/letsencrypt/ecc-certs/chain.pem --cert-file /etc/letsencrypt/ecc-certs/cert.pem --fullchain-file /etc/letsencrypt/ecc-certs/fullchain.pem --reloadcmd "sudo /bin/systemctl reload nginx.service"
```

exit new user's shell

```bash
exit
```

Create the file permissions.sh with the following contents

```bash
#!/bin/bash
sudo find /var/www/ -type f -print0 | xargs -0 chmod 0640
sudo find /var/www/ -type d -print0 | xargs -0 chmod 0750
sudo chmod -R 775 /home/sitram/wordpress/letsencrypt
sudo chmod -R 770 /etc/letsencrypt 
sudo chown -R www-data:www-data /home/sitram/wordpress /etc/letsencrypt
exit 0
```

Make script executable and run it

```bash
chmod + x /home/sitram/permissions.sh
/home/sitram/permissions.sh
```

Remove your previously used self-signed certificates from nginx and activate the new, full-fledged and already valid SSL certificates from Let's Encrypt. Then restart the web server.

```bash
sed -i '/ssl-cert-snakeoil/d' /etc/nginx/conf.d/blog.conf
sed -i s/#\ssl/\ssl/g /etc/nginx/conf.d/blog.conf
service nginx restart
```

In order to automatically renew the SSL certificates as well as to initiate the necessary web server restart, a cron job was automatically created.

```bash
crontab -l -u acmeuser
```

### Wordpress - Installation of Redis server

Use Redis to increase the Wordpress performance, as Redis reduces the load on the database.

This step is optional and can be skipped if plugins like [Redis Object Cache](https://wordpress.org/plugins/redis-cache/) is not used

Make sure `lsb-release` is installed first then add the repository to the `apt` index, update it, and then install `redis`

```bash
sudo apt install lsb-release

curl -fsSL https://packages.redis.io/gpg | sudo gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/redis.list

sudo apt-get update
sudo apt-get install redis
```

Adjust the redisk configuration by saving and adapting the configuration using the following commands

```bash
sudo cp /etc/redis/redis.conf /etc/redis/redis.conf.bak

sudo mkdir /var/run/redis
sudo chown redis:www-data /var/run/redis

sudo sed -i '0,/port 6379/s//port 0/' /etc/redis/redis.conf
sudo sed -i s/\#\ unixsocket/\unixsocket/g /etc/redis/redis.conf
sudo sed -i "s/unixsocket \/run\/redis.sock/unixsocket \/var\/run\/redis\/redis.sock/" /etc/redis/redis.conf
sudo sed -i "s/unixsocketperm 700/unixsocketperm 777/" /etc/redis/redis.conf
```

Test `redis` connection from PHP:

```php
php -a
php > $redis = new Redis();
php > $redis->connect(‘/home/user1/.redis/redis.sock’);
php > $res = $redis->ping();
php > echo $res;
1
php > exit
```

Add the following defines in `wp-config.php` before the last line which includes `wp-settings.php` so that plugin [Redis Object Cache](https://wordpress.org/plugins/redis-cache/) works

```php
define( 'WP_REDIS_SCHEME', 'unix' );
define( 'WP_REDIS_PATH', '/var/run/redis/redis.sock' );
```

Background save may file under low memory conditions. To fix this issue 'm.overcommit_memory' has to be set to 1.

```bash
sudo cp /etc/sysctl.conf /etc/sysctl.conf.bak
sudo sed -i '$ avm.overcommit_memory = 1' /etc/sysctl.conf
sudo reboot now
```
