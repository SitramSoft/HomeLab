# General

The following sections apply to all VM's.

Unless the services running on the VM require a dedicated OS, I prefer to use Ubuntu Server. The sections in this chapter are tested on Ubuntu Server but might apply with slight modifications to other Linux based operating systems. For each VM I will specify which chapter from this section applies.

Every VM has user **sitram** configured during installation. The user has **sudo** privileges.

## SSH configuration

I use two keys for my entire HomeLab. One is used for Guacamole, so I can access from any web browser my servers in case I don't have access trough a SSH client. The other is my personal key which I use for accessing trough SSH clients.

I store these keys on every VM so that I can easily connect from one VM to another using SSH. A copy of each key is stored in an offline secure location.

Copy sshd configuration from an existing VM. An example can be found in this repo [here](sshd_config)

```bash
scp /etc/ssh/sshd_config sitram@192.168.0.xxx:/home/sitram
```

Copy the private and public keys for accessing the VM trough Guacamole from an existing VM

 ```bash
scp guacamole sitram@192.168.0.xxx:~/.ssh/
scp guacamole.pub sitram@192.168.0.xxx:~/.ssh/
```

Copy personal private and public keys for accessing the VM trough SSH and being able to access other servers on the network from an existing VM.

```bash
scp id_rsa sitram@192.168.0.xxx:~/.ssh/
scp id_rsa.pub sitram@192.168.0.xxx:~/.ssh/
```

Copy the authorized_keys file which allows connection to the VM using only my Guacamole or personal key from an existing VM.

```bash
scp authorized_keys sitram@192.168.0.xxx:~/.ssh/
```

Backup default sshd configuration, in case something goes wrong. Replace the existing configuration with the new one.

```bash
sudo mv /etc/ssh/sshd_config /etc/ssh/sshd_config.bkp
sudo mv ~/sshd_config /etc/ssh/
sudo chown root:root /etc/ssh/sshd_config
```

Restart sshd to use the new configuration.

```bash
sudo systemctl restart sshd
```

## Execute commands using SSH

The SSH client program can be used for logging into a remote machine or server and for executing commands on a remote machine. When a command is specified, it is executed on the remote host/server instead of the login shell of the current machine.

The syntax is as follows for executing commands

```bash
ssh user1@server1 command1
ssh user1@server1 'command2'
```

Several commands can be piped using the syntax below

```bash
ssh user1@server1 'command1 | command2'
```

Multiple compands can be executed using the syntax below

```bash
ssh user@hostname "command1; command2; command3"
```

Commands can be executed remotely with `sudo` using the syntax below

```bash
ssh -t user@hostname sudo command
ssh -t user@hostname 'sudo command1 arg1 arg2'
```

Execute comands remote with `su`

```bash
ssh user@hostname su -c "/path/to/command1 arg1 arg2"
```

To copy a file from `B` to `A` while logged into `B`:

```bash
scp /path/to/file username@a:/path/to/destination
```

To copy a file from `B` to `A` while logged into `A`:

```bash
scp username@b:/path/to/file /path/to/destination
```

## How to fix warning about ECDSA host key

When connecting with SSH, the following warning could be displayed in case the IP is reused for a different VM.

```text
Warning: the ECDSA host key for 'myserver' differs from the key for the IP address '192.168.0.xxx'
```

In order to get rid of the warning, remove the cached key for ```192.168.1.xxx``` on the local machine:

```bash
ssh-keygen -R 192.168.1.xxx
```

## Ubuntu - Initial setup of an clonned VM

After clonning an template VM running Ubuntu, I use the following script to do change the hostname.

```bash
sudo bash -c "bash <(wget -qO- https://raw.githubusercontent.com/SitramSoft/HomeLab/main/new_vm.sh)"
```

## Ubuntu - upgrade from older distribution

```bash
sudo apt update
sudo apt list --upgradable
sudo apt upgrade
```

The repositories for older releases that are not supported (like 11.04, 11.10 and 13.04) get moved to an archive server. There are repositories available at [old-releases.ubuntu.com](http://old-releases.ubuntu.com).

The reason for this is that it is now out of support and no longer receiving updates and security patches.

If you want to continue using an outdated release, edit `/etc/apt/sources.list` and change `archive.ubuntu.com` and `security.ubuntu.com` to `old-releases`.ubuntu.com.

You can do this with sed:

```bash
sudo sed -i -re 's/([a-z]{2}\.)?archive.ubuntu.com|security.ubuntu.com/old-releases.ubuntu.com/g' /etc/apt/sources.list
```

then update the system with:

```bash
sudo apt-get update && sudo apt-get dist-upgrade
```

## Ubuntu - configure unattended upgrades

Ubuntu provides a unique tool called `unattended-upgrades` in order to automatically retrieve and install security patches and other essential upgrades for a server. Installing the tool can be done with the following commands:

```bash
sudo apt-get update
sudo apt install unattended-upgrades
```

After installation, you can check to ensure that the `unattended-upgrades` service is running using `systemctl`

```bash
sudo systemctl status unattended-upgrades.service
```

Open configuration file `/etc/apt/apt.conf.d/50unattended-upgrades` with `nano`:

```bash
sudo nano /etc/apt/apt.conf.d/50unattended-upgrades
```

Uncomment or change the following lines

- `"${distro_id}:${distro_codename}-updates";`
- `Unattended-Upgrade::Mail "adrian.martis@gmail.com";`
- `Unattended-Upgrade::Remove-Unused-Kernel-Packages "true";`
- `Unattended-Upgrade::Remove-New-Unused-Dependencies "true";`
- `Unattended-Upgrade::Remove-New-Unused-Dependencies "true";`

An example of this file that I use on all my Ubuntu based VM's can be found [here](50unattended-upgrades)

Reload `unattended-upgrades` service:

```bash
sudo systemctl restart unattended-upgrades.service
```

## Ubuntu - Clean unnecessary packages

Very few server instances utilize these packages and they can be clean to save storage on the VM. Make sure you don't need them before removing them.

```bash
sudo apt purge --auto-remove snapd squashfs-tools friendly-recovery apport at cloud-init
```

Remove the `unattended-upgrades` package and the associated services which are responsible for automatically updating packages in the system in case this functionality is not used in your HomeLab.

```bash
sudo apt purge --auto-remove unattended-upgrades
sudo systemctl disable apt-daily-upgrade.timer
sudo systemctl mask apt-daily-upgrade.service
sudo systemctl disable apt-daily.timer
sudo systemctl mask apt-daily.service
```

Remove orphan packages

```bash
sudo apt autoremove --purge
```

## Ubuntu - Remove old kernels

After a while, there will be multiple versions of kernel on your system, which take up a lot of storage space. Old kernels and images can be removed with the following command

```bash
dpkg --list | grep 'linux-image' | awk '{ print $2 }' | sort -V | sed -n '/'"$(uname -r | sed "s/\([0-9.-]*\)-\([^0-9]\+\)/\1/")"'/q;p' | xargs sudo apt-get -y purge
```

Remove old kernels headers

```bash
dpkg --list | grep 'linux-headers' | awk '{ print $2 }' | sort -V | sed -n '/'"$(uname -r | sed "s/\([0-9.-]*\)-\([^0-9]\+\)/\1/")"'/q;p' | xargs sudo apt-get -y purge
```

Explanation (remember, `|` uses the output of the previous command as the input to the next)

- `dpkg` --list lists all installed packages
- `grep linux-image` looks for the installed linux images
- `awk '{ print $2 }'` just outputs the 2nd column (which is the package name)
- `sort -V` puts the items in order by version number
- ```$(uname -r | sed "s/\([0-9.-]*\)-\([^0-9]\+\)/\1/")"``` extracts only the version (e.g. "3.2.0-44") , without "-generic" or similar from `uname -r`
- `xargs sudo apt-get -y` purge purges the found kernels

Modify last part `xargs echo sudo apt-get -y purge` so that the command to purge the old kernels/headers is printed, then you can check that nothing unexpected is included before you run it.

All-in-one version to remove images and headers (combines the two versions above):

```bash
echo $(dpkg --list | grep linux-image | awk '{ print $2 }' | sort -V | sed -n '/'`uname -r`'/q;p') $(dpkg --list | grep linux-headers | awk '{ print $2 }' | sort -V | sed -n '/'"$(uname -r | sed "s/\([0-9.-]*\)-\([^0-9]\+\)/\1/")"'/q;p') | xargs sudo apt-get -y purge
```

## Ubuntu - Clean up snap

List all versions of packages retained by Snap

```bash
snap list --all
```

The default value is 3 for several revisions for retention. That means Snap keeps 3 older versions of each package, including the active version. Changing the retention value to 2 can be done with the following command

```bash
sudo snap set system refresh.retain=2
```

Script to set the default retention value of Snap packages to 2 and clean-up older packages

```bash
#!/bin/bash
#Set default retention values of snaps to 2
sudo snap set system refresh.retain=2

#Removes old revisions of snaps
#CLOSE ALL SNAPS BEFORE RUNNING THIS
set -eu
LANG=en_US.UTF-8 snap list --all | awk '/disabled/{print $1, $3}' |
    while read snapname revision; do
        sudo snap remove "$snapname" --revision="$revision"
    done
```

## Clear systemd journald logs

Checking disk usage of all journal files is done with command

```bash
sudo journalctl --disk-usage
```

Before clearing the logs, run the following command to rotate the journal files. All currently active journal files will be marked as archived, so that they are never written in future.

```bash
sudo journalctl --rotate
```

Delete journal logs older than X days

```bash
sudo journalctl --vacuum-time=2days
```

Delete log files until the disk space taken falls below the specified size:

```bash
sudo journalctl --vacuum-size=100M
```

Delete old logs and limit file number to X:

```bash
sudo journalctl --vacuum-size=100M
```

Edit the configuration file to limit the journal log disk usage to 100MB

```bash
sudo -H gedit /etc/systemd/journald.conf
```

When the file opens, un-comment (remove # at the beginning) the line `#SystemMaxUse=` and change it to `SystemMaxUse=100M`.

Save the file and reload systemd daemon via command:

```bash
sudo systemctl daemon-reload
```

## Ubuntu - MariaDB update

MariaDb distribution repo can be found [here](https://mariadb.org/download/?t=repo-config)

Configure MariaDB APT repository and add MariaDB signing key to use Ubuntu 20.04 (Focal Fossa) repository:

```bash
curl -LsS -O https://downloads.mariadb.com/MariaDB/mariadb_repo_setup
sudo bash mariadb_repo_setup --os-type=ubuntu  --os-version=focal --mariadb-server-version=10.6
```

## Ubuntu - Install nginx

Install the prerequisites:

```bash
sudo apt install curl gnupg2 ca-certificates lsb-release ubuntu-keyring
```

Import an official nginx signing key so apt could verify the packages authenticity. Fetch the key:

```bash
curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor \
    | sudo tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null
```

Verify that the downloaded file contains the proper key:

```bash
gpg --dry-run --quiet --import --import-options import-show /usr/share/keyrings/nginx-archive-keyring.gpg
```

The output should contain the full fingerprint 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 as follows:

```bash
pub   rsa2048 2011-08-19 [SC] [expires: 2024-06-14]
      573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62
uid                      nginx signing key <signing-key@nginx.com>
```

If the fingerprint is different, remove the file.

To set up the apt repository for stable nginx packages, run the following command:

```bash
echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
http://nginx.org/packages/ubuntu `lsb_release -cs` nginx" \
    | sudo tee /etc/apt/sources.list.d/nginx.list
```

If you would like to use mainline nginx packages, run the following command instead:

```bash
echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
http://nginx.org/packages/mainline/ubuntu `lsb_release -cs` nginx" \
    | sudo tee /etc/apt/sources.list.d/nginx.list
```

Set up repository pinning to prefer our packages over distribution-provided ones:

```bash
echo -e "Package: *\nPin: origin nginx.org\nPin: release o=nginx\nPin-Priority: 900\n" \
    | sudo tee /etc/apt/preferences.d/99nginx
```

To install nginx, run the following commands:

```bash
sudo apt update
sudo apt install nginx
```

## Ubuntu - Configure PHP source list

Add PHP software sources

```bash
cd /etc/apt/sources.list.d
sudo echo "deb [signed-by=/usr/share/keyrings/php-fm.gpg] http://ppa.launchpad.net/ondrej/php/ubuntu $(lsb_release -cs) main" | sudo tee php.list
```

In order to be able to trust the sources, use the corresponding keys:

```bash
sudo apt-key adv --recv-keys --keyserver hkps://keyserver.ubuntu.com:443 4F4EA0AAE5267A6C
sudo apt-get update -q4
sudo make-ssl-cert generate-default-snakeoil -y
sudo apt-key export E5267A6C | sudo gpg --dearmour -o /usr/share/keyrings/php-fm.gpg
sudo apt-key del E5267A6C
sudo apt-get update
```

## Ubuntu - Replace netplan.io with systemd-networkd

Remove netplan.io

```bash
sudo apt remove --purge netplan.io
```

Removing netplan.io will also remove `ubuntu-minimal`. According to [this](https://askubuntu.com/questions/1066154/what-is-the-ubuntu-minimal-package-and-do-i-need-it#:~:text=As%20explained%20earlier%2C%20'ubuntu%2D,impact%20on%20currently%20installed%20packages) it has no effect on an installed system. Its purpose is to point to packages required of a minimal install. To keep the dependency `ubuntu-minimal` use:

```bash
sudo dpkg -r --force-depends netplan.io
```

After restart the server will have no internet access so run the commands below. If any are not applicable(eg. first two), ingore them.

``` bash
sudo systemctl disable network-manager
sudo systemctl stop network-manager
sudo systemctl enable systemd-networkd
sudo systemctl start systemd-networkd
sudo systemctl start systemd-resolved
sudo systemctl enable systemd-resolved
sudo rm /etc/resolv.conf
sudo ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf

sudo tee /etc/systemd/network/20-dhcp.network << END
[Match]
Name=enp5s0

[Network]
DHCP=yes
END
```

What the last command doing is, it is appending lines in `/etc/systemd/network/20-dhcp.network`. To know what value should be used in `Name=enp5s0`, run `ip -c link` to get the name of the NIC.

If you do not have DHCP and need to use static IP, Replace

```bash
[Network]
DHCP=yes
```

with the specific details (IP Address, Gateway and DNS).

```bash
[Network]
Address=10.1.10.9/24
Gateway=10.1.10.1
DNS=10.1.10.1
```

If you are using wifi, you might have to add the line `IgnoreCarrierLoss=3s` under `[Network]`

Now Run

```bash
sudo systemctl restart systemd-networkd
sudo systemctl restart systemd-resolved
```

Additional details can be found by reading [systemd-networkd](https://wiki.archlinux.org/title/systemd-networkd#Required_services_and_setup).

## Ubuntu - Synchronize time with systemd-timesyncd

I have a dedicated timeserver which servers all the clients in my HomeLab. Whenever it is possible, I configure each server to use the internal timeserver.

Make sure NTP is not installed

```bash
sudo apt purge ntp
```

Edit file `timesyncd.conf`

```bash
sudo nano /etc/systemd/timesyncd.conf
```

Uncomment and modify the lines starting with `NTP`and `FallbackNTP`

```bash
NTP=192.168.0.2
FallbackNTP=pool.ntp.org
```

Restart the timesync daemon to use the internal timeserver

```bash
sudo systemctl restart systemd-timesyncd
```

or

```bash
sudo timedatectl set-ntp off
sudo timedatectl set-ntp on
timedatectl timesync-status
```

Check newly configured NTP servers are used by looking in the journal

```bash
journalctl --since -1h -u systemd-timesyncd
```

Configuration used can be checked using

```bash
sudo timedatectl show-timesync --all
```

To start troubleshooting, check the logs using the command

```bash
sudo grep systemd-timesyncd /var/log/syslog | tail
```

## Ubuntu - Synchronize time with ntpd

Install NTP server and ntpdate. Verify the version of NTP server to make sure it is correctly installed

```bash
sudo apt-get update
sudo apt-get install ntp ntpdate
sntp --version
```

Configure the NTP server pool either to a server closest to own location or local NTP server.

```bash
sudo nano /etc/ntp.conf
```

Comment the lines starting with `pool` and add the line

```bash
server 192.168.0.2 prefer iburst
```

The `iburst` option is recommended, and sends a burst of packets only if it cannot obtain a connection with the first attempt.
The `burst` option always does this, even on the first attempt, and should never be used without explicit permission and may result in blacklisting.

Restart NTP server and verify that it's running correctly

```bash
sudo service ntp stop
sudo service ntp start
sudo service ntp status
```

Check newly configured NTP servers are used by looking in the journal

```bash
journalctl --since -1h -u ntpd
```

In order to verify time synchronization status with each defined server or pool look for `\*` near the servers listed by command below. Any server which is not marked with `\*` is not syncronized.

```bash
ntpq -pn
```

Force update time with NTP service daemon and check that the communication with the ntp server is successfully.

```bash
date ; sudo service ntp stop ; sudo ntpdate -d 192.168.0.2 ; sudo service ntp start ; date
```

Logs can be checked using the command below

```bash
sudo grep ntpd /var/log/syslog | tail
```

## Ubuntu - Synchronize time with chrony

Install [chrony](https://chrony-project.org/) using the following command:

```bash
sudo apt install chrony
```

Edit `chrony` configuration file

```bash
sudo nano /etc/chrony/chrony.conf
```

Comment out all lines that contain `pool` and add below the following line which configures the local time server.

```bash
server 192.168.0.2
```

Restart `chrony` server and verify that it's running correctly

```bash
sudo service chrony stop
sudo service chrony start
sudo service chrony status
```

Verify time synchronization status with each defined server or pool and look for `*` near the servers listed by command below. Any server which is not marked with `*` is not syncronized.

```bash
chronyc sources
```

## Update system timezone

In order to list all available timezones, the following command can be used

```bash
timedatectl list-timezones
```

Once the correct timezone from the above list has been chosen, system timezone can be changed using the command

```bash
sudo timedatectl set-timezone Europe/Bucharest
```

Check that system timezone, system clock synchronization and NTP services are correct

```bash
sudo timedatectl
```

## Correct DNS resolution

Edit file `/etc/systemd/resolved.conf` an add the following lines:

```bash
[Resolve]
DNS=192.168.0.103
FallbackDNS=8.8.8.8
Domains=local
```

To provide domain name resolution for software that reads `/etc/resolv.conf` directly, such as web browsers and GnuPG, replace the file with a symbolic link to the one from `systemd-resolved`

```bash
sudo rm -f /etc/resolv.conf
sudo ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf
sudo systemctl restart systemd-resolved.service
```

Check that both Global and the link for the ethernet/wireless interface has correct dns and domain set using:

```bash
sudo resolvectl status
```

## Qemu-guest-agent

The qemu-guest-agent is a helper daemon, which is installed in the guest VM. It is used to exchange information between the host and guest, and to execute command in the guest.

According to Proxmox VE [wiki](https://pve.proxmox.com/wiki/Qemu-guest-agent), the qemu-guest-agent is used for mainly two things:

1. To properly shutdown the guest, instead of relying on ACPI commands or windows policies
2. To freeze the guest file system when making a backup (on windows, use the volume shadow copy service VSS).

guest-agent has to be installed in ech VM and enabled in Proxmox VE GUI or via CLI

- GUI: On the VM Options tab, set option 'Enabled' on 'QEMU Guest Agent
- CLI: `qm set VMID --agent 1`

## Simulate server load

Sometimes you need to discover how the performance of an application is affected when the system is under certain types of load. This means that an artificial load must be created. It is possible to install dedicated tools to do this, but this option isn’t always desirable or possible.

Every Linux distribution comes with all the tools needed to create load. They are not as configurable as dedicated tools but they will always be present and you already know how to use them.

### CPU

The following command will generate a CPU load by compressing a stream of random data and then sending it to `/dev/null`:

```bash
cat /dev/urandom | gzip -9 > /dev/null
```

If you require a greater load or have a multi-core system simply keep compressing and decompressing the data as many times as you need:

```bash
cat /dev/urandom | gzip -9 | gzip -d | gzip -9 | gzip -d > /dev/null
```

An alternative is to use the sha512sum utility:

```bash
sha512sum /dev/urandom
```

Use CTRL+C to end the process.

### RAM

The following process will reduce the amount of free RAM. It does this by creating a file system in RAM and then writing files to it. You can use up as much RAM as you need to by simply writing more files.

First, create a mount point then mount a ramfs filesystem there:

```bash
mkdir z
mount -t ramfs ramfs z/
```

Then, use dd to create a file under that directory. Here a 128MB file is created:

```bash
dd if=/dev/zero of=z/file bs=1M count=128
```

The size of the file can be set by changing the following operands:

- bs= Block Size. This can be set to any number followed B for bytes, K for kilobytes, M for megabytes or G for gigabytes.
- count= The number of blocks to write.

### Disk

We will create disk I/O by firstly creating a file, and then use a for loop to repeatedly copy it.

This command uses dd to generate a 1GB file of zeros:

```bash
dd if=/dev/zero of=loadfile bs=1M count=1024
```

The following command starts a for loop that runs 10 times. Each time it runs it will copy loadfile over loadfile1:

```bash
for i in {1..10}; do cp loadfile loadfile1; done
```

If you want it to run for a longer or shorter time change the second number in {1..10}.

If you prefer the process to run forever until you kill it with CTRL+C use the following command:

```bash
while true; do cp loadfile loadfile1; done
```

## Generate Gmail App Password

When Two-Factor Authentication (2FA) is enabled, Gmail is preconfigured to refuse connections from applications that don’t provide the second step of authentication. While this is an important security measure that is designed to restrict unauthorized users from accessing your account, it hinders sending mail through some SMTP clients as you’re doing here. Follow these steps to configure Gmail to create a Postfix-specific password:

1. Log in to your Google Account and navigate to the [Manage your account access and security settings](https://myaccount.google.com/security) page.

2. Scroll down to `Signing in to Google` section and enable `2-Step Verification`. You may be asked for your password and a verification code before continuing.

3. In that same section, click on [App passwords](https://security.google.com/settings/security/apppasswords) to generate a unique password that can be used with your application.

4. Click the `Select app` dropdown and choose `Other (custom name)`. Enter name of the service of app for which you want to generate a password and click `Generate`.

5. The newly generated password will appear. Write it down or save it somewhere secure that you’ll be able to find easily in the next steps, then click `Done`:

## Configure Postfix Server to send email through Gmail

Postfix is a Mail Transfer Agent (MTA) that can act as an SMTP server or client to send or receive email. I chose to use this method to avoid getting my mail to be flagged as spam if my current server’s IP has been added to a block list.

Install Postfix and libsasl2, a package which helps manage the Simple Authentication and Security Layer (SASL)

```bash
sudo apt-get update
sudo apt-get install libsasl2-modules postfix
```

When prompted, select `Internet Site` as the type of mail server the Postfix installer should configure. In the next screen, the `System Mail Name` should be set to the domain you’d like to send and receive email through.

Once the installation is complete, confirm that the `myhostname` parameter is configured with your server’s FQDN in `/etc/postfix/main.cf`

Generate an Gmail password as described in subsection [Generate Gmail App Password](../general/general.md#generate-gmail-app-password).

Usernames and passwords are stored in sasl_passwd in the `/etc/postfix/sasl/` directory. In this section, you’ll add your email login credentials to this file and to Postfix.

Open or create the `/etc/postfix/sasl/sasl_passwd` file and add the SMTP Host, username, and password information.

```bash
sudo nano /etc/postfix/sasl/sasl_passwd
```

The SMTP server address configuration `smtp.gmail.com` supports message submission over port `587`(StartTLS) and port `465(`SSL). Whichever protocol you choose, be sure the port number is the same in `/etc/postfix/sasl/sasl\\_passwd` and `/etc/postfix/main.cf`

```bash
[smtp.gmail.com]:587 username@gmail.com:password
```

Create the hash db file for Postfix by running the postmap command.

```bash
sudo postmap /etc/postfix/sasl/sasl_passwd
```

If all went well, a new file named `sasl_passwd.db` in the `/etc/postfix/sasl/` directory.

Secure Postfix has database and email password files by changing persmissions of `/etc/postfix/sasl/sasl_passwd` and the `/etc/postfix/sasl/sasl_passwd.db` so that only root user cand read from or write to them.

```bash
sudo chown root:root /etc/postfix/sasl/sasl_passwd /etc/postfix/sasl/sasl_passwd.db
sudo chmod 0600 /etc/postfix/sasl/sasl_passwd /etc/postfix/sasl/sasl_passwd.db
```

Next step is to configure the Postfix Relay Server to use Gmail's SMTP server.

Add or modify if exists the following parameters to Postfix configuration file `/etc/postfix/main.cf`

```bash
# make sure the port number is matching the one from /etc/postfix/sasl/sasl\\_passwd
relayhost = [smtp.gmail.com]:587

# Enable SASL authentication
smtp_sasl_auth_enable = yes
# Disallow methods that allow anonymous authentication
smtp_sasl_security_options = noanonymous
# Location of sasl_passwd
smtp_sasl_password_maps = hash:/etc/postfix/sasl/sasl_passwd
# Enable STARTTLS encryption
smtp_tls_security_level = encrypt
# Location of CA certificates
smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt
```

Save changes and restart Postfix server.

```bash
sudo systemctl restart postfix
```

Use Postfix’s sendmail implementation to send a test email. Enter lines similar to those shown below, and note that there is no prompt between lines until the . ends the process.

```bash
sudo sendmail recipient@elsewhere.com
From: you@example.com
Subject: Test mail
This is a test email
.
```

Check in a separate sesion the changes as they appear live with command below. Use `CRTL + C` to exit the log.

```bash
sudo tail -f /var/log/syslog
```

## Mail notifications for SSH dial-in

Install mail client

```bash
sudo apt-get update
sudo apt-get install mailutils
```

Edit sustem-wide `.profile` for Bourne compative shells

```bash
sudo nano /etc/profile
```

Add the following text at the end of the file

```bash
if [ -n "$SSH_CLIENT" ]; then
        echo -e 'Login details:\n  - Hostname:'  `hostname -f` '\n  - Date:' "`date`" '\n  - User:' "`who -m`" | mail -s "Login on `hostname` from `echo $SSH_CLIENT | awk '{print $1}'`" username@gmail.com
fi
```

## Backup folder

In Linux, the tar command is one of the essential commands as far as file management is concerned. It’s short for Tape Archive, and it’s used for creating & extracting archive files.  An archive file is a compressed file containing one or multiple files bundled together for more accessible storage and portability. More examples can be found [here](https://linuxhint.com/linux-tar-command/)

The `tar` command provides the following options:

- `-c`: This creates an archive file.
- `-x`: The option extracts the archive file.
- `-f`: Specifies the filename of the archive file.
- `-v`: This prints verbose information for any tar operation on the terminal.
- `-t`: This lists all the files inside an archive file.
- `-u`: This archives a file and then adds it to an existing archive file.
- `-r`: This updates a file or directory located inside a .tar file
- `-z`: Creates a tar file using gzip compression
- `-j`: Create an archive file using the bzip2 compression
- `-W`: The -w option verifies an archive file.

```bash
tar -zcvf folder.tar.gz html
```

## Generate random passwords or tokens

A random string of variable lenght that can be used for passwords or access tokens can be generated in the following ways:

- using `/dev/urandom` with `tr` to get only digits and letters:

```bash
tr -dc A-Za-z0-9 </dev/urandom | head -c 13 ; echo ''
```

- using `/dev/urandom` with `tr` to include more characters from the [OWASP password special characters list](https://owasp.org/www-community/password-special-characters):

```bash
tr -dc 'A-Za-z0-9!"#$%&'\''()*+,-./:;<=>?@[\]^_`{|}~' </dev/urandom | head -c 13  ; echo
```

- using `openssl` command, the swiss army knife of cryptography:

```bash
openssl rand -base64 12
```

## Install John the Ripper

```bash
git clone "https://github.com/magnumripper/JohnTheRipper.git" && cd JohnTheRipper/src && ./configure && sudo make -s clean && sudo make -sj4
```

## Mysql - recover lost user password

In case the root password for an instance has been lost or mysql has been accidentaly upgraded from 8.4.x to 9.x.x and mysql_native_password plugin is no longer available, use the following sequence to recover the connection to the databse.

Add to docker compose file the following option then recreate the container.

```bash
command: --skip-grant-tables
```

Connect to `mysql` container shell using `root` user trough portainer web interface or cli.

Type `mysql` then press `Enter` and you should be able to connect to mysql instance.

Show all users that have the `mysql_native_password` plugin

```sql
FLUSH PRIVILEGES;
select User,Host,plugin from mysql.user where plugin='mysql_native_password';
```

For each user and host run the following command:

```sql
ALTER USER 'user'@'host' IDENTIFIED WITH caching_sha2_password BY 'new_password';
```

Execute:

```sql
FLUSH PRIVILEGES;
EXIT;
```

Remove from docker-compose file command: `--skip-grant-tables` then recreate the container.

Once the above steps are done, you should be able to connect to the mysql instance again.

## Find all files containing a specific text (string) on Linux

In order to search all files containing a specific text (string) in Linux the following command can be used:

``` bash
grep -Rnw '/path/to/somewhere/' -e 'pattern'
```

- `-r` or `-R` is recursive; use `-R` to search entirely
- `-n` is line number
- `-w` stands for match the whole word
- `-l` (lower-case L) can be added to just give the file name of matching files
- `-e` is the pattern used during the search

Along with these, `--exclude`, `--include`, `--exclude-dir` flags could be used for efficient searching:

- This will only search through those files which have .c or .h extensions:

```bash
grep --include=\*.{c,h} -rnw '/path/to/somewhere/' -e "pattern"
```

- This will exclude searching all the files ending with .o extension:

``` bash
grep --exclude=\*.o -rnw '/path/to/somewhere/' -e "pattern"
```

- For directories it's possible to exclude one or more directories using the `--exclude-dir` parameter. For example, this will exclude the dirs `dir1/`, `dir2/` and all of them matching `*.dst/`:

```bash
grep --exclude-dir={dir1,dir2,*.dst} -rnw '/path/to/search/' -e "pattern"
```

## Indication of disk failures

Modern disks are so packed with data that the `Raw_Read_Error_Rate` is usually fairly high - after applying [error correction](http://en.wikipedia.org/wiki/Reed%E2%80%93Solomon_error_correction), no problems arise with data access/reliability.

Focus on the the following 3 values reported in SMART data to get an indication if the drive shows signs of failure.

```bash
196 Reallocated_Event_Count 0x0032   100   100   000    Old_age   Always       -0
197 Current_Pending_Sector  0x0032   100   100   000    Old_age   Always       -0
198 Offline_Uncorrectable   0x0030   100   100   000    Old_age   Offline      -0
```

These are the number of sectors reallocated, waiting to be reallocated, and unable to be reallocated, respectively.

When the head hits a bad sector and reading fails, it becomes a `Current_Pending_Sector`. The next time you try to write to it, it either works (everything goes back to normal, and the sector is reallocated) or it fails again. If there is reallocation space available from the pool, it will be reallocated. (`Reallocated_Event_Count` + 1). If the pool is used up, the sector becomes `Offline_Uncorrectable` and no further read/writes are possible.

The drives that report raw read error rates will also report uncorrectable errors and it should only be concearned if the uncorrectable error counter increases.

Uncorrectable errors can also be caused by factors outside of the drive itself like bad SATA cables, bad cable connection, faulty RAM, faulty DMI bus or faulty controller.

If uncorrectable errors increases but reallocated sectors don't increase, first thing to do is try a different cable, ideally also on a different port as well. Make sure not to overclock anyhting on the board, using out of the box voltages for the board, ram and cpu. If the errors persist, then at that point you might consider there could be an issue with the drive (uncorrectable errors not raw read error rate).

Current pending sectors. This increases when some data failed to read and the sectors will stay pending until they are written to again. If the write succeeds they will be removed and nothing else happens, if the write fails, then they will be reallocated. They will also be removed if another read attempt is made and it succeeds. If pending sectors is increased, it is a good idea to run `chkdsk /r` on the drive.

Reallocated sector count goes up when the drive has determined a sector is broken, it deactivates the sector and uses a backup sector instead. This is usually a sign of upcoming failure and at this point the HDD is probably on borrowed time. There is only a limited amount of backup sectors so eventually there will be no backup ones left to use. Once the values increases to 1 or more, it tends to go up until point of failure.

When `Raw_Read_Error_Rate` and `Raw_Read_Error_Rate` increase, the drive is not having any issue with sectors, only the standard, modern, data-density `Raw_Read_Error_Rate`.

Make sure the drives have backups.

## Methods ot execute commands in parallel

Below is how different operators work when executing multiple commands in parallel:

```bash
c1 & c2  # Run both commands parallelly
c1 ; c2  # Run both commands one by one
c1 && c2 # Run c2 only if c1 exits successfully
c1 || c2 # Run c2 only if c1 fails
```

## Count files and folders reqursively trough directories

In order to count all the files recursively through directories use the following command:

```bash
sudo find . -maxdepth 1 -type d | while read -r dir do printf "%s:\t" "$dir"; sudo find "$dir" -type f | wc -l; done | sort -n -r -k2
```

The first part: `sudo find . -maxdepth 1 -type d` will return a list of all directories in the current working directory. I used `sudo` to include directories which are not owned by the current user. This is piped to...

The second part: `while read -r dir; do` begins a while loop as long as the pipe coming into the while is open (which is until the entire list of directories is sent). The read command will place the next line into the variable dir. Then it continues...

The third part: `printf "%s:\t" "$dir"` will print the string in `$dir` (which is holding one of the directory names) followed by a colon and a tab (but not a newline).

The fourth part: `sudo find "$dir" -type f` makes a list of all the files inside the directory whose name is held in `$dir`. I used `sudo` to include directories that are not owned by the current user. This list is sent to...

The fifth part: `wc -l` counts the number of lines that are sent into its standard input.

The sixth part: `done` simply ends the while loop. This is piped to...

The final part: `sort -n -r -k2` which compares according to string numerical value(`-n`), reversing the result of the comparison (`-r`) from second filed(`-k2`). This will otput the silt of directories sorted in reverse order by the number of files in them.

So we get a list of all the directories in the current directory. For each of those directories, we generate a list of all the files in it so that we can count them all using `wc -l`. The result will look like:

```bash
./dir1: 2199
./dir2: 23
./dir3: 11
...
```

Here's a compilation of some useful variations of the listing commands:

List folders with file count:

```bash
find -maxdepth 1 -type d | sort | while read -r dir; do n=$(find "$dir" -type f | wc -l); printf "%4d : %s\n" $n "$dir"; done
```

List folders with non-zero file count:

```bash
find -maxdepth 1 -type d | sort | while read -r dir; do n=$(find "$dir" -type f | wc -l); if [ $n -gt 0 ]; then printf "%4d : %s\n" $n "$dir"; fi; done
```

List folders with sub-folder count:

```bash
find -maxdepth 1 -type d | sort | while read -r dir; do n=$(find "$dir" -type d | wc -l); let n--; printf "%4d : %s\n" $n "$dir"; done
```

List folders with non-zero sub-folder count:

```bash
find -maxdepth 1 -type d | sort | while read -r dir; do n=$(find "$dir" -type d | wc -l); let n--; if [ $n -gt 0 ]; then printf "%4d : %s\n" $n "$dir"; fi; done
```

List empty folders:

```bash
find -maxdepth 1 -type d | sort | while read -r dir; do n=$(find "$dir" | wc -l); let n--; if [ $n -eq 0 ]; then printf "%4d : %s\n" $n "$dir"; fi; done
```

List non-empty folders with content count:

```bash
find -maxdepth 1 -type d | sort | while read -r dir; do n=$(find "$dir" | wc -l); 
```
