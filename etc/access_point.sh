
#!/bin/bash

ext_wlan_if="wlan9"
ext_eth_if="eth0"
ap_subnet="192.168.220.0/24"
ap_local_ip="192.168.220.1/24"
ap_wlan_if="wlan0"

/sbin/iptables -P FORWARD ACCEPT

/sbin/iptables -t nat -A POSTROUTING -o ${ext_eth_if} -s ${ap_subnet} -j MASQUERADE
/sbin/iptables -t nat -A POSTROUTING -o ${ext_wlan_if} -s ${ap_subnet} -j MASQUERADE


/sbin/ip a add  ${ap_local_ip} dev ${ap_wlan_if}

systemctl stop hostapd
systemctl start hostapd

sleep 2

systemctl stop dnsmasq.service
systemctl start dnsmasq.service


