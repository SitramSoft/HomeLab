# Proxmox - Virtualization server

## Proxmox - OS configuration

The following subsections from [General](./general/general.md#general) section should be performed in this order:

- [SSH configuration](./general/general.md#ssh-configuration)
- [Update system timezone](./general/general.md#update-system-timezone)
- [Generate Gmail App Password](./general/general.md#generate-gmail-app-password)
- [Configure Postfix Server to send email through Gmail](./general/general.md#configure-postfix-server-to-send-email-through-gmail)
- [Mail notifications for SSH dial-in](./general/general.md#mail-notifications-for-ssh-dial-in)

## Proxmox - NTP time server

Because clock accuracy within a VM is still really bad, I chose the barebone server where the virtualization server is running as my local NTP server. It's not ideal but until I decide to move the firewall from a VM to a dedicated HW this will have to do. I tried running NTP server on the pfSense VM but it acted strange.

Follow the instructions from subsection [Ubuntu - Synchronize time with ntpd](./general/general.md#ubuntu---synchronize-time-with-ntpd) to install NTP server then make the modifications below.

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

## Proxmox - PCI Passthrough configuration

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

## Proxmox - UPS monitoring software

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

## SETTING -> NOTIFICATION CHANNELS

- Enable notification by email
- **Provider:** Other
- **SMTP server:** smtp.gmail.com
- **Connection Security:** SSL
- **Service port:** 465
- **Sender name:** UPS Serenity
- **Sender email:** personal email address
- **User name:** personal email address
- **Pass:** Gmail password. See [Generate Gmail App Password](./general/general.md#generate-gmail-app-password) subsection for details.

## SETTING -> SNMP SETTINGS

Enable `SNMPv1` settings and make sure `SNMP Local Port` is `161`.

Create the public and private groups under SNP v1 profiles. Link them to IP address `0.0.0.0` and set them to read/write.

This means any computer on the network can query using SNMP protocol information from the UPS. It is usefull for integrating the UPS in [HomeAssistant - Home automation server](../README.md#homeassistant---home-automation-server).

## Proxmox - VNC client access configuration

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
