#!/bin/bash

authorised=("wj")
ports=(23 25 53 139 445 3389 1433 1434 3306)

users=$(users)
IFS=' ' read -ra ADDR <<< "$users"
unid=0
vuln=0

for i in "${ADDR[@]}"; do
  isUnid=1
  for j in ${authorised[@]}; do
    if [ "$i" = $j ]; then
      ((isUnid=0))
      break
    fi
  done

  if [ $isUnid -eq 1 ]; then
    ((unid=unid+1))
  fi
done

for x in ${ports[@]}; do
  result=$(nc -z -w 3 localhost $x; echo $?)
  if [ $result -eq 0 ]; then
    ((vuln=vuln+1))
  fi
done

echo "# HELP node_unid_users Unidentified users."
echo "# TYPE node_unid_users gauge"
echo node_unid_users ${unid}

echo "# HELP node_vuln_ports No. of vulnerable ports."
echo "# TYPE node_vuln_ports gauge"
echo node_vuln_ports ${vuln}
