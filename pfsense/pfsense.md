# pfSense - Firewall, DHCP and NTP server

## pfSense - VM configuration

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

## pfSense - Setup

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

## Firewall / NAT / Outbound

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

## Firewall / NAT / Port Forward

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

## pfSense - DHCP server setup

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

## pfSense - OpenVPN setup
