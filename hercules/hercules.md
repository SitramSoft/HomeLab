# Hercules - HomeLab services VM

## Hercules - VM configuration

## Hercules - OS Configuration

The following subsections from [General](../general/general.md#general) section should be performed in this order:

- [SSH configuration](../general/general.md#ssh-configuration)
- [Ubuntu - Synchronize time with chrony](../general/general.md#ubuntu---synchronize-time-with-chrony)
- [Update system timezone](../general/general.md#update-system-timezone)
- [Correct DNS resolution](../general/general.md#correct-dns-resolution)
- [Generate Gmail App Password](../general/general.md#generate-gmail-app-password)
- [Configure Postfix Server to send email through Gmail](../general/general.md#configure-postfix-server-to-send-email-through-gmail)
- [Mail notifications for SSH dial-in](../general/general.md#mail-notifications-for-ssh-dial-in)

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

## Hercules - GoDaddy DNS Updater

I use [GoDaddy DNS Updater](https://github.com/parker-hemphill/godaddy-dns-updater) as a free and open source application that uses curl, and a simple shell script to monitor a sub-domain or domain and update GoDaddy DNS records.

The container has:

- a volume mapped to `/home/sitram/docker/godaddy_dns_updater` used to store the logs of the application

Below is the docker-compose I used to launch the container.

```yaml
#GoDaddy DNS Updater - A simple docker image that uses curl, and a simple shell script to monitor a sub-domain or domain and update GoDaddy DNS records - https://github.com/parker-hemphill/godaddy-dns-updater
  godaddy_dns_updater:
    image: parkerhemphill/godaddy-dns-updater
    container_name: godaddy_dns_updater
    environment:
      - DOMAIN=sitram.eu
      - API_KEY=xxx #to be filled with GoDaddy developer API key
      - API_SECRET=xxx #to be filled with GoDaddy developer API key secret
      - DNS_CHECK=600
      - TIME_ZONE=Europe/Bucharest
    volumes:
      - /home/sitram/docker/godaddy_dns_updater:/tmp
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
      - VALIDATION=dns
      - DNSPLUGIN=godaddy
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
      test: wget --no-verbose --tries=1 --spider --no-check-certificate https://sitram.eu || exit 1
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
- a volume mapped to `/home/sitram/data/photos` used to store family photos
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

I use [PostgressSQL database](https://github.com/docker-library/docs/blob/master/postgres/README.md) as a database server for [Guacamole](../hercules/hercules.md#hercules---guacamole-daemon-and-web-application-docker-container) container

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

- [Authelia](../hercules/hercules.md#hercules---authelia-docker-container)
- [Librespeed](../hercules/hercules.md#hercules---librespeed-docker-container)
- [NextCloud](../nextcloud/nextcloud.md#nextcloud---content-collaboration-server)
- [WordPress blogs](../wordpress/wordpress.md#wordpress---worpress-server-vm)

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

## Stirling-PDF - PDF manipulation tool

I use [Stirling-PDF](https://github.com/Frooodle/Stirling-PDF) as a selfhosted web based PDF manipulation tool

The container has:

- a volume mapped to `/home/sitram/docker/stirling-pdf/trainingData:` used to store extra OCR languages
- a volume mapped to `/home/sitram/media/podcasts` used to store all the podcasts
- a volume mapped to `/home/sitram/docker/stirling-pdf/configs` used to store the configuration of the application
- a volume mapped to `/home/sitram/docker/stirling-pdf/customFiles` used to store custom static files uch as the app logo by placing files in the `/customFiles/static/` directory. An example of customising app logo is placing a `/customFiles/static/favicon.svg` to override current SVG. This can be used to change any images/icons/css/fonts/js etc in Stirling-PDF

Below is the docker-compose I used to launch the container.

```yaml
#Stirling-PDF - locally hosted web based PDF manipulation tool - https://github.com/Frooodle/Stirling-PDF
  stirling-pdf:
    image: frooodle/s-pdf:latest
    container_name: stirling-pdf
    env_file:
      - .env
    ports:
      - 8084:8080
    healthcheck: 
      test: curl -f http://192.168.0.101:8086 || exit 1
      interval: 30s
      timeout: 10s
      retries: 5
    volumes:
      - /home/sitram/docker/stirling-pdf/trainingData:/usr/share/tesseract-ocr/4.00/tessdata #Required for extra OCR languages
      - /home/sitram/docker/stirling-pdf/configs:/configs
      - /home/sitram/docker/stirling-pdf/customFiles:/customFiles/
    environment:
      - DOCKER_ENABLE_SECURITY=false
      - PUID=1000
      - PGID=1000
      - UMASK=022
    restart: unless-stopped
```
