# Proxmox - Virtualization server

## Proxmox - OS configuration

The following subsections from [Common](./general/general.md#common) section should be performed in this order:

- [SSH configuration](./general/general.md#ssh-configuration)
- [Update system timezone](./general/general.md#update-system-timezone)
- [Generate Gmail App Password](./general/general.md#generate-gmail-app-password)
- [Configure Postfix Server to send email through Gmail](./general/general.md#configure-postfix-server-to-send-email-through-gmail)
- [Mail notifications for SSH dial-in](./general/general.md#mail-notifications-for-ssh-dial-in)

## Proxmox - NTP time server

Because clock accuracy within a VM is really bad, I chose the barebone server where the virtualization server is running as my local NTP server. It's not ideal but until I decide to move the firewall from a VM to a dedicated HW this will have to do. I tried running NTP server on the pfSense VM but it acted strange.

Since version 8, Porxmox switch from `npt` to `chrony`.

Install [chrony](https://chrony-project.org/) using the following command:

```bash
sudo apt install chrony
```

Edit `chrony` configuration file

```bash
sudo nano /etc/chrony/chrony.conf
```

Replace line

```bash
pool 2.debian.pool.ntp.org iburst
```

with lines below.

```bash
server time1.google.com iburst
server time2.google.com iburst
server time3.google.com iburst
server time4.google.com iburst
```

Add the following line at the end of the file to provide your current local time as a default if Internet connectivity is temporarly lost.

```bash
local stratum 8
```

Configure `chrony` to act as time server for local LAN and VPN

```bash
# Allow LAN and VPN machines to synchronize with this ntp server
allow 192.168.0.0/24
allow 192.168.1.0/24
```

Restart `chrony` server and verify that it's running correctly

```bash
sudo service chrony stop
sudo service chrony start
sudo service chrony status
```

Verify time synchronization status with each defined server or pool and look for `*` near the servers listed by command below. Any server which is not marked with `*` is not syncronized.

```bash
chrony sources
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

### CyberPower Panel Business V4 Installation

In order to communicate with existing [ups](https://www.cyberpower.com/eu/ro/product/sku/cp1500epfclcd), I use the business version of the monitoring software offered by CyberPower called `CyberPower Panel Business V4`.

Download and install the latest 64bit version for Linux of [CyberPower Panel Business](https://www.cyberpowersystems.com/products/software/power-panel-business/). At the time this document was written the latest version was 4.9.0. The download link and the name of the script might change.

```bash
wget https://dl4jz3rbrsfum.cloudfront.net/software/PPB_Linux%2064bit_v4.9.0.sh
```

Make the script executable.

```bash
chmod +x 'PPB_Linux 64bit_v4.9.0.sh'
```

Execute the script in order to install the software.

```bash
sudo ./'PPB_Linux 64bit_v4.9.0.sh'
```

Choose `5` or press `Enter` to select English as language. Confirm installation by pressing `o`.

In case the software is already installed on the system, the installer will detect this and will ask to to choose to update existing installation( option`1`) or make a new one(option `2`).

After agreeing with license, make sure to select local(option `1`) not remote version.

After finishing the installation, access the [web page](http://192.168.0.2:3052/local/login), login with default credentials and continue the configuration on the web interface. As long as the UPS is connected via the USB port to the server, it should be detected automatically by the application.

- user: admin
- pass: admin

### SETTING -> NOTIFICATION CHANNELS

- Enable notification by email
- **Provider:** Other
- **SMTP server:** smtp.gmail.com
- **Connection Security:** SSL
- **Service port:** 465
- **Sender name:** UPS Serenity
- **Sender email:** personal email address
- **User name:** personal email address
- **Pass:** Gmail password. See [Generate Gmail App Password](./general/general.md#generate-gmail-app-password) subsection for details.

### SETTING -> SNMP SETTINGS

Enable `SNMPv1` settings and make sure `SNMP Local Port` is `161`.

Create the public and private groups under SNP v1 profiles. Link them to IP address `0.0.0.0` and set them to read/write.

This means any computer on the network can query using SNMP protocol information from the UPS. It is usefull for integrating the UPS in [HomeAssistant - Home automation server](../README.md#homeassistant---home-automation-server).

### CyberPower PowerPanel Personal Software - Installation

In order to configure shutdown of the server in case of low battery and power failure, I installed additionally [CyberPower PowerPanel Personal Software](https://www.cyberpowersystems.com/products/software/power-panel-personal/). It might be reduntant because CyberPower Panel Business has this functionality already built in, but I couldn't figure out how to make it run.

```bash
wget https://dl4jz3rbrsfum.cloudfront.net/software/PPL_64bit_v1.4.1.deb
```

Make the script executable.

```bash
chmod +x PPL_64bit_v1.4.1.deb
```

Execute the script in order to install the software.

```bash
sudo dpkg -i PPL_64bit_v1.4.1.deb
```

Check if the daemon is running by executing the following command:

```bash
sudo pwrstat -status
```

In case a power failure event occurs, it will take 1 second to run a shell script named `pwrstatd-powerfail.sh` in the directory `/etc`, and the system will be shut down after a power failure event occurs for 15 minutes(900 seconds)

```bash
sudo pwrstat -pwrfail -delay 900 -active on -cmd /etc/pwrstatd-powerfail.sh -duration 1 -shutdown on
```

In case a low battery event occurs, it will take 1 second to run a shell script named `pwrstatd-lowbatt.sh` in the directory `/etc`, and the system will be shut down when either remaining runtime is less then 15 minutes(900 seconds), or the battery capacity is lower than 50%

```bash
sudo pwrstat -lowbatt -runtime 900 -capacity 50 -active on -cmd /etc/pwrstatd-lowbatt.sh -duration 1 -shutdown on
```

To check the current settings use the following command:

```bash
sudo pwrstat -config
```

### CyberPower PowerPanel Personal Software -Uninstall

Uninstalling [CyberPower PowerPanel Personal Software](https://www.cyberpowersystems.com/products/software/power-panel-personal/) is done by running the following command:

```bash
sudo dpkg -r powerpanel
```

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
