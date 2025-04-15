#!/usr/bin/env python3

import requests
import ipaddress
import os

ASNS = [
    'AS32934',  # Facebook
    'AS138699', # Tiktok
    'AS395291', # Snapchat
]

API_URL = 'https://asn.ipinfo.app/api/text/list/{}'
OUTPUT_DIR = '/tmp'

def get_networks(asn):
    """Fetches network prefixes for a given ASN."""
    try:
        response = requests.get(API_URL.format(asn), timeout=10)
        response.raise_for_status()  # Raise HTTPError for bad responses (4xx or 5xx)
        networks = response.text.splitlines()
        return networks
    except requests.exceptions.RequestException as e:
        print(f"Error fetching networks for {asn}: {e}")
        return []

def generate_rpz_entry(network_prefix):
    """Generates an RPZ entry from a network prefix."""
    try:
        network = ipaddress.ip_network(network_prefix, strict=False)
        net_addr_reversed = '.'.join(reversed(str(network.network_address).split('.')))
        net_mask = str(network.prefixlen)
        return f'0.0.0.0 {net_mask}.{net_addr_reversed}.rpz.ip\n'
    except ValueError as e:
        print(f"Error processing network prefix {network_prefix}: {e}")
        return None

def main():
    """Main function to process ASNs and generate RPZ files."""
    if not os.path.exists(OUTPUT_DIR):
        try:
            os.makedirs(OUTPUT_DIR)
        except OSError as e:
            print(f"Error creating output directory {OUTPUT_DIR}: {e}")
            return

    for asn in ASNS:
        asn_networks = get_networks(asn)
        if asn_networks:
            output_file = os.path.join(OUTPUT_DIR, asn)
            with open(output_file, 'w') as outfile:
                for network in asn_networks:
                    rpz_entry = generate_rpz_entry(network)
                    if rpz_entry:
                        outfile.write(rpz_entry)
            print(f"Successfully generated RPZ file for {asn}")
        else:
            print(f"Skipping {asn} due to network retrieval errors.")

if __name__ == '__main__':
    main()
