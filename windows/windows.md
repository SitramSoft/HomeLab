# Windows11 - Virtual Windows Desktop VM

## Windows11 - VM configuration

- VM id: 150
- HDD: 32GB
- BIOS: OVMF(UEFI)
- Sockets: 1
- Cores: 12
- RAM:
  - Min: 32768
  - Max: 32768
  - Ballooning Devices: enabled
- Machine: pc-q35-6.2
- EFI Disk: 4MB
- TPM State: 4MB
- HDD: 120GB
- Network
  - LAN MAC address: 02:D0:7F:F8:61:1C
  - Static ip assigned in pfSense: 192.168.0.104
  - Local domain record in piHole: win.local
- Options:
  - Start at boot: disabled
  - Use tablet for pointer: disabled
  - QEMU Guest Agent: enabled, guest trim
- OS: [Windows 11](https://www.microsoft.com/software-download/windows11)

## Windows11 - Windows installation

Download [Windows 11 Disk Image (ISO)](https://www.microsoft.com/software-download/windows11) for x64 devices and follow the instructions from the installer assistant.

Download the latest virt-io drivers from [here](https://github.com/virtio-win/virtio-win-pkg-scripts/blob/master/README.md).

Upload both files in `tank2-images(serenity)` ISO Images section.

Mount each of the two images downloaded from the link above as a separate CD/DVD Drive in the Hardware section in Proxmox.

Follow the remaining instructuions from [here](https://www.wundertech.net/how-to-install-windows-11-on-proxmox/)

After OS installation is finished, install the following applications:

- [Adobe Acrobat](https://get.adobe.com/reader/)
- [BabyWare v5.4.26](https://descargas.fiesa.com.ar/descargas/Paradox/Softwares/BabyWare/)
  - [Paradox](https://www.paradox.com/Download/Babyware.asp?CATID=9&SUBCATID=184) requires an installer account to download most of their updates. Updates can be found online on other companies websites like [this one](https://descargas.fiesa.com.ar/descargas/Paradox/)
- [Dacia Media Nav Evolution Toolbox](https://dacia.welcome.naviextras.com/guide_en.html)
- [GitHub Desktop](https://desktop.github.com/)
- [Google Chrome](https://www.google.com/chrome/)
- [Google Drive](https://www.google.com/drive/download/)
- [Nextcloud Client](https://nextcloud.com/install/)
- [Dahua Smart PSS](https://dahuawiki.com/SmartPSS)
- [Dahua Config Tool](https://dahuawiki.com/ConfigTool)

## Windows11 - Remote Desktop Connection configuration

Default settings used for Remote Desktop Connection
