# dns-adblock

This repository contains the Ansible playbook that we use to generate the ad and tracker blocking files for our DNS over TLS / DNS over HTTPS, and VPN server __(also known as VPN relay)__ based DNS blocking.

This is imported to our VPN servers frequently.

# Lists

The following lists are what we import to our service. You can find these defined in `inventory/group_vars` for the server type you wish to view.

- `doh`: DNS over HTTPS / DNS over TLS
- `relay`: VPN servers (relays)

### Trackers

We currently use these tracker blocklists with our service:
- easylist-privacy: https://justdomains.github.io/blocklists/lists/easyprivacy-justdomains.txt
- windows-spy-blocker-spy: https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/master/data/hosts/spy.txt

### Advertising

We currently use these advertising blocklists with our service:
- easylist-adblock: https://v.firebog.net/hosts/Easylist.txt
- adaway: https://adaway.org/hosts.txt
- AdguardDNS: https://v.firebog.net/hosts/AdguardDNS.txt
- Admiral: https://v.firebog.net/hosts/Admiral.txt
- anudeepND: https://raw.githubusercontent.com/anudeepND/blacklist/master/adservers.txt
- yoyo: https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext
- frellwits-swedish-hosts-file: https://raw.githubusercontent.com/lassekongo83/Frellwits-filter-lists/master/Frellwits-Swedish-Hosts-File.txt
- AdguardDNS-mobile-ads: https://raw.githubusercontent.com/r-a-y/mobile-hosts/master/AdguardMobileAds.txt

### Adult content 

We currently use this Adult content blocklist for our service:
- blocklistproject-adult: https://raw.githubusercontent.com/blocklistproject/Lists/master/alt-version/porn-nl.txt

## Pull requests / Issues / Updating block lists

We really welcome your feedback for lists to use for blocking! We cannot action them all individually, but we will read them. This is an actively worked on project and we **will** take into consideration all of your requests, even if we do not reply to them.

# Building

The following steps are useful only if you wish to build the lists yourself.

The output files located in `output/relay/` are what are imported onto our VPN servers.

## Requirements
- Ansible 2.9.x =<

## Step by step

  - Ensure the values in `group_vars/<group>.yml` are up to date with any ad-block lists
  - Ensure you have added any 'custom' extra lists or websites to block
  - Run the playbook: `ansible-playbook -i inventory/ playbook.yml`
  - View the output (once pushed) at `https://raw.githubusercontent.com/mullvad/dns-adblock/main/output/<group>.txt?raw=true`
  - Run test script: `cd scripts && ./check_zonedata.sh`
  - Sign the outputted relay files with your GPG code signing key, for example:
    - `gpg2 --detach-sign --armor output/relay/relay_adblock.txt > output/relay/relay_adblock.txt.gpg`
    - `gpg2 --detach-sign --armor output/relay/relay_privacy.txt > output/relay/relay_privacy.txt.gpg`
  - Verify the outputted GPG signed files, for example:
    - `gpg2 --verify output/relay/relay_adblock.txt.gpg output/relay/relay_adblock.txt`
    - `gpg2 --verify output/relay/relay_privacy.txt.gpg output/relay/relay_privacy.txt`
