#!/bin/bash

ts=`date '+%Y%m%d_%H%M%S'`


# create backup folder
mkdir -p backup_${ts}
mkdir -p backup_${ts}/etc
mkdir -p backup_${ts}/etc/default
mkdir -p backup_${ts}/etc/hostapd
mkdir -p backup_${ts}/etc/udev
mkdir -p backup_${ts}/etc/udev/rules.d

if [ -L last_backup ]; then
    unlink last_backup
fi
ln -s backup_${ts} last_backup

#backup existing config
cp /etc/rc.local backup_${ts}/etc/
cp /etc/dhcpcd.conf backup_${ts}/etc/
cp /etc/hostapd/hostapd.conf backup_${ts}/etc/hostapd/
cp /etc/dnsmasq.conf backup_${ts}/etc/
cp /etc/default/hostapd backup_${ts}/etc/default/
if [ -f /etc/udev/rules.d/72-wlan.rules ]; then
    cp /etc/udev/rules.d/72-wlan.rules backup_${ts}/etc/udev/rules.d/
fi

# copy udef rule to force onboard as wlan9
cp ./etc/udev/rules.d/72-wlan.rules /etc/udev/rules.d/72-wlan.rules

# copy dhcp server config
# default raspi wlan0 (wifi usb dongle) IP = 192.168.220.1/24
cp ./etc/dnsmasq.conf /etc/dnsmasq.conf

# copy default to enable hostapd
cp ./etc/default/hostapd /etc/default/hostapd

# copy hostapd config
# default access point interface is wlan0 
cp ./etc/hostapd/hostapd.conf /etc/hostapd/hostapd.conf


# copy new dhcpcd.conf to disable dhcp and wpa_supplicant from wifi dongle wlan0
# if eth0 is not connected or does not receive dhcp, it will have default IP 192.168.119.1/24
cp ./etc/dhcpcd.conf /etc/dhcpcd.conf


# copy startup script
cp ./etc/access_point.sh /etc/access_point.sh
chmod +x /etc/access_point.sh


# update rc.local to call our startup script
grep "access_point.sh" /etc/rc.local
res=$?
if [ $res -eq 0 ]; then
    echo "rc.local has access_point.sh already. skipping this step"
else
    sed -i 's/^exit 0/\/etc\/access_point\.sh\n\nexit 0/' /etc/rc.local
fi


