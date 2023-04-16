Table of contents:

- [About my Homelab](./general/general.md#about-my-homelab)
- [Introduction](./general/general.md#introduction)
  - [How I started](./general/general.md#how-i-started)
  - [HomeLab architecture](./general/general.md#homelab-architecture)
  - [Document structure](./general/general.md#document-structure)
  - [Prerequisites](./general/general.md#prerequisites)
- [General](./general/general.md#general)
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
  - [Hercules - PostgressSQL database docker container](#hercules---postgresssql-database-docker-container)
  - [Hercules - MySQL database docker container](#hercules---mysql-database-docker-container)
  - [Hercules - Adminer docker container](#hercules---adminer-docker-container)
  - [Hercules - PGAdmin docker container](#hercules---pgadmin-docker-container)
  - [Hercules - Guacamole daemon and web application docker container](#hercules---guacamole-daemon-and-web-application-docker-container)
  - [Hercules - Redis docker container](#hercules---redis-docker-container)
  - [Hercules - LibreSpeed docker container](#hercules---librespeed-docker-container)
  - [Hercules - Authelia docker container](#hercules---authelia-docker-container)
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
    - [Using pacman cache](#using-pacman-cache)
    - [Using Arch Linux Archive](#using-arch-linux-archive)
    - [Restore system to an earlier date](#restore-system-to-an-earlier-date)
  - [ArchLinux - Connect Android To Arch Linux Via USB](#archlinux---connect-android-to-arch-linux-via-usb)
- [WordPress - WorPress server VM](#wordpress---worpress-server-vm)
  - [WordPress - VM configuration](#wordpress---vm-configuration)
  - [WordPress - OS Configuration](#wordpress---os-configuration)
  - [WordPress - Installation and configuration of nginx web server](#wordpress---installation-and-configuration-of-nginx-web-server)
  - [WordPress - Installation and configuration of PHP 8.0](#wordpress---installation-and-configuration-of-php-80)
  - [WordPress - Installation and configuration of MariaDB database](#wordpress---installation-and-configuration-of-mariadb-database)
  - [WordPress - Database creation](#wordpress---database-creation)

# Nextcloud - Content collaboration server

## Nextcloud - VM configuration

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
  - QEMU Guest agent: enabled - [Qemu-guest-agent](./general/general.md#qemu-guest-agent)
  - Run guest-trim after a disk move or VM migration: enabled
- OS: Ubuntu Server 21.04 amd64

## Nextcloud - OS Configuration

The following subsections from [General](./general/general.md#general) section should be performed in this order:

- [SSH configuration](./general/general.md#ssh-configuration)
- [Ubuntu - Synchronize time with ntpd](./general/general.md#ubuntu---synchronize-time-with-ntpd)
- [Update system timezone](./general/general.md#update-system-timezone)
- [Correct DNS resolution](./general/general.md#correct-dns-resolution)
- [Generate Gmail App Password](./general/general.md#generate-gmail-app-password)
- [Configure Postfix Server to send email through Gmail](./general/general.md#configure-postfix-server-to-send-email-through-gmail)
- [Mail notifications for SSH dial-in](./general/general.md#mail-notifications-for-ssh-dial-in)

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

## Nextcloud - Installation and configuration of nginx web server

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

## Nextcloud - Installation and configuration of PHP 8.0

Perform steps from chapter [Ubuntu - Configure PHP source list](./general/general.md#ubuntu---configure-php-source-list)

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

## Nextcloud - Installation and configuration of MariaDB database

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

## Nextcloud - Database creation

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

## Nextcloud - Installation of Redis server

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

## Nextcloud - Installation and optimization of Nextcloud

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

## Nextcloud - Optimize and update using a script

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

## Nextcloud - Bash aliases for executing Nextcloud Toolset occ

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

## Nextcloud - Map user data directory to nfs share

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

# Hercules - HomeLab services VM

## Hercules - VM configuration

## Hercules - OS Configuration

The following subsections from [General](./general/general.md#general) section should be performed in this order:

- [SSH configuration](./general/general.md#ssh-configuration)
- [Ubuntu - Synchronize time with systemd-timesyncd](./general/general.md#ubuntu---synchronize-time-with-systemd-timesyncd)
- [Update system timezone](./general/general.md#update-system-timezone)
- [Correct DNS resolution](./general/general.md#correct-dns-resolution)
- [Generate Gmail App Password](./general/general.md#generate-gmail-app-password)
- [Configure Postfix Server to send email through Gmail](./general/general.md#configure-postfix-server-to-send-email-through-gmail)
- [Mail notifications for SSH dial-in](./general/general.md#mail-notifications-for-ssh-dial-in)

Add the following mounting points to `/etc/fstab/`

```bash
192.168.0.114:/mnt/tank1/data /home/sitram/data nfs rw 0 0
192.168.0.114:/mnt/tank2/media /home/sitram/media nfs rw 0 0
```

## Hercules - Docker installation and docker-compose

I used for a while the Docker Engine from Ubuntu apt repository, until a container stopped working because it needed the latest version which was not yet available. I decided to switch from Ubuntu's apt version of docker to the official one from [here](https://docs.docker.com/engine/install/ubuntu/#set-up-the-repository) and it has been working great so far.

I launch all containers from a single docker-compose file called `docker-compose.yml` which I store in `/home/sitram/data`. Together with the yaml file, I store a `.env` file which contains the stack name:

```bash
echo COMPOSE_PROJECT_NAME=serenity >> /home/sitram/data/.env
```

The configuration of each container is stored in `/home/sitram/docker` in a folder named after each container. I have a job running on the host server, which periodically creates a backup of this VM to a Raid 1 so I should be protected in case of some failures.

[TODO] move the containers docker configuration to my tank1 in order to reduce the wear on the SSD.

## Hercules - Remove docker packages from Ubuntu repository

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

## Hercules - set up Docker repository

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

## Hercules - Install Docker Engine

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

## Hercules - Watchtower docker container

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

## Hercules - Heimdall docker container

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
    healthcheck:
      test: wget --no-verbose --tries=1 --spider http://192.168.0.101:81 || exit 1
      interval: 30s
      timeout: 10s
      retries: 5
    restart: unless-stopped
```

## Hercules - Portainer docker container

I use [Portainer](https://www.portainer.io/) as a web interface for managing my docker containers. It helps me tocheck container logs, login to a shell inside the container and perform other various debugging activities.

The container has:

- a volume mapped to `/home/sitram/docker/portainer` used to store the configuration of the application
- a volume mapped to `/var/run/docker.sock` used to access Docker via Unix sockets

Below is the docker-compose I used to launch the container.

```yaml
#Portainer - a web interface for managing docker containers
  portainer:
    image: portainer/portainer-ce:alpine
    container_name: portainer
    command: -H unix:///var/run/docker.sock
    restart: always
    ports:
      - 9000:9000
      - 8000:8000
    healthcheck:
      test: wget --no-verbose --tries=1 --spider http://192.168.0.101:9000 || exit 1
      interval: 30s
      timeout: 10s
      retries: 5
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - /home/sitram/docker/portainer:/data
```

## Hercules - Calibre docker container

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
    healthcheck:
      test: wget --no-verbose --tries=1 --spider http://192.168.0.101:8080 || exit 1
      interval: 30s
      timeout: 10s
      retries: 5
      start_period: 30s
    restart: unless-stopped
```

## Hercules - Calibre-web docker container

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
    healthcheck:
      test: curl -f http://192.168.0.101:8086 || exit 1
      interval: 30s
      timeout: 10s
      retries: 5
      start_period: 30s
    restart: unless-stopped
```

## Hercules - qBitTorrent docker container

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
    healthcheck:
      test: curl -f http://192.168.0.101:9093 || exit 1
      interval: 30s
      timeout: 10s
      retries: 5
    restart: unless-stopped
```

## Hercules - Jackett docker container

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
    healthcheck:
      test: curl -f http://192.168.0.101:9117 || exit 1
      interval: 30s
      timeout: 10s
      retries: 5
    restart: unless-stopped
```

## Hercules - Sonarr docker container

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
    healthcheck:
      test: curl -f http://192.168.0.101:8989 || exit 1
      interval: 30s
      timeout: 10s
      retries: 5
      start_period: 30s
    depends_on:
      - jackett
      - qbittorrent
    restart: unless-stopped
```

## Hercules - Radarr docker container

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
    healthcheck:
      test: curl -f http://192.168.0.101:7878 || exit 1
      interval: 30s
      timeout: 10s
      retries: 5
      start_period: 30s
    depends_on:
      - jackett
      - qbittorrent
    restart: unless-stopped
```

## Hercules - Bazarr docker container

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
    healthcheck:
      test: curl -f http://192.168.0.101:6767 || exit 1
      interval: 30s
      timeout: 10s
      retries: 5
      start_period: 30s
    depends_on:
      - radarr
      - sonarr
    restart: unless-stopped
```

## Hercules - Lidarr docker container

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
    healthcheck:
      test: curl -f http://192.168.0.101:8686 || exit 1
      interval: 30s
      timeout: 10s
      retries: 5
      start_period: 30s
    depends_on:
      - jackett 
      - qbittorrent
    restart: unless-stopped
```

## Hercules - Overseerr docker container

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
    healthcheck:
      test: wget --no-verbose --tries=1 --spider http://192.168.0.101:5055 || exit 1
      interval: 30s
      timeout: 10s
      retries: 5
      start_period: 30s
    volumes:
      - /home/sitram/docker/overseerr:/app/config
    restart: unless-stopped
```

## Hercules - DuckDNS docker container

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
    healthcheck:
      test: wget --no-verbose --tries=1 --spider --no-check-certificate https://sitram.duckdns.org || exit 1
      interval: 30s
      timeout: 10s
      retries: 5
      start_period: 30s
    restart: unless-stopped
```

## Hercules - SWAG - Secure Web Application Gateway docker container

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
    healthcheck:
      test: wget --no-verbose --tries=1 --spider --no-check-certificate https://sitram.duckdns.org || exit 1
      interval: 30s
      timeout: 10s
      retries: 5
      start_period: 30s
    depends_on: 
      - duckdns
    restart: unless-stopped
```

## Hercules - Plex docker container

I use [Plex](https://hub.docker.com/r/plexinc/pms-docker/)  to organizes video, music and photos from personal media libraries and streams them to smart TVs, streaming boxes and mobile devices.

The container has:

- a volume mapped to `/home/sitram/docker/plex/` used to store the configuration of the application
- a volume mapped to `/dev/shm` used for transcoding videos. I use this approach to reduce the wear on the host SSD.
- a volume mapped to `/home/sitram/media/tvseries` used to store all TV shows
- a volume mapped to `/home/sitram/media/movies` used to store all the movies
- a volume mapped to `/home/sitram/media/music` used to store all the music
- a volume mapped to `/home/sitram/media/photos` used to store family photos
- a volume mapped to `/home/sitram/media/trainings` used to store various video training materials

Below is the docker-compose I used to launch the container.

```yaml
Plex - Organizes video, music and photos from personal media libraries and streams them to smart TVs, streaming boxes and mobile devices. - https://hub.docker.com/r/plexinc/pms-docker/
  plex:
    image: plexinc/pms-docker:latest
    container_name: plex
    network_mode: host
    environment:
      - TZ=Europe/Bucharest
      - PUID=1000
      - PGID=1000
      - HOSTNAME=Serenity
    volumes:
      - /home/sitram/docker/plex/:/config
      #- /home/sitram/docker/plex/tmp:/transcode
      - /dev/shm:/transcode
      - /home/sitram/media/tvseries:/tvseries
      - /home/sitram/media/movies:/movies
      - /home/sitram/media/music:/music
      - /home/sitram/data/photos:/photos
      - /home/sitram/media/trainings:/trainings
#    ports:
#      - "32400:32400/tcp"
#      - "3005:3005/tcp"
#      - "8324:8324/tcp"
#      - "32469:32469/tcp"
#      - "1900:1900/udp"
#      - "32410:32410/udp"
#      - "32412:32412/udp"
#      - "32413:32413/udp"
#      - "32414:32414/udp"
    depends_on: 
      - swag
    restart: unless-stopped
```

## Hercules - PostgressSQL database docker container

I use [PostgressSQL database](https://github.com/docker-library/docs/blob/master/postgres/README.md) as a database server for [Guacamole](#hercules---guacamole-daemon-and-web-application-docker-container) container

The container has:

- a volume mapped to `/home/sitram/docker/postgres` used to store the configuration of the application and databases

Below is the docker-compose I used to launch the container.

```yaml
#PostgressSQL database - https://github.com/docker-library/docs/blob/master/postgres/README.md
  db_postgress:
    container_name: db_postgress
    image: postgres:13
    user: 1000:1000
    environment:
      - POSTGRES_USER=xxx
      - POSTGRES_PASSWORD=xxx
    ports:
      - 5432:5432
    healthcheck:
      test: pg_isready -h 192.168.0.101 -p 5432 -U sitram || exit 1
      interval: 30s
      timeout: 10s
      retries: 5
      start_period: 30s
    volumes:
      - /home/sitram/docker/postgres:/var/lib/postgresql/data:rw
    restart: unless-stopped
```

## Hercules - MySQL database docker container

I use [MySQL](https://hub.docker.com/_/mysql?tab=description) as a open-source relational database management system to store databases for

- [Authelia](#hercules---authelia-docker-container)
- [Librespeed](#hercules---librespeed-docker-container)
- [NextCloud](#nextcloud---content-collaboration-server)
- [WordPress blogs](#wordpress---worpress-server-vm)

The container has:

- a volume mapped to `/home/sitram/docker/mysql/data` used to store the databases
- a volume mapped to `/home/sitram/docker/mysql/conf` used to store custom configurations
- a volume mapped to `/home/sitram/docker/mysql/logs` used to access MySQL logs
- a volume mapped to `/home/sitram/docker/mysql/run` used to access the pid and sock files.

Below is the docker-compose I used to launch the container.

```yaml
#MySQL database - https://hub.docker.com/_/mysql?tab=description
  mysql:
    container_name: mysql
    image: mysql
    user: 1000:1000
    command: 
      --default-authentication-plugin=mysql_native_password
    cap_add:
      - SYS_NICE
    environment:
      - MYSQL_ROOT_PASSWORD=xxx
      - MYSQL_DATABASE=xxx
      - MYSQL_USER=xxx
      - MYSQL_PASSWORD=xxx
    ports:
      - 3306:3306
    healthcheck:
      test: mysqladmin ping -h 192.168.0.101 || exit 1
      interval: 30s
      timeout: 10s
      retries: 5
      start_period: 30s
    volumes:
      - /home/sitram/docker/mysql/data:/var/lib/mysql
      - /home/sitram/docker/mysql/conf:/etc/mysql/conf.d
      - /home/sitram/docker/mysql/logs:/var/log/mysql
      - /home/sitram/docker/mysql/run:/var/run/mysqld
    restart: unless-stopped
```

## Hercules - Adminer docker container

I use [Adminer](https://hub.docker.com/_/adminer) (formerly phpMinAdmin) as a full-featured database management tool written in PHP to connect to [MySQL](#hercules---mysql-database-docker-container) container

Below is the docker-compose I used to launch the container.

```yaml
#Adminer - (formerly phpMinAdmin) is a full-featured database management tool written in PHP - https://hub.docker.com/_/adminer
  adminer:
    container_name: adminer
    image: adminer
    environment:
      - ADMINER_DESIGN=nette
      - ADMINER_DEFAULT_SERVER=192.168.0.101
    ports:
      - 8082:8080
    restart: unless-stopped
```

## Hercules - PGAdmin docker container

I use [PGAdmin](https://hub.docker.com/_/adminer) as a web interface to administer [PostgressSQL](#hercules---postgresssql-database-docker-container) databasees

The container has:

- a volume mapped to `/home/sitram/docker/pgadmin` used to store the configuration of the application

Below is the docker-compose I used to launch the container.

```yaml
#PGAdmin - Web interface used to administer PostgressSQL - https://www.pgadmin.org/docs/pgadmin4/latest/container_deployment.html#environment-variables
  pg_admin:
    image: dpage/pgadmin4
    container_name: pg_admin
    ports:
      - 82:80
    environment:
      - PGADMIN_DEFAULT_EMAIL=xxx@gmail.com
      - PGADMIN_DEFAULT_PASSWORD=xxx
      - PGADMIN_CONFIG_ENHANCED_COOKIE_PROTECTION=True
      - PGADMIN_CONFIG_LOGIN_BANNER="Authorised users only!"
      - PGADMIN_CONFIG_CONSOLE_LOG_LEVEL=10
    volumes:
      - /home/sitram/docker/pgadmin:/var/lib/pgadmin
    healthcheck:
      test: wget --no-verbose --tries=1 --spider http://192.168.0.101:82 || exit 1
      interval: 30s
      timeout: 10s
      retries: 5
      start_period: 30s
    restart: unless-stopped
```

## Hercules - Guacamole daemon and web application docker container

I use [Guacamole](http://guacamole.apache.org/doc/gug/guacamole-docker.html) as a web application for accesing internal services over SSH, RDP or other protocols. It consists of two containers, a daemon and the web interface.

Below is the docker-compose I used to launch the the Guacamole Daemon container.

The container has:

```yaml
#Guacamole Daemon - http://guacamole.apache.org/doc/gug/guacamole-docker.html
  guacd: 
    container_name: guacd
    image: guacamole/guacd
    environment:
      - TZ=Europe/Bucharest
      - GUACD_LOG_LEVEL=debug
    ports:
      - 4822:4822
    networks:
      - guacamole
    restart: unless-stopped
```

Below is the docker-compose I used to launch the Guacamole web application container.

- a volume mapped to `/home/sitram/docker/swag` used to store the configuration of the application

Below is the docker-compose I used to launch the container.

```yaml
#Guacamole - web application for accesing internal services over SSH, RDP or other protocols - http://guacamole.apache.org/doc/gug/guacamole-docker.html
# 2022.7-08 - Latest docker image would not boot. I temporarily switched to version 1.4.0
  guacamole:
    container_name: guacamole
    image: guacamole/guacamole:1.4.0
    links:
      - guacd
    environment:
      - TZ=Europe/Bucharest
      - GUACD_HOSTNAME=192.168.0.101
      - GUACD_PORT=4822
      - POSTGRES_HOSTNAME=192.168.0.101
      - POSTGRES_PORT=5432
      - POSTGRES_DATABASE=guacamole_db
      - POSTGRES_USER=xxx
      - POSTGRES_PASSWORD=xxx
      - GUACAMOLE_HOME=/custom-config
    volumes:
      - /home/sitram/docker/guacamole:/custom-config
    networks:
      - guacamole
    ports:
      - 8083:8080
    healthcheck:
      test: wget --no-verbose --tries=1 --spider http://192.168.0.101:8083/guacamole/ || exit 1
      interval: 30s
      timeout: 10s
      retries: 5
      start_period: 30s
    depends_on: 
      - swag
      - guacd
      - db_postgress
    restart: unless-stopped
```

## Hercules - Redis docker container

I use [Redis](https://hub.docker.com/_/redis) as an open-source, networked, in-memory, key-value data store with optional durability. It is written in ANSI C

The container has:

- a volume mapped to `/home/sitram/docker/redis` used to store the database
 a volume mapped to `/home/sitram/docker/redis/config` used to store custom configuration

Below is the docker-compose I used to launch the container.

```yaml
#Redis is an open-source, networked, in-memory, key-value data store with optional durability. It is written in ANSI C.- https://hub.docker.com/_/redis
  redis:
    container_name: redis
    image: redis
    user: 1000:1000
    environment:
      - TZ=Europe/Bucharest
    command: redis-server /usr/local/etc/redis/redis.conf
    ports:
       - 6379:6379
    healthcheck:
      test: redis-cli -h 192.168.0.101 -p 6379 ping | grep PONG
      interval: 30s
      timeout: 10s
      retries: 5
    volumes:
       - /home/sitram/docker/redis:/data
       - /home/sitram/docker/redis/config:/usr/local/etc/redis
    restart: unless-stopped
```

## Hercules - LibreSpeed docker container

I use [LibreSpeed](https://hub.docker.com/r/linuxserver/librespeed) as a very lightweight Speedtest implemented in Javascript, using XMLHttpRequest and Web Workers. No Flash, No Java, No Websocket, No Bullshit.

The container has:

- a volume mapped to `/home/sitram/docker/librespeed` used to store the configuration of the application

Below is the docker-compose I used to launch the container.

```yaml
#LibreSpeed - very lightweight Speedtest implemented in Javascript, using XMLHttpRequest and Web Workers. No Flash, No Java, No Websocket, No Bullshit. - https://hub.docker.com/r/linuxserver/librespeed
  librespeed:
    image: ghcr.io/linuxserver/librespeed:latest
    container_name: librespeed
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Bucharest
      - PASSWORD=xxx
      - CUSTOM_RESULTS=true
      - DB_TYPE=mysql
      - DB_NAME=librespeed
      - DB_HOSTNAME=192.168.0.101
      - DB_USERNAME=xxx
      - DB_PASSWORD=xxx
      - DB_PORT=3306
    volumes:
      - /home/sitram/docker/librespeed:/config
    ports:
      - 85:80
    healthcheck:
      test: wget --no-verbose --tries=1 --spider http://192.168.0.101:85 || exit 1
      interval: 30s
      timeout: 10s
      retries: 5
      start_period: 30s
    depends_on: 
      - mysql
    restart: unless-stopped
```

## Hercules - Authelia docker container

I use [Authelia](https://www.authelia.com/docs/) as an open source authentication and authorization server protecting modern web applications by collaborating with reverse proxies.

The container has:

- a volume mapped to `/home/sitram/docker/authelia` used to store the configuration of the application

Below is the docker-compose I used to launch the container.

```yaml
#Authelia - an open source authentication and authorization server protecting modern web applications by collaborating with reverse proxies - https://www.authelia.com/docs/
  authelia:
    image: authelia/authelia:latest
    container_name: authelia
    user: 1000:1000
    environment:
      - TZ=Europe/Bucharest
    volumes:
      - /home/sitram/docker/authelia:/config
    ports:
      - 9092:9092
    depends_on: 
      - redis
    restart: unless-stopped
```

## Hercules - PortfolioPerformance docker container

I use [Portfolio Performance](https://www.portfolio-performance.info/en/) as an open source tool to calculate the overall performance of an investment portfolio. I built the image based on the instructions from [here](https://forum.portfolio-performance.info/t/portfolio-performance-in-docker/10062).

The container has:

- a volume mapped to `/home/sitram/docker/portfolio-performance/workspace` used to store the application workspace.

Below is the docker-compose I used to launch the container.

```yaml
#Portfolio Performance - An open source tool to calculate the overall performance of an investment portfolio.
#Self build image based on instructions from https://forum.portfolio-performance.info/t/portfolio-performance-in-docker/10062
  PortfolioPerformance:
    image: portfolio:latest
    container_name: PortfolioPerformance
    environment:
      - TZ=Europe/Bucharest
      - USER_ID=1000
      - GROUP_ID=1000
      - KEEP_APP_RUNNING=1
      - DISPLAY_WIDTH=1920
      - DISPLAY_HEIGHT=910
    labels:
      - "com.centurylinklabs.watchtower.enable=false"
    volumes:
      - /home/sitram/docker/portfolio-performance/workspace:/opt/portfolio/workspace
    ports:
      - 5800:5800
    healthcheck:
      test: wget --no-verbose --tries=1 --spider http://192.168.0.101:5800 || exit 1
      interval: 30s
      timeout: 10s
      retries: 5
      start_period: 30s
    restart: unless-stopped
```

## Audiobookshelf - Audiobookshelf docker container

I use [Audiobookshelf](https://www.audiobookshelf.org/) as an self hosted audiobook and podcast server with mobile applications for Android and iOS which allows to listen to audiobooks remotely from the server.

The container has:

- a volume mapped to `/home/sitram/media/audiobooks` used to store all the audiobooks
- a volume mapped to `/home/sitram/media/podcasts` used to store all the podcasts
- a volume mapped to `/home/sitram/docker/audiobookshelf/config` used to store the configuration of the application
- a volume mapped to `/home/sitram/docker/audiobookshelf/metadata` used to store cache, streams, covers, downloads, backups and logs

Below is the docker-compose I used to launch the container.

```yaml
#Audiobookshelf - is an self hosted audiobook and podcast server - https://www.audiobookshelf.org/
  audiobookshelf:
    image: ghcr.io/advplyr/audiobookshelf:latest
    container_name: audiobookshelf
    environment:
      - TZ=Europe/Bucharest
      - AUDIOBOOKSHELF_UID=1000
      - AUDIOBOOKSHELF_GID=1000
    volumes:
      - /home/sitram/media/audiobooks:/audiobooks
      - /home/sitram/media/podcasts:/podcasts
      - /home/sitram/docker/audiobookshelf/config:/config
      - /home/sitram/docker/audiobookshelf/metadata:/metadata
    ports:
      - 13378:80
    healthcheck:
      test: wget --no-verbose --tries=1 --spider http://192.168.0.101:13378 || exit 1
      interval: 30s
      timeout: 10s
      retries: 5
      start_period: 30s
    restart: unless-stopped
```

# Windows11 - Virtual Windows Desktop VM

## Windows11 - VM configuration

## Windows11 - Windows installation

## Windows11 - Remote Desktop Connection configuration

# Code - coding VM

## Code - VM configuration

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

## Code - OS Configuration

The following subsections from [General](./general/general.md#general) section should be performed in this order:

- [SSH configuration](./general/general.md#ssh-configuration)
- [Ubuntu - Synchronize time with ntpd](./general/general.md#ubuntu---synchronize-time-with-ntpd)
- [Update system timezone](./general/general.md#update-system-timezone)
- [Correct DNS resolution](./general/general.md#correct-dns-resolution)
- [Generate Gmail App Password](./general/general.md#generate-gmail-app-password)
- [Configure Postfix Server to send email through Gmail](./general/general.md#configure-postfix-server-to-send-email-through-gmail)
- [Mail notifications for SSH dial-in](./general/general.md#mail-notifications-for-ssh-dial-in)

## Code - CodeServer installation and configuration

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

## Code - Accessing CodeServer from outside local network

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
- **DOS filesystem utilities**: dosfstools
- **NTFS filesystem driver and utilities**: ntfs-3g

```bash
sudo pacman -S grub os-prober network-manager base-devel linux-headers nfs-utils bash-completition xdg-user-dirs xdg-utils openssh reflector rsync acpi acpi_call pacman-contrib tree flatpak iftop docker htop neofetch dosfstools ntfs-3g
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
- **Docker**

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

# ArchLinux - Downgrade packages

When using a rolling distro like Arch, sometimes things break when updating packages to newer version. When this happens there are several ways to perform a downgrade

## Using pacman cache

If a package was installed at an earlier stage, and the pacman cache was not cleaned, an earlier version from `/var/cache/pacman/pkg/` can be installed.

This process will remove the current package and install the older version. Dependency changes will be handled, but pacman will not handle version conflicts. If a library or other package needs to be downgraded with the packages, please be aware that you will have to downgrade this package yourself as well.

```bash
pacman -U /var/cache/pacman/pkg/package-old_version.pkg.tar.zst
```

`old_version` could be something like `x.y.z-x86_64` where the last part is the architecture for which the package is installed.

## Using Arch Linux archive

The [Arch Linux Archive](https://wiki.archlinux.org/title/Arch_Linux_Archive) is a daily snapshot of the official repositories. It can be used to install a previous package version, or restore the system to an earlier date.

```bash
pacman -U https://archive.archlinux.org/packages/path/package-old_version.pkg.tar.zst
```

## Restore system to an earlier date

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

# ArchLinux - Connect Android To Arch Linux Via USB

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

# WordPress - WorPress server VM

## WordPress - VM configuration

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

## WordPress - OS Configuration

The following subsections from [General](./general/general.md#general) section should be performed in this order:

- [SSH configuration](./general/general.md#ssh-configuration)
- [Ubuntu - Synchronize time with ntpd](./general/general.md#ubuntu---synchronize-time-with-ntpd)
- [Update system timezone](./general/general.md#update-system-timezone)
- [Correct DNS resolution](./general/general.md#correct-dns-resolution)
- [Generate Gmail App Password](./general/general.md#generate-gmail-app-password)
- [Configure Postfix Server to send email through Gmail](./general/general.md#configure-postfix-server-to-send-email-through-gmail)
- [Mail notifications for SSH dial-in](./general/general.md#mail-notifications-for-ssh-dial-in)

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

## WordPress - Installation and configuration of nginx web server

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

## WordPress - Installation and configuration of PHP 8.0

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

## Wordpress - Installation and configuration of MariaDB database

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

## Wordpress - Database creation

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

## Wordpress - Installation and optimization

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

## Wordpress - Installation of Redis server

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
