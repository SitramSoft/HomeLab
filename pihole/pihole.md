# piHole - All-around DNS solution server

## piHole - VM configuration

## piHole - OS Configuration

The following subsections from [Common](../general/general.md#common) section should be performed in this order:

- [SSH configuration](../general/general.md#ssh-configuration)
- [Ubuntu - Synchronize time with chrony](../general/general.md#ubuntu---synchronize-time-with-chrony)
- [Update system timezone](../general/general.md#update-system-timezone)
- [Correct DNS resolution](../general/general.md#correct-dns-resolution)
- [Generate Gmail App Password](../general/general.md#generate-gmail-app-password)
- [Configure Postfix Server to send email through Gmail](../general/general.md#configure-postfix-server-to-send-email-through-gmail)
- [Mail notifications for SSH dial-in](../general/general.md#mail-notifications-for-ssh-dial-in)

## piHole - Setup

Run the following command to install [PiHole](https://docs.pi-hole.net/)

```bash
curl -sSL https://install.pi-hole.net | bash
```

## piHole - Unbound as a recursive DNS server

Install `Unbound` by using the following command:

```bash
sudo apt install unbound -y
```

Download the current root hints file (the list of primary root servers which are serving the domain `.` - the root domain). Update it roughly every six months.

```bash
wget https://www.internic.net/domain/named.root -qO- | sudo tee /var/lib/unbound/root.hints
sudo chown unbound:unbound root.hints 
```

Create pi-hole configuration for for `unbound`

```bash
sudo nano -w /etc/unbound/unbound.conf.d/pi-hole.conf
```

Add the following configuration:

```bash
server:
    # If no logfile is specified, syslog is used
    chroot: ""
    logfile: "/var/log/unbound/unbound.log"
    verbosity: 0
    use-syslog: yes

    interface: 127.0.0.1
    port: 5335
    do-ip4: yes
    do-udp: yes
    do-tcp: yes

    # May be set to yes if you have IPv6 connectivity
    do-ip6: no

    # You want to leave this to no unless you have *native* IPv6. With 6to4 and
    # Terredo tunnels your web browser should favor IPv4 for the same reasons
    prefer-ip6: no

    # Use this only when you downloaded the list of primary root servers!
    # If you use the default dns-root-data package, unbound will find it automatically
    #root-hints: "/var/lib/unbound/root.hints"

    # Trust glue only if it is within the server's authority
    harden-glue: yes

    # Require DNSSEC data for trust-anchored zones, if such data is absent, the zone becomes BOGUS
    harden-dnssec-stripped: yes

    # Don't use Capitalization randomization as it known to cause DNSSEC issues sometimes
    # see https://discourse.pi-hole.net/t/unbound-stubby-or-dnscrypt-proxy/9378 for further details
    use-caps-for-id: no

    # Reduce EDNS reassembly buffer size.
    # IP fragmentation is unreliable on the Internet today, and can cause
    # transmission failures when large DNS messages are sent via UDP. Even
    # when fragmentation does work, it may not be secure; it is theoretically
    # possible to spoof parts of a fragmented DNS message, without easy
    # detection at the receiving end. Recently, there was an excellent study
    # >>> Defragmenting DNS - Determining the optimal maximum UDP response size for DNS <<<
    # by Axel Koolhaas, and Tjeerd Slokker (https://indico.dns-oarc.net/event/36/contributions/776/)
    # in collaboration with NLnet Labs explored DNS using real world data from the
    # the RIPE Atlas probes and the researchers suggested different values for
    # IPv4 and IPv6 and in different scenarios. They advise that servers should
    # be configured to limit DNS messages sent over UDP to a size that will not
    # trigger fragmentation on typical network links. DNS servers can switch
    # from UDP to TCP when a DNS response is too big to fit in this limited
    # buffer size. This value has also been suggested in DNS Flag Day 2020.
    edns-buffer-size: 1232

    # Perform prefetching of close to expired message cache entries
    # This only applies to domains that have been frequently queried
    prefetch: yes

    # One thread should be sufficient, can be increased on beefy machines. In reality for most users running on small networks or on a single machine, it should be unnecessary to seek performance enhancement by increasing num-threads above 1.
    num-threads: 1

    # Ensure kernel buffer is large enough to not lose messages in traffic spikes
    so-rcvbuf: 1m

    # Ensure privacy of local IP ranges
    private-address: 192.168.0.0/16
    private-address: 169.254.0.0/16
    private-address: 172.16.0.0/12
    private-address: 10.0.0.0/8
    private-address: fd00::/8
    private-address: fe80::/10

    # This attempts to reduce latency by serving the outdated record before
    # updating it instead of the other way around. Alternative is to increase
    # cache-min-ttl to e.g. 3600.
    cache-min-ttl: 0
    serve-expired: yes
    # I had best success leaving this next entry unset.
    # serve-expired-ttl: 3600 # 0 or not set means unlimited (I think)

    # Use about 2x more for rrset cache, total memory use is about 2-2.5x
    # total cache size. Current setting is way overkill for a small network.
    # Judging from my used cache size you can get away with 8/16 and still
    # have lots of room, but I've got the ram and I'm not using it on anything else.
    # Default is 4m/4m
    msg-cache-size: 128m
    rrset-cache-size: 256m

    #local-zone: "local." static
    #local-data: "win10.local IN A 192.168.0.104"
```

Create log dir and file, set permissions:

```bash
sudo mkdir -p /var/log/unbound
sudo touch /var/log/unbound/unbound.log
sudo chown unbound /var/log/unbound/unbound.log
```

On modern Debian/Ubuntu-based Linux systems, you'll also have to add an AppArmor exception for this new file so unbound can write into it.

Create (or edit if existing) the file `/etc/apparmor.d/local/usr.sbin.unbound` and append

```bash
/var/log/unbound/unbound.log rw,
```

Reload AppArmor using:

```bash
sudo apparmor_parser -r /etc/apparmor.d/usr.sbin.unbound
sudo service apparmor restart
```

Start your local recursive server and test that it's operational:

```bash
sudo service unbound restart
dig pi-hole.net @127.0.0.1 -p 5335
```

The first query may be quite slow, but subsequent queries, also to other domains under the same TLD, should be fairly quick.

Disable `resolvconf.conf` entry for unbound (Required for Debian Bullseye+ releases)

Check if the service is enabled fby running the following command. It will show either `active` or `inactive` or it might not even be installed resulting in a `could not be found` message:

```bash
systemctl is-active unbound-resolvconf.service
```

To disable the service, run the statement below:

```bash
sudo systemctl disable --now unbound-resolvconf.service
```

Disable the file `resolvconf_resolvers.conf` from being generated when resolvconf is invoked elsewhere.

```bash
sudo sed -Ei 's/^unbound_conf=/#unbound_conf=/' /etc/resolvconf.conf
sudo rm /etc/unbound/unbound.conf.d/resolvconf_resolvers.conf
```

Restart `unbound`

```bash
sudo service unbound restart
```

## piHole - Local DNS configuration

Configure Pi-hole to use the recursive DNS server by specifying `127.0.0.1#5335` as the Custom DNS (IPv4) in `Settings->DNS->Upstream DNS Servers->Custom 1(IPv4)`. Make sure everything else is deactivated.

Map the following local dns entires:

```bash
adi                                 192.168.0.4
adi_father_phone.local              192.168.0.15
adi_father_phone_extender.local     192.168.0.16
adi_phone.local                     192.168.0.9
adiw                                192.168.0.5
android.local                       192.168.0.111
archlinux.local                     192.168.0.105
authelia.local                      192.168.0.101
baby_monitor.local                  192.168.0.13
baby_monitor_extender.local         192.168.0.14
chromecast.local                    192.168.0.39
clima_dormitor.local                192.168.0.247
clima_living.local                  192.168.0.248
clima_masterbedroom.local           192.168.0.246
code.local                          192.168.0.113
firewall.local                      192.168.0.1
gate.local                          192.168.0.243
ha.local                            192.168.0.100
hercules.local                      192.168.0.101
ispy.local                          192.168.0.8
kali.local                          192.168.0.112
linux.local                         192.168.0.106
mint.local                          192.168.0.110
nextcloud.local                     192.168.0.102
oli_phone.local                     192.168.0.11
oli_phone_extender.local            192.168.0.12
oneplus_6t_extender.local           192.168.0.10
pad.local                           192.168.0.10
paradox.local                       192.168.0.3
pihole.local                        192.168.0.103
printer.local                       192.168.0.233
repeater.local                      192.168.0.37
router.local                        192.168.0.36
serenity.local                      192.168.0.2
sonoff_dormitor.local               192.168.0.245
sonoff_living.local                 192.168.0.244
storage.local                       192.168.0.114
tableta_sabrina.local               192.168.0.13
termostat.local                     192.168.0.243
test-server1.local                  192.168.0.107
test-server2.local                  192.168.0.108
test-server3.local                  192.168.0.109
tv_alb.local                        192.168.0.40
tv_living_wired.local               192.168.0.41
tv_living_wireless.local            192.168.0.38
vacuum.local                        192.168.0.249
win.local                           192.168.0.104
wordpress.local                     192.168.0.115
work_adi_wired.local                192.168.0.7
work_adi_wireless.local             192.168.0.6
work_oli.local                      192.168.0.46
```
