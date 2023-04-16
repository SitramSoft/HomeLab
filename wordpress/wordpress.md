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
