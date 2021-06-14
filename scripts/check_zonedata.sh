#!/usr/bin/env bash

if ! command -v named-checkzone &> /dev/null
then
  echo "named-checkzone is not installed"
  echo "This is required to run this script and is installed as part of the bind-utils package"
  exit
fi

for list in ../output/relay/*
  do
    echo "### $list"
    temp_filename=$(basename "$list")
    cat <<EOF > "$temp_filename"
\$TTL    604800
@       IN      SOA     ns.example.com. root.example.com. (
                           1337         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@	IN	NS	ns.example.com.
EOF
    while read -r hostname
    do
      echo "$hostname IN CNAME ." >> "$temp_filename"
      done < "$list"
      named-checkzone "$temp_filename" "$temp_filename"
      rm "$temp_filename"
      echo ""
  done
