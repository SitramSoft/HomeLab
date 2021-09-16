# Proxmox-Homelab
The following document describes the steps I did to create the current configuration of my Homelab.

Prerequisites:
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

Summary:
- [About my Homelab](#about-my-homelab)
- [Introduction](#introduction)
    - [How I started](#how-i-started)
    - [HomeLab architecture](#homelab-architecture)
    - [Document structure](#document-structure)
- [General](#general)
    - [SSH configuration](#ssh-configuration)
    - [Ubuntu Server update](#ubuntu-server-update)
    - [Update timeserver](#update-timeserver)
    - [Update system timezone](#update-system-timezone)
    - [Correct DNS resolution](#correct-dns-resolution)
- [Nextcloud server](#nextcloud-server)
    - [Nextcloud - VM configuration](#nextcloud---vm-configuration)
    - [Nextcloud - OS Configuration](#nextcloud---os-configuration)
    - [Nextcloud - Installation and configuration of nginx web server](#nextcloud---installation-and-configuration-of-nginx-web-server)
    - [Nextcloud - Installation and configuration of PHP 8.0](#nextcloud---installation-and-configuration-of-php-80)
    - [Nextcloud - Installation and configuration of MariaDB database](#nextcloud---installation-and-configuration-of-mariadb-database)
    - [Nextcloud - Installation of Redis server](#nextcloud---installation-of-redis-server)
### Nextcloud - Installation and optimization of Nextcloud


## About my Homelab
This repository is intended to record my experience in setting up a HomeLab using a dedicated server running [Proxmox](https://www.proxmox.com/en/) with various services running in several VM's and LXC's. I will be touching topics related to virtualization, hardware passtrough, LXC, Docker and several services which I currently use. This document is a work in progress and will evolve as I gain more experience and find more interesting stuff to do. I do not intend this repository or this document to be taken as a tutorial because I don't consider myself an expert in this area. 

Use the information provided in this repository at your own risk. I take no responsibility for any damage to your equipment. Depending on my availability I can support if asked in solving issues with your software but be prepared to troubleshoot stuff that don't work on your own. My recommendation is to take the information that I provide here and adapt it to your own needs and hardware. For any questions please contact me at **adrian.martis (at) gmail . com**

## Introduction
### How I started
Initially I started using my adventure in building an HomeLab on an old laptop, where I installed Proxmox and did some testing with several VM's and [HomeAssistant](https://www.home-assistant.io/). It probably would have been enough if it didn't had two annoying issues. Every couple of days, it would freeze and I had to manually reboot it in order to recover. The second issue was that was the BIOS did not support resume to the last state in case of a power shortage. Because of these two issues I couldn't run the laptop for more then a few days without having to physically interact with it.This made any attempt to have a reliable server for running services or home automation annoying. After struggling with this setup for a couple of months I decided it was time for an upgrade.

I spent several weeks researching on Internet about various hardware build for HomeLab. I read blogs, joined several channels on Reddit and groups on Facebook dedicated to this topic. The more I spent researching, the more I got frustrated of how easy it was for people living in US, Germany or UK to access all kind of equipment. I either had to make a compromise and buy consumer grade equipment, spent extra money on shipping tax to order, or get lucky and find a  good deal in my own country.

In the end, it payed off to be patient, because I got lucky and found a complete system for sale locally. Everyone I talked with, said it was overkill for what I wanted to run in my HomeLab. I chose to see it as having a huge potential for any project I could think of. I payed for the entire server around 800$.

The server contained the case, PSU, cables, two Intel Xeon CPU's and 192GB of server graded RAM with ECC. I had two 1GB, 2.5', 7200 rpm HDD's in another laptop which I decided to use in RAID 1 to keep some of my data safe. I bought a 1TB M.2 2280 SSD from SWORDFISH to use for host operating system and various VM's. The final purchase was an HPE Ethernet 1GB 2-port 361T adapter which I wanted to passtrough to a VM running a dedicated firewall.

### HomeLab architecture
Over time, I added new hardware to my HomeLab, like IoT devices, a range extender to have a better Wifi coverage and an UPS. I have planned to upgrade my storage and perhaps purchase a GPU but they have a low priority for now. However, I am always open for suggestions so feel free to reach me over email.

The software, services and the architecture I run in my HomeLab are constantly adapting and evolving. When I learn a new technology that or find an interesting software, I decide to incorporate it in my existing architecture or just spin a VM for test. 

[Here](HomeLab.jpg) you can find a picture with an overview of the current architecture which I update every time I change something to my HomeLab. The details on the configuration of each VM and service are below.

### Document structure
The document is written in Markdown and structured in 3 main sections. 

First section contains a short history, current HomeLab state and structure of the document. 

The second section contains general configurations that are applied to every VM. Some of the commands assume that either the DHCP or the DNS server is up and running, so please keep this in mind when reading.

The third section contains a chapter for every VM I currently run. Inside each chapter there are sections that describe the VM configuration in Proxmox, specific OS configurations, software and services installation and configuration.

## General
The following sections apply to all VM's. 

Unless the services running on the VM require a dedicated OS, I prefer to use Ubuntu Server. The sections in this chapter are tested on Ubuntu Server but might apply with slight modifications to other Linux based operating systems. For each VM I will specify which chapter from this section applies. 

Every VM has user **sitram** configured during installation. The user has **sudo** privileges.


### SSH configuration
I use two keys for my entire HomeLab. One is used for Guacamole, so I can access from any web browser my servers in case I don't have access trough a SSH client. The other is my personal key which I use for accessing trough SSH clients. 

I store these keys on every VM so that I can easily connect from one VM to another using SSH. A copy of each key is stored in an offline secure location.

Login to one of existing VM's and copy sshd config and various keys to the new VM.
 - sshd configuration
```
scp /etc/ssh/sshd_config sitram@192.168.0.xxx:/home/sitram
```
 - Private and public keys for accessing the VM trough Guacamole
 ```
scp guacamole sitram@192.168.0.xxx:~/.ssh/
scp guacamole.pub sitram@192.168.0.xxx:~/.ssh/
```
 - Personal private and public keys for accessing the VM trough SSH and being able to access other servers on the network.
```
scp id_rsa sitram@192.168.0.xxx:~/.ssh/
scp id_rsa.pub sitram@192.168.0.xxx:~/.ssh/
```
 - The authorized keys file which allows connection to the VM using only my Guacamole or personal key.
```
scp authorized_keys sitram@192.168.0.xxx:~/.ssh/
```

[TODO] Add details about sshd configuration

Backup default sshd configuration, in case something goes wrong. Replace the existing configuration with the new one.
```
sudo mv /etc/ssh/sshd_config /etc/ssh/sshd_config.bkp
sudo mv ~/sshd_config /etc/ssh/
sudo chown root:root /etc/ssh/sshd_config
```

Restart sshd to use the new configuration.
```
sudo systemctl restart sshd
```

### Ubuntu Server update
```
sudo apt update
sudo apt list --upgradable
sudo apt upgrade
```

### Update timeserver
I have a dedicated timeserver which servers all the clients in my HomeLab. Whenever it is possible, I configure each server to use the internal timeserver.

Edit file **timesyncd.conf**
```
sudo nano /etc/systemd/timesyncd.conf
```


Uncomment and modify the lines starting with **NTP** and **FallbackNTP**
```
NTP=192.168.0.1
FallbackNTP=pool.ntp.org
```

Restart the timesync daemon to use the internal timserver
```
sudo systemctl restart systemd-timesyncd
```

### Update system timezone
Set system timezone to my local timezone.
```
sudo timedatectl set-timezone Europe/Bucharest
```

Check that system timezone, system clock synchronization and NTP services are correct
```
sudo timedatectl
```

### Correct DNS resolution
```
sudo rm -f /etc/resolv.conf
sudo ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf
sudo systemctl restart systemd-resolved.service
```

## Firewall DHCP and NTP server
### pfSense VM configuration
### PfSense setup
### DHCP server setup
### NTP server setup
### OpenVPN setup 

## All-around DNS solution
### piHole VM configuration
### piHole setup
### Ubound as a recursive DNS server
### Local DNS configuration

## Home automation with HomeAssistant
### HomeAssistant VM configuration
### HomeAssistant installation and setup
### Other plugins(TBD)

## Nextcloud server
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
    - Start/Shutdown order: 6
    - QEMU Guest agent: enabled
    - Run guest-trim after a disk move or VM migration: enabled
 - OS: Ubuntu Server 21.04 amd64 

### Nextcloud - OS Configuration
The following subsections from [General](#general) section should be peformed in this order:
 - [SSH configuration](#ssh-configuration)
 - [Ubuntu Server update](#ubuntu-server-update)
 - [Update timeserver](#update-timeserver)
 - [Update system timezone](#update-system-timezone)
 - [Correct DNS resolution](#correct-dns-resolution)

Install the following packages as necessary basis for server operation:
```
sudo apt update -q4
sudo apt install -y curl gnupg2 git lsb-release ssl-cert ca-certificates apt-transport-https tree locate software-properties-common dirmngr screen htop net-tools zip unzip bzip2 ffmpeg ghostscript libfile-fcntllock-perl libfontconfig1 libfuse2 socat
```

### Nextcloud - Installation and configuration of nginx web server
Add software source
```
cd /etc/apt/sources.list.d
echo "deb http://nginx.org/packages/mainline/ubuntu $(lsb_release -cs) nginx" | tee nginx.list
```

In order to be able to trust the sources, use the corresponding keys:
```
sudo curl -fsSL https://nginx.org/keys/nginx_signing.key | sudo apt-key add -
sudo apt-update -q4
sudo make-ssl-cert generate-default-snakeoil -y
```

Ensure that no relics from previous installations disrupt the operation of the webserver
```
sudo apt remove nginx nginx-extras nginx-common nginx-full -y --allow-change-held-packages
```

Ensure the the counterpart (Apache2) of nginx web server is neither active or installed
```
sudo systemctl stop apache2.service
sudo systemctl disable apache2.service
```

Install the web server and configure the service for automatic start after a system restart
```
sudo apt install -y nginx
sudo systemctl enable nginx.service
```

Backup standard configuration in case we need it for later, create and edit a blank one
```
sudo mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak
sudo touch /etc/nginx/nginx.conf
sudo nano /etc/nginx/nginx.conf
```

Copy the following configuration in the text editor. 
```
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
        set_real_ip_from 192.168.2.0/24;
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

```
sudo service nginx restart
sudo service nginx status
```

Create folders and assign the right permissions
```
sudo mkdir -p /var/nc_data
sudo chown -R www-data:www-data /var/nc_data /var/www
```

### Nextcloud - Installation and configuration of PHP 8.0
Add software source
```
cd /etc/apt/sources.list.d
echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu $(lsb_release -cs) main" | tee php.list
```

In order to be able to trust the sources, use the corresponding keys:
```
sudo apt-key adv --recv-keys --keyserver hkps://keyserver.ubuntu.com:443 4F4EA0AAE5267A6C
sudo apt-update -q4
sudo make-ssl-cert generate-default-snakeoil -y
```

### Nextcloud - Installation and configuration of MariaDB database
Add software source
```
cd /etc/apt/sources.list.d
echo "deb http://ftp.hosteurope.de/mirror/mariadb.org/repo/10.6/ubuntu $(lsb_release -cs) main" | tee mariadb.list
```

In order to be able to trust the sources, use the corresponding keys:
```
apt-key adv --recv-keys --keyserver hkps://keyserver.ubuntu.com:443 0xF1656F24C74CD1D8
sudo apt-update -q4
sudo make-ssl-cert generate-default-snakeoil -y
```
### Nextcloud - Installation of Redis server
### Nextcloud - Installation and optimization of Nextcloud
## HomeLab services
### Hercules VM configuration
### Docker installation and docker-compose
### Portainer docker container
### Guacamole docker container
### Watchtower docker container
### Heimdall docker container
### Plex docker container
### Tautulli docker container
### Radarr docker container
### Sonarr docker container
### Bazarr docker container
### Lidarr docker container
### Jackett docker container
### Transmission docker container
### DuckDNS docker container
### Secure Web Application Gateway docker container
### Calibre docker container
### Calibre-web docker container
### Adminer docker container
### PGAdmin docker container
### PostgressSQL database docker container
### MySQL database docker container
### Redis docker container
### NextCloud docker container
### Collabora docker container
### WordPress docker container
### Jenkins CI docker container
### LibreSpeed docker container

## Virtual Windows Desktop
### Windows10 VM configuration
### Windows installation
### Remote Desktop Connection configuration

## Virtual coding IDE
### CodeServer VM configuration
### CodeServer installation and configuration
### Accessing CodeServer from outside local network