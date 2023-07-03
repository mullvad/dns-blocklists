#!/bin/bash -xe
# 
# This script uses subfinder to locate all subdomains associated with a URL
#
# Copy to output of /tmp/lists/output to files/social

sudo dnf -y install subfinder
rm -rf /tmp/lists
mkdir -p /tmp/lists

subfinder -dL generate_social_blocklists_urls --silent | \
    tee -a /tmp/lists/subfinder && \
    cat /tmp/subfinder | \
    awk '{ print "0.0.0.0 " $1 }' > /tmp/lists/output