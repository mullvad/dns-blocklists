# dns-blocklists

This repository contains the Ansible playbook that we use to generate DNS based blocking files for our Encrypted DNS, and VPN server __(also known as VPN relay)__ based DNS blocking.

This is imported to our VPN servers frequently.

We aim to update these lists on a weekly basis. You can view the latest update by selecting the commits to this repository.

# Why is list "X" not included?

If you find a block list is excluded it is because we have gone through these validation steps:
- The blocklist is an amalgamation of other blocklists.
- The blocklist is no longer maintained.
- The blocklist blocks things we do not believe should be blocked (like our own domains).

We periodically make exceptions to the included URLs for the following reasons:
- The upstream lists are broken and include malformed URLs causing the generation to fail.
- The upstream lists block our domains.

# Using Encrypted DNS on Apple Devices

For convenience we have Apple configuration profiles (.mobileconfig) signed for simpler "one-click installation", or MDM management.

These are available here: https://github.com/mullvad/encrypted-dns-profiles

# Differences between VPN servers and Encrypted DNS

Please note that our Encrypted DNS service includes different hostnames for each option. We currently offer the following:
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
- All:
  - This includes Ad-blocking, Tracker, Malware, Adult content, Gambling and Social Media blocking for TLS and HTTPS. The lists are what are found in this repository.
  - TLS: all.dns.mullvad.net
  - HTTPS: https://all.dns.mullvad.net/dns-query

Note that social media block lists are **not** available on our VPN server block lists, they are **only** available on the Encrypted DNS service.

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


## Pull requests / Issues / Updating block lists

We prefer to not block individual custom URLs or add block lists without them being fully validated and verified first. Please consider pointing us toward a reputable block list prior to making a Github Issue. 

If we close your issue or reject your request, it is most likely down to us not having a way of verifying that the block list is trustworthy.

# Custom DNS entries for use with our VPN service

The following is a list of all the IP addresses we use for our DNS based blocking.

These IPs can be used within custom DNS in our configuration files, or via our Apps.

To block _everything_ enter: `100.64.0.63`

### Ads and Tracker combinations
    100.64.0.1 - Ad blocking only
    100.64.0.2 - Trackers only
    100.64.0.3 - Ad blocking and tracker blocking

### Malware serving website combinations
    100.64.0.4 - Malware blocking only
    100.64.0.5 - Ad blocking and malware blocking
    100.64.0.6 - Tracker blocking and malware blocking
    100.64.0.7 - Ad blocking, tracker blocking and malware blocking

### Adult content blocking combinations
    100.64.0.8 - Adult content blocking only
    100.64.0.9 - Adult content and ad blocking
    100.64.0.10 - Adult content and tracker blocking
    100.64.0.11 - Adult content blocking, ad blocking and tracker blocking
    100.64.0.12 - Adult content blocking and malware blocking
    100.64.0.13 - Adult content blocking, ad blocking and malware blocking
    100.64.0.14 - Adult content blocking, tracker blocking and malware blocking
    100.64.0.15 - Adult content blocking, ad blocking, tracker blocking and malware blocking

### Gambling website combinations
    100.64.0.16 - Gambling blocking only
    100.64.0.17 - Gambling blocking and ad blocking
    100.64.0.18 - Gambling blocking and tracker blocking
    100.64.0.19 - Gambling blocking, ad blocking and tracker blocking
    100.64.0.20 - Gambling blocking and malware blocking
    100.64.0.21 - Gambling blocking ad blocking and malware blocking
    100.64.0.22 - Gambling blocking, malware blocking and tracking blocking
    100.64.0.23 - Gambling blocking, ad blocking, malware blocking and tracker blocking
    100.64.0.24 - Gambling blocking and adult blocking
    100.64.0.25 - Gambling blocking, ad blocking and adult content blocking
    100.64.0.26 - Gambling blocking, adult content blocking, and tracker blocking
    100.64.0.27 - Gambling blocking, ad blocking, adult content blocking and tracker blocking
    100.64.0.28 - Gambling blocking, adult content blocking and malware blocking
    100.64.0.29 - Gambling blocking, ad blocking, adult content blocking, and malware blocking
    100.64.0.30 - Gambling blocking, adult content blocking, malware blocking and tracker blocking
    100.64.0.31 - Ad blocking, adult content blocking, gambling blocking, malware blocking, tracker blocking

### Social media blocking combinations

    100.64.0.32 - Social media only
    100.64.0.33 - Social media and ad blocking
    100.64.0.34 - Social media and tracker blocking
    100.64.0.35 - Social media, ad blocking and tracker blocking
    100.64.0.36 - Social media and malware blocking
    100.64.0.37 - Social media, ad blocking and malware blocking
    100.64.0.38 - Social media, tracker blocking and malware blocking
    100.64.0.39 - Social media, ad blocking, tracker blocking and malware blocking
    100.64.0.40 - Social media and adult content blocking
    100.64.0.41 - Social media, adult content blocking and ad blocking
    100.64.0.42 - Social media, adult content blocking and tracker blocking
    100.64.0.43 - Social media, adult content blocking, ad blocking and tracker blocking
    100.64.0.44 - Social media, adult content blocking and malware blocking
    100.64.0.45 - Social media, adult content blocking, ad blocking and malware blocking
    100.64.0.46 - Social media, adult content blocking, tracker blocking and malware blocking
    100.64.0.47 - Social media, adult content blocking, ad blocking, tracker blocking and malware blocking
    100.64.0.48 - Social media and gambling blocking
    100.64.0.49 - Social media, gambling blocking and ad blocking
    100.64.0.50 - Social media, gambling blocking and tracker blocking
    100.64.0.51 - Social media, gambling blocking, ad blocking and tracker blocking
    100.64.0.52 - Social media, gambling blocking and malware blocking
    100.64.0.53 - Social media, gambling blocking, ad blocking and malware blocking
    100.64.0.54 - Social media, gambling blocking, tracker blocking and malware blocking
    100.64.0.55 - Social media, gambling blocking, ad blocking, tracker blocking and malware blocking
    100.64.0.56 - Social media, gambling blocking and adult blocking
    100.64.0.57 - Social media, gambling blocking, adult content and ad blocking
    100.64.0.58 - Social media, gambling blocking, adult content and tracker blocking
    100.64.0.59 - Social media, gambling blocking, adult content, ad blocking and tracker blocking
    100.64.0.60 - Social media, gambling blocking, adult content, malware blocking
    100.64.0.61 - Social media, gambling blocking, adult content, malware blocking and ad blocking
    100.64.0.62 - Social media, gambling blocking, adult content, malware blocking and tracker blocking
    100.64.0.63 - Social media, gambling blocking, adult content, malware blocking, ad blocking and tracker blocking ("Everything")

# Building

The following steps are useful only if you wish to build the lists yourself.

The output files located in `output/relay/` are what are imported onto our VPN servers.

## Requirements
- Ansible Core 2.14.x =<
- Qubes OS DispVM

## Step by step

  - Ensure the values in `group_vars/<group>.yml` are up to date with any block lists
  - Ensure the values in `scripts/generate_social_blocklists_urls` and `scripts/generate_social_blocklists_asn.py` are up to date (URLs and ASNs)
  - Start a DisposibleVM (dispVM) and `qvm-copy` this repository to it
  - Ensure the script in `scripts/generate_social_blocklists.sh` has been run: `cd scripts/ && ./generate_social_blocklists.sh` in a Disposible VM (dispVM) with the output qvm-copied to files/social (`cp /tmp/social files/social`)
  - Ensure you have added any 'custom' extra lists or websites to block
  - Run the playbook to generate the lists:
    - `ansible-playbook -i inventory/ playbook.yml`
    - `ansible-playbook -i inventory/ playbook.yml --tags=readme` can be used to generate the README on its own
  - View the output (once pushed) at `https://raw.githubusercontent.com/mullvad/dns-blocklists/main/output/<group>.txt?raw=true`
  - Run test script: `cd scripts && ./check_zonedata.sh`
  - Sign the outputted relay files with your GPG code signing key, for example:
    - `for list in adblock adult privacy gambling social; do gpg2 --detach-sign --armor output/relay/relay_${list}.txt > output/relay/relay_${list}.txt.gpg; done && for list in adblock adult privacy gambling social; do gpg2 --detach-sign --armor output/relay/relay_${list}.zone > output/relay/relay_${list}.gpg; done`
  - Verify the outputted GPG signed files, for example:
    - `for list in adblock adult privacy gambling social; do echo "Verify: ${list}" && gpg2 --verify output/relay/relay_${list}.txt.gpg output/relay/relay_${list}.txt; done && for list in adblock adult privacy gambling social; do echo "Verify: ${list}" && gpg2 --verify output/relay/relay_${list}.gpg output/relay/relay_${list}.zone; done`
