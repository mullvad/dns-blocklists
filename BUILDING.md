# Building

The following steps are useful only if you wish to build the lists yourself.

The output files located in `output/relay/` are what are imported onto our VPN servers an hour after upload.

## Requirements
- Ansible Core 2.18.x =<
- Qubes OS DispVM

## Step by step

  - Ensure the values in `group_vars/<group>.yml` are up to date with any blocklists.
  - Ensure the values in `scripts/generate_social_blocklists_urls` and `scripts/generate_social_blocklists_asn.py` are up to date (URLs and ASNs).
  - Start a DisposibleVM (dispVM) and `qvm-copy` this repository to it.
  - Ensure the script in `scripts/generate_social_blocklists.sh` has been run in a DispVM:
    - `cd scripts/ && ./generate_social_blocklists.sh`
    - `qvm-copy /tmp/social`
    - `mv /home/user/QubesIncoming/disp123/social files/social`
  - Ensure you have added any 'custom' extra lists or websites to block.
  - Run the helper build script to generate the lists: `./build`
  - Run the playbook to generate the lists (optional):
    - `ansible-playbook -i inventory/ playbook.yml`
    - `ansible-playbook -i inventory/ playbook.yml --tags=readme` can be used to generate the README on its own.
  - View the output (once pushed) at `https://raw.githubusercontent.com/mullvad/dns-blocklists/main/output/<group>.txt?raw=true`
  - Run test script: `cd scripts && ./check_zonedata.sh`
  - Sign the outputted relay files with your GPG code signing key, for example:
    - `for list in adblock adult privacy gambling social; do gpg2 --detach-sign --armor output/relay/relay_${list}.txt > output/relay/relay_${list}.txt.gpg; done && for list in adblock adult privacy gambling social; do gpg2 --detach-sign --armor output/relay/relay_${list}.zone > output/relay/relay_${list}.gpg; done`
  - Verify the outputted GPG signed files, for example:
    - `for list in adblock adult privacy gambling social; do echo "Verify: ${list}" && gpg2 --verify output/relay/relay_${list}.txt.gpg output/relay/relay_${list}.txt; done && for list in adblock adult privacy gambling social; do echo "Verify: ${list}" && gpg2 --verify output/relay/relay_${list}.gpg output/relay/relay_${list}.zone; done`
