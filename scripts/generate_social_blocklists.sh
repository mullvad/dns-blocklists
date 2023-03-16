#!/bin/bash -xe

# This script relies on: https://github.com/guelfoweb/knock
# Install that in a DispVM and run this script from there first
#
# git clone https://github.com/guelfoweb/knock.git
# cd knock
# sudo python3 setup.py install
#
# Ensure the contents of this script are in knock/script.sh before running
#
# Copy to output of /tmp/lists/all to inventory/group_vars/all.yml

rm -rf /tmp/lists
mkdir -p /tmp/lists

for url in \
    snapchat.com \
    sc-cdn.net \
    snap-dev.net \
    snapkit.co \
    snapads.com \
    facebook.com \
    fb.com \
    fbcdn.net \
    instagram.com \
    cdninstagram.com \
    tiktokv.com \
    tiktokcdn.com \
    tiktok.org \
    tiktok.com; \
        do python3 knockpy.py $url --no-local --no-http --silent csv > /tmp/lists/$url.csv && \
            cat /tmp/lists/$url.csv | tr ';' ' ' | sed '/^[[:space:]]*$/d' | awk '{ print "0.0.0.0 " $2 }' > /tmp/lists/$url.txt && \
            cat /tmp/lists/*.txt > /tmp/lists/all;
done