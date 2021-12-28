#!/bin/bash -e

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
mkdir -p /usr/lib/node-exporter/textfile
cp $parent_path/configs/checks.sh /usr/lib/node-exporter/checks.sh
chmod a+x /usr/lib/node-exporter/checks.sh
cp $parent_path/configs/test.sh /usr/lib/node-exporter/test.sh
chmod a+x /usr/lib/node-exporter/test.sh
cp $parent_path/configs/node-exporter.cron /etc/cron.d/node-exporter
echo "Install OK"
