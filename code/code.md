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
