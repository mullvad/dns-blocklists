# dns-adblock

This repository contains the Ansible playbook that we use to generate the ad and tracker blocking files for our DNS over TLS, and relay based DNS blocking.

This is imported to our VPN servers frequently.

## Requirements
- Ansible 2.9.x =<

## Step by step

  - Ensure the values in `group_vars/<group>.yml` are up to date with any ad-block lists
  - Ensure you have added any 'custom' extra lists or websites to block
  - Run the playbook: `ansible-playbook -i inventory/ playbook.yml`
  - View the output (once pushed) at `https://raw.githubusercontent.com/mullvad/dns-adblock/main/output/<group>.txt?raw=true`
  - Run test script: `cd scripts && ./check_zonedata.sh`

## Pull requests / Issues / Updating block lists

We really welcome your feedback for lists to use for blocking! We cannot action them all individually, but we will read them. This is an actively worked on project and we **will** take into consideration all of your requests, even if we do not reply to them.
