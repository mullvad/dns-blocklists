#!/bin/bash -euo pipefail

# Script to locate subdomains and generate social blocklists.

# Configuration
OUTPUT_DIR="/tmp/lists"
URL_LIST="generate_social_blocklists_urls"
SUBFINDER_OUTPUT="$OUTPUT_DIR/subfinder"
SOCIAL_OUTPUT="$OUTPUT_DIR/social"

# Ensure subfinder is installed
if ! command -v subfinder &> /dev/null; then
  echo "Error: subfinder is not installed. Please install it."
  exit 1
fi

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Run subfinder and capture output
subfinder -dL "$URL_LIST" --silent > "$SUBFINDER_OUTPUT"

# Generate blocklist entries from subfinder output
awk '{ print "0.0.0.0 " $1 }' "$SUBFINDER_OUTPUT" > "$OUTPUT_DIR/output"

# Generate blocklist entries from URL list
grep -v -e '^#' -e '^$' "$URL_LIST" | while IFS= read -r domain; do
  echo "0.0.0.0 $domain" >> "$OUTPUT_DIR/output"
done

# Run Python script to generate ASN blocklists
python3 generate_social_blocklists_asn.py

# Combine all blocklists into final output
cat "$OUTPUT_DIR/output" /tmp/AS* > "$SOCIAL_OUTPUT"

echo "Social blocklist generated successfully: $SOCIAL_OUTPUT"