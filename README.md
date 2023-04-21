# dns-adblock

This repository contains the Ansible playbook that we use to generate the ad and tracker blocking files for our DNS over TLS / DNS over HTTPS, and VPN server __(also known as VPN relay)__ based DNS blocking.

This is imported to our VPN servers frequently.

We aim to update these lists on a weekly basis. You can view the latest update by selecting the commits to this repository.

# Differences between VPN servers and DNS over TLS / HTTPS

Please note that our DNS over TLS and DNS over HTTPS offerings only include ad blocking and tracker blocking.

There will be improvements to add parity between the lists in the future. 

Note that social media block lists are **not** available on our VPN server block lists, they are **only** available on the Encrypted DNS service.

# Lists

The following lists are what we import to our service. You can find these defined in `inventory/group_vars` for the server type you wish to view.

- `doh`: DNS over HTTPS / DNS over TLS
- `relay`: VPN servers (relays)

### Trackers

We currently use these tracker blocklists with our service:
- firebog-easylist-privacy: https://v.firebog.net/hosts/Easyprivacy.txt
- windows-spy-blocker-spy: https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/master/data/hosts/spy.txt
- perflyst-android-tracking: https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/android-tracking.txt
- telemetry-alexa: https://raw.githubusercontent.com/nextdns/native-tracking-domains/main/domains/alexa
- telemetry-apple: https://raw.githubusercontent.com/nextdns/native-tracking-domains/main/domains/apple
- telemetry-huawei: https://raw.githubusercontent.com/nextdns/native-tracking-domains/main/domains/huawei
- telemetry-samsung: https://raw.githubusercontent.com/nextdns/native-tracking-domains/main/domains/samsung
- telemetry-sonos: https://raw.githubusercontent.com/nextdns/native-tracking-domains/main/domains/sonos
- telemetry-windows: https://raw.githubusercontent.com/nextdns/native-tracking-domains/main/domains/windows
- telemetry-xiaomi: https://raw.githubusercontent.com/nextdns/native-tracking-domains/main/domains/xiaomi

### Advertising

We currently use these advertising blocklists with our service:
- oisd-small: https://dbl.oisd.nl/small/
- frellwits-swedish-hosts-file: https://raw.githubusercontent.com/lassekongo83/Frellwits-filter-lists/master/Frellwits-Swedish-Hosts-File.txt

### Adult content 

We currently use this Adult content blocklist for our service:
- pornography-hosts: https://raw.githubusercontent.com/Sinfonietta/hostfiles/master/pornography-hosts

### Gambling

We currently use these gambling blocklists with our service:
- blocklist-project: https://raw.githubusercontent.com/blocklistproject/Lists/master/alt-version/gambling-nl.txt

### Social media

We currently generate our own Social media blocklists. You can find all the URLs in `inventory/group_vars/all.yml`

### Malware

We currently use this malware content blocklist for our service:
- urlhaus: https://urlhaus.abuse.ch/downloads/hostfile


## Pull requests / Issues / Updating block lists

We really welcome your feedback for lists to use for blocking! We cannot action them all individually, but we will read them. This is an actively worked on project and we **will** take into consideration all of your requests, even if we do not reply to them. 

We prefer to not block individual custom URLs or add block lists without them being fully validated and verified first. Please consider pointing us toward a reputable block list prior to making a Github Issue. 

If we close your issue or reject your request, it is most likely down to us not having a way of verifying that the block list is trustworthy.

# Custom DNS entries

The following is a list of all the IP addresses we use for our DNS based blocking.

These IPs can be used within custom DNS in our configuration files, or via our Apps.

To block _everything_ enter: `100.64.0.31`

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
    100.64.0.31 - Ad blocking, adult content blocking, gambling blocking, malware blocking, tracker blocking ("Everything")

# Building

The following steps are useful only if you wish to build the lists yourself.

The output files located in `output/relay/` are what are imported onto our VPN servers.

## Requirements
- Ansible Core 2.12.x =<

## Step by step

  - Ensure the values in `group_vars/<group>.yml` are up to date with any block lists
  - Ensure you have added any 'custom' extra lists or websites to block
  - Run the playbook to generate the lists:
    - `ansible-playbook -i inventory/ playbook.yml`
    - `ansible-playbook -i inventory/ playbook.yml --tags=readme` can be used to generate the README on its own
  - View the output (once pushed) at `https://raw.githubusercontent.com/mullvad/dns-adblock/main/output/<group>.txt?raw=true`
  - Run test script: `cd scripts && ./check_zonedata.sh`
  - Sign the outputted relay files with your GPG code signing key, for example:
    - `for list in adblock adult privacy gambling social; do gpg2 --detach-sign --armor output/relay/relay_${list}.txt > output/relay/relay_${list}.txt.gpg; done && for list in adblock adult privacy gambling social; do gpg2 --detach-sign --armor output/relay/relay_${list}.zone > output/relay/relay_${list}.gpg; done`
  - Verify the outputted GPG signed files, for example:
    - `for list in adblock adult privacy gambling social; do echo "Verify: ${list}" && gpg2 --verify output/relay/relay_${list}.txt.gpg output/relay/relay_${list}.txt; done && for list in adblock adult privacy gambling social; do echo "Verify: ${list}" && gpg2 --verify output/relay/relay_${list}.gpg output/relay/relay_${list}.zone; done`
