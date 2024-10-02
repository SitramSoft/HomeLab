# TrueNAS - Storage management server

## TrueNAS - OS Configuration

## TrueNAS - VM configuration

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

## TrueNAS - HDD passtrough

It is not recommended to passtrough disks by they `sdax` name becaus the operating system can change it. The safest approach is to passtrough the disks by their id. Use following command to list the id of each disk.

```bash
ls -l /dev/disk/by-id/
```

Find the links that matches each drive

```bash
/dev/disk/by-id/ata-HGST_HTS721010A9E630_JR10006P0VSENF -> ../../sdd -> 1TB
/dev/disk/by-id/ata-HGST_HTS721010A9E630_JR10006P0VSMXF -> ../../sdf-> 1TB
/dev/disk/by-id/ata-ST4000VN006-3CW104_WW610H5G -> ../../sde - 4TB
/dev/disk/by-id/ata-ST4000VN006-3CW104_WW610HZL -> ../../sdb - 4TB
/dev/disk/by-id/ata-WDC_WD5000AZRX-00A8LB0_WD-WMC1U5239721 -> ../../sda - 500GB
/dev/disk/by-id/ata-WDC_WD7500BPVT-22HXZT1_WD-WX91A61Y1825 -> ../../sdc - 750GB
```

Add the disk to VM by executing the commands below in Proxmox host shell

```bash
sudo qm set 102 -scsi1 /dev/disk/by-id/ata-HGST_HTS721010A9E630_JR10006P0VSENF
sudo qm set 102 -scsi2 /dev/disk/by-id/ata-HGST_HTS721010A9E630_JR10006P0VSMXF
sudo qm set 102 -scsi3 /dev/disk/by-id/ata-WDC_WD5000AZRX-00A8LB0_WD-WMC1U5239721
sudo qm set 102 -scsi4 /dev/disk/by-id/ata-ST4000VN006-3CW104_WW610H5G
sudo qm set 102 -scsi5 /dev/disk/by-id/ata-ST4000VN006-3CW104_WW610HZL
```

The outpot of each commands should be

```bash
update VM 102: -scsi1 /dev/disk/by-id/ata-HGST_HTS721010A9E630_JR10006P0VSENF
update VM 102: -scsi2 /dev/disk/by-id/ata-HGST_HTS721010A9E630_JR10006P0VSMXF
update VM 102: -scsi3 /dev/disk/by-id/ata-WDC_WD5000AZRX-00A8LB0_WD-WMC1U5239721
update VM 102: -scsi4 /dev/disk/by-id/ata-ST4000VN006-3CW104_WW610H5G
update VM 102: -scsi5 /dev/disk/by-id/ata-ST4000VN006-3CW104_WW610HZL
```

Check if each disk has been attached succesfully

```bash
sudo grep JR10006P0VSENF /etc/pve/qemu-server/102.conf
sudo grep JR10006P0VSMXF /etc/pve/qemu-server/102.conf
sudo grep WMC1U5239721 /etc/pve/qemu-server/102.conf
sudo grep 3CW104_WW610H5G /etc/pve/qemu-server/102.conf
sudo grep 3CW104_WW610HZL /etc/pve/qemu-server/102.conf
```

Output of each of the above command should be

```bash
scsi1: /dev/disk/by-id/ata-HGST_HTS721010A9E630_JR10006P0VSENF,size=976762584K
scsi2: /dev/disk/by-id/ata-HGST_HTS721010A9E630_JR10006P0VSMXF,size=976762584K
scsi3: /dev/disk/by-id/ata-WDC_WD5000AZRX-00A8LB0_WD-WMC1U5239721,size=488386584K
scsi4: /dev/disk/by-id/ata-ST4000VN006-3CW104_WW610H5G,size=3907018584K
scsi5: /dev/disk/by-id/ata-ST4000VN006-3CW104_WW610HZL,size=3907018584K
```

Make sure to reboot the host server if the HDD's were previously managed by it otherwise you will not be able to add the new NFS shares from TrueNAS

## TrueNAS - Setup

Follow the installation guide from [here](https://www.truenas.com/docs/scale/).

Once the installation is completed, open the web interface and continue the rest of the configuration there - [https://192.168.0.114/](https://192.168.0.114/)

Make the following configuration in each page below.

### System Settings -> General

Remove existing NTP servers and add local NPT server(192.168.0.2) with only option selected `iBurst` and Min/Max Pool set to 6/10.

Change `Timezone` in `Localication` to `Europe/Bucharest`

### System Settings -> Services

Activate `SSH` service and make sure it is marked to be started automatically. Press the configure button and make sure `Log in as Root with Password` and `Allow Password Authentication` are unckeched.

### System Settings -> Advanced

Open `Syslog` to change `Syslog Server` to `192.168.0.116:5514` in order to send the logs to HomeLab log server.

Open the `System Dataset Pool` and chose the value `tank1` instead of of `boot-pool` for option `Sepect Pool` to move the system dataseet from the boot pool which is located to Serenity SSD to tank1. This reduces the wear of the SSD.

### Credentials -> Local Users

Add a new user called `sitram` with UID `1000`

Add my personal public key to user `root` so that I can log is with SSH securely.

### Credentials -> Local Groups

Add a new group called `sitram` with GID `1000`

### Network

In `Global Configuration` section change

- Hostname: `storage`
- Domain: `local`
- DNS: `192.168.0.101` and `8.8.8.8`
- Default Gateway: `192.168.0.1`

### Shares

- Windows (SMB) Shares
  - Share 1
    - Name: `media`
    - Path: `/mnt/tank2/media`
    - Description: `Storage for various media files(movies, tv series, music, torrents etc)`
  - Share 2
    - Name: `data`
    - Path: `/mnt/tank1/data`
    - Description: `Storage for critical data`
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
    - Path: `/mnt/nicusor`
    - Description: `Personal storage for Nicusor Maciu`
    - Maproot User: `root`
    - Maproot Group: `root`
    - Authorized Hosts and IP address: `192.168.0.102` and `192.168.0.2` and `192.168.0.5` and `192.168.0.4` and `192.168.0.105`
  - Share 4
    - Path: `/mnt/tank2/proxmox`
    - Description: `Storage for ISO and CT for Proxmox`
    - Maproot User: `root`
    - Maproot Group: `root`
    - Authorized Hosts and IP address: `192.168.0.2`
  - Share 5
    - Path: `/mnt/tank2/media`
    - Description: `Storage for various media files(movies, tv series, music, torrents etc)`
    - Maproot User: `root`
    - Maproot Group: `root`
    - Authorized Hosts and IP address: ``
  - Share 6
    - Path: `/mnt/tank1/logs/graylog` && `/mnt/tank1/logs/opensearch`
    - Description: `Storage for logs from various systems`
    - Maproot User: `root`
    - Maproot Group: `root`
    - Authorized Hosts and IP address: `192.168.0.116`
  - Share 7
    - Path: `/mnt/tank1/docker_data`
    - Description: `Storage for docker containers data`
    - Maproot User: `root`
    - Maproot Group: `root`
    - Authorized Hosts and IP address: `192.168.0.116` and `192.168.0.4` and `192.168.0.5`
