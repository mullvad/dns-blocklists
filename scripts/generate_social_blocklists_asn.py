#!/usr/bin/env python3

import requests

ASNS = [
         'AS32934',  # Facebook
         'AS138699', # Tiktok
         'AS395291', # Snapchat
       ]

def get_networks(asn):
    with requests.get(f'https://asn.ipinfo.app/api/text/list/{asn}') as res:
        networks = res.text.splitlines()
    return networks

def main():
    for asn in ASNS:
        asn_networks = get_networks(asn)
        with open(f'/tmp/{asn}', 'w') as outfile:
            for network in asn_networks:
                net_addr, net_mask = network.split('/')
                rev_net_addr = '.'.join(net_addr.split('.')[::-1])
                outfile.write(f'0.0.0.0 {net_mask}.{rev_net_addr}.rpz.ip\n')


if __name__ == '__main__':
    main()
