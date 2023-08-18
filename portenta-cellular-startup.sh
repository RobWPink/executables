#!/bin/sh

modemNum=$(mmcli -L | sed -n 's/^.*\/Modem\/\(.\).*/\1/p')
result=$(mmcli -m $modemNum --simple-connect='apn=hologram,ip-type=ipv4')
if [[ $result != *"successfully"* ]]; then
  echo "Unable to bring modem online"
  exit
fi
bearerNum=$(mmcli -m $modemNum | sed -n 's/^.*Bearer.*\/Bearer\/\(.*\).*/\1/p')
interface=$(mmcli -m $modemNum --bearer=$bearerNum | sed -n 's/^.*interface: \(.*\).*$/\1/p')
ipaddr=$(mmcli -m $modemNum --bearer=$bearerNum | sed -n 's/^.*address: \(.*\).*$/\1/p')
dns1=$(mmcli -m $modemNum --bearer=$bearerNum | sed -n 's/^.*dns: \(.*\).*$/\1/p')
dns2=$(echo $dns1 | sed -n 's/^.*,\(.*\).*$/\1/p')
dns1=$(echo $dns1 | sed -n 's/^\(.*\),.*$/\1/p')
mtuNum=$(mmcli -m $modemNum --bearer=$bearerNum | sed -n 's/^.*mtu: \(.*\).*$/\1/p')
sudo ip link set $interface up
sudo ip addr add $ipaddr/32 dev $interface
sudo ip link set dev $interface arp off
sudo ip link set dev $interface mtu $mtuNum
sudo ip route add default dev $interface metric 200
sudo sh -c "echo 'nameserver $dns1' >> /etc/resolv.conf"
sudo sh -c "echo 'nameserver $dns2' >> /etc/resolv.conf"
