#!/bin/bash -e

USERS=$(who | wc -l)
APT_CHECK=$(/usr/lib/update-notifier/apt-check 2>&1 || echo "0;0")
UPDATES=$(echo "$APT_CHECK" | cut -d ';' -f 1)
SECURITY=$(echo "$APT_CHECK" | cut -d ';' -f 2)
REBOOT=$([ -f /var/run/reboot-required ] && echo 1 || echo 0)

echo "# HELP node_current_users Current user count."
echo "# TYPE node_current_users gauge"
echo "node_current_users ${USERS}"

echo "# HELP apt_upgrades_pending Apt package pending updates by origin."
echo "# TYPE apt_upgrades_pending gauge"
echo "apt_upgrades_pending ${UPDATES}"

echo "# HELP apt_security_upgrades_pending Apt package pending security updates by origin."
echo "# TYPE apt_security_upgrades_pending gauge"
echo "apt_security_upgrades_pending ${SECURITY}"

echo "# HELP node_reboot_required Node reboot is required for software updates."
echo "# TYPE node_reboot_required gauge"
echo "node_reboot_required ${REBOOT}"
