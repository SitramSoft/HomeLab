# Proxmox-Homelab
The following document describes the steps I did to create the current configuration of my Homelab.

Prerequisites:
- [x] Layer 2 Network Switch, preferably one that supports Gigabit Ethernet and has at least 16 ports
- [x] Dedicated PC that can be used as a PVE Host
- [x] Internet access for PVE host
- [x] Network router with Wi-Fi support
    - Preferably one that supports both 2.4Gz and 5Ghz bands
- [x] Cabling
- [ ] UPS to allow the network equipment a clean shutdown in case of power failures and prevent damage caused by power fluctuation
    - I recommend to have a dedicated power circuit for the homelab equipment

Optional:
- [x] Network rack to store all homelab equipment

Summary:
- [About my Homelab](#about-my-homelab)


## About my Homelab
This repository is intended to record my experience in setting up a HomeLab using a dedicated server running [Proxmox](https://www.proxmox.com/en/) with various services running in several VM's and LXC's. I will be touching topics related to virtualization, hardware passtrough, LXC, Docker and several services which I currently use in my Homelab. This document is a work in progress and will evolve as I gain more experience and find more interesting stuff to do. I do not intend this repository or this document to be taken as a tutorial because I don't consider myself an expert in this area. 

Use the information provided in this repository at your own risk. I take no responsibility for any damage to your equipment. Depending on my availability I can support if asked in solving issues with your software but be prepared to troubleshoot stuff that don't work on your own. My recommendation is to take the information that I provide here and adapt it to your own needs and hardware.

## Main server Setup

## Firewall DHCP and NTP server

### VM configuration
### PfSense setup
### DHCP server setup
### NTP server setup
### OpenVPN setup 

## All-around DNS solution
### VM configuration
### piHole setup
### Ubound as a recursive DNS server
### Local DNS configuration

## Home automation with HomeAssistant
### VM configuration
### HomeAssistant installation and setup
### Other plugins(TBD)

### HomeLab services
### VM configuration
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
### VM configuration
### Windows installation
### Remote Desktop Connection configuration

## CodeServer - virtual coding IDE
### VM configuration
### CodeServer installation and configuration
### Accessing CodeServer from outside local network