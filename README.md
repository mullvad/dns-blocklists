# dns-blocklists

This repository contains the Ansible playbook that we use to generate DNS based blocking files for our Encrypted DNS, and VPN server __(also known as VPN relay)__ based DNS blocking.

We aim to update these lists every Monday through Thursday. You can view the latest update by selecting the commits to this repository.

After updating the lists, it will take about an hour for all our servers to pick up the updated lists.

For example: list updated at 07:00 will be *made available* at the latest 09:00 on the same day. There is however a cache present on our servers which means it might not be actively used immediately.

## Pull requests / Issues / Updating block lists

We prefer to not block individual custom URLs or add block lists without them being fully validated and verified first.

Please consider pointing us toward a reputable block list prior to making a Github Issue. 

If we close your issue or reject your request, it is most likely down to us not having a way of verifying that the block list is trustworthy.

# Custom DNS entries for use with our VPN service

All combinations of DNS content blockers can be found in the [COMBINATIONS.md](COMBINATIONS.md) file.

# Lists

The following lists are what we import to our service. You can find these defined in `inventory/group_vars` for the server type you wish to view.

- `doh`: Encrypted DNS servers
- `relay`: VPN servers (relays)

### Trackers

We currently use these tracker blocklists with our service:
- firebog-easylist-privacy: https://v.firebog.net/hosts/Easyprivacy.txt
- hagezi-tracker-amazon: https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/domains/native.amazon.txt
- hagezi-tracker-apple: https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/domains/native.apple.txt
- hagezi-tracker-huawei: https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/domains/native.huawei.txt
- hagezi-tracker-windows: https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/domains/native.winoffice.txt
- hagezi-tracker-tiktok-aggressive: https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/domains/native.tiktok.extended.txt
- hagezi-tracker-webos: https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/domains/native.lgwebos.txt
- hagezi-tracker-vivo: https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/domains/native.vivo.txt
- hagezi-tracker-oppo: https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/domains/native.oppo-realme.txt
- hagezi-tracker-xiamomi: https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/domains/native.xiaomi.txt
- mullvad-tracker-blocklist: custom file

### Advertising

We currently use these advertising blocklists with our service:
- oisd-small: https://small.oisd.nl/rpz
- frellwits-swedish-hosts-file: https://raw.githubusercontent.com/lassekongo83/Frellwits-filter-lists/master/Frellwits-Swedish-Hosts-File.txt
- AdguardDNS: https://v.firebog.net/hosts/AdguardDNS.txt
- hagezi-popupads-onlydomains: https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/wildcard/popupads-onlydomains.txt
- mullvad-ads-blocklist: custom file

### Adult content 

We currently use this Adult content blocklist for our service:
- oisd-nsfw: https://nsfw.oisd.nl/rpz

### Gambling

We currently use these gambling blocklists with our service:
- hagezi-gambling-onlydomains: https://raw.githubusercontent.com/hagezi/dns-blocklists/main/wildcard/gambling-onlydomains.txt
- hagezi-gambling: https://raw.githubusercontent.com/hagezi/dns-blocklists/main/wildcard/gambling.txt

### Social media

We generate our Social Media block lists from scripts located in `scripts/`

You can find the generated file in `files/social`

### Malware

We currently use this malware content blocklist for our service:
- urlhaus: https://urlhaus.abuse.ch/downloads/hostfile
- hagezi-threat-intelligence-mini: https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/rpz/tif.mini.txt

# Why is list "X" not included?

If you find a block list is excluded it is because we have gone through these validation steps:
- The blocklist is an amalgamation of other blocklists.
- The blocklist is no longer maintained.
- The blocklist blocks things we do not believe should be blocked (like our own domains).

We periodically make exceptions to the included URLs for the following reasons:
- The upstream lists are broken and include malformed URLs causing the generation to fail.
- The upstream lists block our domains.
- You can view exceptions in `inventory/group_vars/all.yml` under the name of `dns_blocklists_exclude`,
  these are split per-blocklist.

# Using Encrypted DNS on Apple Devices

For convenience we have Apple configuration profiles (.mobileconfig) signed for simpler "one-click installation", or MDM management.

These are available here: https://github.com/mullvad/encrypted-dns-profiles

# Differences between VPN servers and Encrypted DNS

Our Encrypted DNS service includes different hostnames for each option. We currently offer the following:

- Vanilla:
  - This includes zero blocking, purely encrypted DNS for TLS and HTTPs.
  - TLS: dns.mullvad.net
  - HTTPS: https://dns.mullvad.net/dns-query
- Ad-block:
  - This includes Ad-blocking and Tracker blocking for TLS and HTTPS. The lists are what are found in this repository.
  - TLS: adblock.dns.mullvad.net
  - HTTPS: https://adblock.dns.mullvad.net/dns-query
- Base:
  - This includes Ad-blocking, Tracker, and Malware blocking for TLS and HTTPS. The lists are what are found in this repository.
  - TLS: base.dns.mullvad.net
  - HTTPS: https://base.dns.mullvad.net/dns-query  
- Extended:
  - This includes Ad-blocking, Tracker, Malware and Social Media blocking for TLS and HTTPS. The lists are what are found in this repository.
  - TLS: extended.dns.mullvad.net
  - HTTPS: https://extended.dns.mullvad.net/dns-query
- Family:
  - This includes Ad-blocking, Tracker, Malware, Adult content and Gambling blocking for TLS and HTTPS. The lists are what are found in this repository.
  - TLS: family.dns.mullvad.net
  - HTTPS: https://family.dns.mullvad.net/dns-query
- All:
  - This includes Ad-blocking, Tracker, Malware, Adult content, Gambling and Social Media blocking for TLS and HTTPS. The lists are what are found in this repository.
  - TLS: all.dns.mullvad.net
  - HTTPS: https://all.dns.mullvad.net/dns-query

# Building

Information for building these blocklists has been moved to [BUILDING.md](BUILDING.md).
