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
    - [Nextcloud - Optimize and update using a script](#nextcloud---optimize-and-update-using-a-script)
    - [Nextcloud - Bash aliases for executing Nextcloud Toolset occ](#nextcloud---bash-aliases-for-executing-nextcloud-toolset-occ)
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
```

Ensure that no relics from previous installations disrupt the operation of the webserver
```
sudo apt remove nginx nginx-extras nginx-common nginx-full -y --allow-change-held-packages
sudo apt autoremove
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

Create web directories used by Nextcloud
```
sudo mkdir -p /var/nc_data
```

[OPTIONAL] Create the web directories used by the SSL certificates
```
sudo mkdir -p /var/www/letsencrypt/.well-known/acme-challenge 
sudo mkdir -p /etc/letsencrypt/rsa-certs
sudo mkdir -p /etc/letsencrypt/ecc-certs
```

[OPTIONAL] Update the self signed SSL certificate
```
make-ssl-cert generate-default-snakeoil -y
```

Assign the right permissions
```
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

Install PHP8.0 and required modules
```
sudo apt install -y php8.0-{fpm,gd,mysql,curl,xml,zip,intl,mbstring,bz2,ldap,apcu,bcmath,gmp,imagick,igbinary,redis,smbclient,cli,common,opcache,readline} imagemagick ldap-utils nfs-common cifs-utils
```

Backup original configurations
```
sudo cp /etc/php/8.0/fpm/pool.d/www.conf /etc/php/8.0/fpm/pool.d/www.conf.bak
sudo cp /etc/php/8.0/fpm/php-fpm.conf /etc/php/8.0/fpm/php-fpm.conf.bak
sudo cp /etc/php/8.0/cli/php.ini /etc/php/8.0/cli/php.ini.bak
sudo cp /etc/php/8.0/fpm/php.ini /etc/php/8.0/fpm/php.ini.bak
sudo cp /etc/php/8.0/fpm/php-fpm.conf /etc/php/8.0/fpm/php-fpm.conf.bak
sudo cp /etc/php/8.0/mods-available/apcu.ini /etc/php/8.0/mods-available/apcu.ini.bak
sudo cp /etc/ImageMagick-6/policy.xml /etc/ImageMagick-6/policy.xml.bak
```

In order to adapt PHP to the configuration of the system, some parameters are calculated, using the lines below.
```
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
```
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

```
sudo sed -i "s/output_buffering =.*/output_buffering = 'Off'/" /etc/php/8.0/cli/php.ini
sudo sed -i "s/max_execution_time =.*/max_execution_time = 3600/" /etc/php/8.0/cli/php.ini
sudo sed -i "s/max_input_time =.*/max_input_time = 3600/" /etc/php/8.0/cli/php.ini
sudo sed -i "s/post_max_size =.*/post_max_size = 10240M/" /etc/php/8.0/cli/php.ini
sudo sed -i "s/upload_max_filesize =.*/upload_max_filesize = 10240M/" /etc/php/8.0/cli/php.ini
sudo sed -i "s/;date.timezone.*/date.timezone = Europe\/\Bucharest/" /etc/php/8.0/cli/php.ini
```

```
sudo sed -i "s/memory_limit = 128M/memory_limit = 1024M/" /etc/php/8.0/fpm/php.ini
sudo sed -i "s/output_buffering =.*/output_buffering = 'Off'/" /etc/php/8.0/fpm/php.ini
sudo sed -i "s/max_execution_time =.*/max_execution_time = 3600/" /etc/php/8.0/fpm/php.ini
sudo sed -i "s/max_input_time =.*/max_input_time = 3600/" /etc/php/8.0/fpm/php.ini
sudo sed -i "s/post_max_size =.*/post_max_size = 10240M/" /etc/php/8.0/fpm/php.ini
sudo sed -i "s/upload_max_filesize =.*/upload_max_filesize = 10240M/" /etc/php/8.0/fpm/php.ini
sudo sed -i "s/;date.timezone.*/date.timezone = Europe\/\Berlin/" /etc/php/8.0/fpm/php.ini
sudo sed -i "s/;session.cookie_secure.*/session.cookie_secure = True/" /etc/php/8.0/fpm/php.ini
sudo sed -i "s/;opcache.enable=.*/opcache.enable=1/" /etc/php/8.0/fpm/php.ini
sudo sed -i "s/;opcache.enable_cli=.*/opcache.enable_cli=1/" /etc/php/8.0/fpm/php.ini
sudo sed -i "s/;opcache.memory_consumption=.*/opcache.memory_consumption=128/" /etc/php/8.0/fpm/php.ini
sudo sed -i "s/;opcache.interned_strings_buffer=.*/opcache.interned_strings_buffer=8/" /etc/php/8.0/fpm/php.ini
sudo sed -i "s/;opcache.max_accelerated_files=.*/opcache.max_accelerated_files=10000/" /etc/php/8.0/fpm/php.ini
sudo sed -i "s/;opcache.revalidate_freq=.*/opcache.revalidate_freq=1/" /etc/php/8.0/fpm/php.ini
sudo sed -i "s/;opcache.save_comments=.*/opcache.save_comments=1/" /etc/php/8.0/fpm/php.ini
```

```
sudo sed -i "s|;emergency_restart_threshold.*|emergency_restart_threshold = 10|g" /etc/php/8.0/fpm/php-fpm.conf
sudo sed -i "s|;emergency_restart_interval.*|emergency_restart_interval = 1m|g" /etc/php/8.0/fpm/php-fpm.conf
sudo sed -i "s|;process_control_timeout.*|process_control_timeout = 10|g" /etc/php/8.0/fpm/php-fpm.conf
```

```
sudo sed -i '$aapc.enable_cli=1' /etc/php/8.0/mods-available/apcu.ini
```

```
sudo sed -i "s/rights=\"none\" pattern=\"PS\"/rights=\"read|write\" pattern=\"PS\"/" /etc/ImageMagick-6/policy.xml
sudo sed -i "s/rights=\"none\" pattern=\"EPS\"/rights=\"read|write\" pattern=\"EPS\"/" /etc/ImageMagick-6/policy.xml
sudo sed -i "s/rights=\"none\" pattern=\"PDF\"/rights=\"read|write\" pattern=\"PDF\"/" /etc/ImageMagick-6/policy.xml
sudo sed -i "s/rights=\"none\" pattern=\"XPS\"/rights=\"read|write\" pattern=\"XPS\"/" /etc/ImageMagick-6/policy.xml
```

Restart PHP and nginx and check that they are working correctly
```
sudo service php8.0-fpm restart
sudo service nginx restart

sudo service php8.0-fpm status
sudo service nginx status
```

[TODO] For troubleshooting of php-fpm check [here](https://www.c-rieger.de/nextcloud-und-php-troubleshooting/)
### Nextcloud - Installation and configuration of MariaDB database
[OPTIONAL] This step is optional and can be skipped if using MySQL or MariaDB in a docker instance on a dedicated server.

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

Install MariaDB
```
sudo apt install -y mariadb-server
```

Harden the database server using the supplied tool "mysql_secure_installation". When installing for the first time, there is no root password, so you can confirm the query with ENTER. It is recommended to set a password directly, the corresponding dialog appears automatically.

```
mysql_secure_installation
```
```
Enter current password for root (enter for none): <ENTER> or type the password
```
```
Switch to unix_socket authentication [Y/n] Y
```
```
Set root password? [Y/n] Y
```
```
Remove anonymous users? [Y/n] Y
Disallow root login remotely? [Y/n] Y
Remove test database and access to it? [Y/n] Y
Reload privilege tables now? [Y/n] Y
```

Stop the database server and then save the standard configuration
```
sudo service mysql stop
sudo mv /etc/mysql/my.cnf /etc/mysql/my.cnf.bak
sudo nano /etc/mysql/my.cnf
```

Copy the following configuration
```
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
```
service mysql restart
```

Create Nextcloud database, user and password.
```
mysql -u root -p -h 192.168.0.101 -P 3306
CREATE DATABASE nextclouddb CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
CREATE USER nextclouddbuser@localhost identified by 'nextclouddbpassword';
GRANT ALL PRIVILEGES on nextclouddb.* to nextclouddbuser;
FLUSH privileges;
quit;
```

Check whether the isolation level (read commit) and the charset (utf8mb4) have been set correctly
```
mysql -h localhost -uroot -p -e "SELECT @@TX_ISOLATION; SELECT SCHEMA_NAME 'database', default_character_set_name 'charset', DEFAULT_COLLATION_NAME 'collation' FROM information_schema.SCHEMATA WHERE SCHEMA_NAME='nextclouddb'"
```

For MySQL use the following command:
```
mysql -h localhost -uroot -p -e "SELECT @@global.transaction_isolation; SELECT SCHEMA_NAME 'database', default_character_set_name 'charset', DEFAULT_COLLATION_NAME 'collation' FROM information_schema.SCHEMATA WHERE SCHEMA_NAME='nextcloud'"
```

If “READ-COMMITTED” and “utf8mb4_general_c i” appear in the output (resultset) everything has been set up correctly.

### Nextcloud - Installation of Redis server
Use Redis to increase the Nextcloud performance, as Redis reduces the load on the database.

This step is optional and can be skipped if using Redis runs in a docker instance on a separate server server

If the step is skipped then make sure the redis-tools are installed and connection with server wroks. Replace the host in the second command if needed.

```
sudo apt install -y redis-tools
redis-cli -h 192.168.0.101 -p 6379 ping
```
The reply to last command should be PONG.

In case Redis will be installed locally, execute command below.

```
sudo apt install -y redis-server
```

Adjust the redisk configuration by saving and adapting the configuration using the following commands
```
sudo cp /etc/redis/redis.conf /etc/redis/redis.conf.bak
sudo sed -i "s / port 6379 / port 0 /" /etc/redis/redis.conf
sudo sed -is / \ # \ unixsocket / \ unixsocket / g /etc/redis/redis.conf
sudo sed -i "s / unixsocketperm 700 / unixsocketperm 770 /" /etc/redis/redis.conf
sudo sed -i "s / # maxclients 10000 / maxclients 512 /" /etc/redis/redis.conf
sudo usermod -aG redis www-data
```

Background save may file under low memory conditions. To fix this issue 'm.overcommit_memory' has to be set to 1.
```
sudo cp /etc/sysctl.conf /etc/sysctl.conf.bak
sudo sed -i '$ avm.overcommit_memory = 1' /etc/sysctl.conf
sudo reboot now
```

### Nextcloud - Installation and optimization of Nextcloud
We will now set up various vhost, i.e. server configuration files, and modify the standard vhost file persistently.

If exists, backup existing configuration. Create empty vhosts files. The empty "default.conf" file ensures that the standard configuration does not affect Nextcloud operation even when the web server is updated later.
```
[ -f /etc/nginx/conf.d/default.conf ] && sudo mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.bak
```
```
sudo touch /etc/nginx/conf.d/default.conf
sudo touch /etc/nginx/conf.d/http.conf
sudo touch /etc/nginx/conf.d/nextcloud.conf
```

Create the global vhost file to permanently redirect the http standard requests to https and optionally to enable SSL certificate communication with Let'sEncrypt.

```
sudo nano /etc/nginx/conf.d/http.conf
```

```
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

```
sudo nano /etc/nginx/conf.d/nextcloud.conf
```
```
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
```
sudo openssl dhparam -dsaparam -out /etc/ssl/certs/dhparam.pem 4096
```

Restart webserver
```
sudo service nginx restart
sudo service nginx status
```
Download the current Nextcloud release and the the files.
```
cd /usr/local/src
sudo wget https://download.nextcloud.com/server/releases/latest.tar.bz2
sudo wget https://download.nextcloud.com/server/releases/latest.tar.bz2.md5
md5sum -c latest.tar.bz2.md5 < latest.tar.bz2
```

The test should result in 'OK'

Unzip Nextcloud software into the web directy(/var/www) then set the right permissions.
```
sudo tar -xjf latest.tar.bz2 -C /var/www
sudo chown -R www-data:www-data /var/www/
sudo rm -f latest.tar.bz2
sudo rm -f latest.tar.bz2.md5
```

[OPTIONAL] Creationg an update of Let's Encrypt certificates is mandatory via http and port 80 so make sure the server can be reached from outside. 

Create a dedicate user for certificate handling and add this user to www-data group
```
adduser --disabled-login acmeuser
usermod -a -G www-data acmeuser
```

Give this user the nessecary permission to start the web server when a certificate is renewed.
```
visudo
```
In the middle of the file, below
```
[..]
User privilege specification
root ALL=(ALL:ALL) ALL
[..]
```
add the following line
```
acmeuser ALL=NOPASSWD: /bin/systemctl reload nginx.service
```
After saving and exit, switch to the shell of the new user and install the certificate software.
```
su - acmeuser
curl https://get.acme.sh | sh
exit
```

Adjust the appropriate permissions to be able to save the new certificates in it.
```
sudo chmod -R 775 /var/www/letsencrypt
sudo chmod -R 770 /etc/letsencrypt
sudo chown -R www-data:www-data /var/www/ /etc/letsencrypt
```

Set Let's Encrypt as the default CA for your server
```
su - acmeuser -c ".acme.sh/acme.sh --set-default-ca --server letsencrypt
```
and then switch to the new user's shell again
```
su - acmeuser
```

Request the SSL certificates from Let's Encrypt and replace domain if needed
```
acme.sh --issue -d nextcloud.sitram.duckdns.org --server letsencrypt --keylength 4096 -w /var/www/letsencrypt --key-file /etc/letsencrypt/rsa-certs/privkey.pem --ca-file /etc/letsencrypt/rsa-certs/chain.pem --cert-file /etc/letsencrypt/rsa-certs/cert.pem --fullchain-file /etc/letsencrypt/rsa-certs/fullchain.pem --reloadcmd "sudo /bin/systemctl reload nginx.service"
```
```
acme.sh --issue -d nextcloud.sitram.duckdns.org --server letsencrypt --keylength ec-384 -w /var/www/letsencrypt --key-file /etc/letsencrypt/ecc-certs/privkey.pem --ca-file /etc/letsencrypt/ecc-certs/chain.pem --cert-file /etc/letsencrypt/ecc-certs/cert.pem --fullchain-file /etc/letsencrypt/ecc-certs/fullchain.pem --reloadcmd "sudo /bin/systemctl reload nginx.service"
```
exit new user's shell
```
exit
```

Create the file permissions.sh with the following contents
```
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
```
chmod + x /home/sitram/permissions.sh
/home/sitram/permissions.sh
```

Remove your previously used self-signed certificates from nginx and activate the new, full-fledged and already valid SSL certificates from Let's Encrypt. Then restart the web server.
```
sed -i '/ssl-cert-snakeoil/d' /etc/nginx/conf.d/nextcloud.conf
sed -i s/#\ssl/\ssl/g /etc/nginx/conf.d/nextcloud.conf
service nginx restart
```

In order to automatically renew the SSL certificates as well as to initiate the necessary web server restart, a cron job was automatically created.
```
crontab -l -u acmeuser
```

Set up the Nextcloud using the following "silent" installation command with database locally.
```
sudo -u www-data php /var/www/nextcloud/occ maintenance:install --database "mysql" --database-name "nextcloud_test" --database-user "root" --database-pass "rootpw" --admin-user "sitram" --admin-pass "YourNextcloudAdminPasssword" --data-dir "/var/nc_data"
```

Set up the Nextcloud using the following "silent" installation command with the database on a remote docker instance
```
sudo -u www-data php /var/www/nextcloud/occ maintenance:install --database "mysql" --database-host=192.168.0.101:3306 --database-name "nextclouddb" --database-user "sitram" --database-pass "sitram" --admin-user "sitram" --admin-pass "YourNextcloudAdminPasssword" --data-dir "/var/nc_data"
```

Wait until the installation of the Nextcloud has been completed and then adjust the central configuration file of the Nextcloud "config.php" as web user www-data.

Add your domain as a trusted domain
```
sudo -u www-data php /var/www/nextcloud/occ config:system:set trusted_domains 0 --value=nextcloud.sitram.duckdns.org
```
Set your domain as overwrite.cli.url
```
sudo -u www-data php /var/www/nextcloud/occ config:system:set overwrite.cli.url --value=https://nextcloud.sitram.duckdns.org
```

Save the existing config.php and then execute the following lines in a block
```
sudo -u www-data cp /var/www/nextcloud/config/config.php /var/www/nextcloud/config/config.php.bak 
sudo -u www-data sed -i 's/^[ ]*//' /var/www/nextcloud/config/config.php
sudo -u www-data sed -i '/);/d' /var/www/nextcloud/config/config.php
```

Edit config.php and add the following block of text at the end of the file
```
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
```
sudo -u www-data sed -i "s/output_buffering=.*/output_buffering=0/" /var/www/nextcloud/.user.ini
```

Adapt the Nextcloud apps as user www-data
```
sudo -u www-data php /var/www/nextcloud/occ app:disable survey_client
sudo -u www-data php /var/www/nextcloud/occ app:disable firstrunwizard
sudo -u www-data php /var/www/nextcloud/occ app:enable admin_audit
sudo -u www-data php /var/www/nextcloud/occ app:enable files_pdfviewer
```

Nextcloud is now fully operational, optimized and secured. Restart all relevant services. 'redis-server' and 'mysql' can be skipped if they are running on other servers.
```
service nginx stop
service php8.0-fpm stop
service mysql restart
service php8.0-fpm restart
service redis-server restart
service nginx restart
```

Set up a cron job for Nextcloud as a "www-data" user
```
crontab -u www-data -e
```
Insert this line at the end of the file
```
*/5 * * * * php -f /var/www/nextcloud/cron.php > /dev/null 2>&1
```
Save and close the file and reconfigure the Nextcloud job from "Ajax" to "Cron" using the Nextclouds CLI
```
sudo -u www-data php /var/www/nextcloud/occ background:cron
```
### Nextcloud - Optimize and update using a script
Create a script to update and optimize the server, Nextcloud and the activated apps

```
nano update.sh
```
```
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
```
chmod +x update.sh
```

Execute it periodically.

### Nextcloud - Bash aliases for executing Nextcloud Toolset occ
Adjust file /home/sitram/.bash_aliases in order to be able to start the Nextcloud Toolset occ directly with nocc
```
if [ ! -f /home/sitram/.bash_aliases ]; then touch /home/sitram/.bash_aliases; fi
```

```
cat <<EOF >> /home/sitram/.bash_aliases
alias nocc="sudo -u www-data php /var/www/nextcloud/occ"
EOF
```

Log out of the current session and then log back in again. Now you can run Nextcloud Toolset occ directly via "nocc ... ".
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