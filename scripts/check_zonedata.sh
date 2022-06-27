#!/usr/bin/env bash

set -e # Will make script fail if there is an error

if ! command -v named-checkzone &> /dev/null
then
  echo "named-checkzone is not installed"
  echo "This is required to run this script and is installed as part of the bind-utils package"
  exit
fi

echo "[#] Checking hostlists.."
for hostlist in ../output/{doh,relay}/*.txt
  do
    echo "[#] $hostlist"
    temp_filename=$(basename "$hostlist")
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
      done < "$hostlist"
      named-checkzone $(basename --suffix=.txt $temp_filename) $temp_filename
      rm "$temp_filename"
  done

echo ""
echo "[#] Checking zonefiles.."
for zonefile in ../output/{doh,relay}/*.zone
  do
    echo "[#] $zonefile"
    named-checkzone $(basename --suffix=.zone $zonefile) $zonefile
  done
