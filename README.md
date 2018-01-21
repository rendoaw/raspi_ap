# Simple and dumb script to use raspi 3 + wifi dongle as portable access point


## Requirements

* Raspi 3
* Raspbian stretch 
    * may work on other raspbian but not tested
* one usb wifi dongle
    * so far, i always use Edimax EW-7811Un 802.11n Wireless Adapter


## Overview

* eth0 as wired uplink interface (if available)
    * if eth0 has no cbale connected, or no dhcp offer is received, the interface will have default IP = 192.168.119.1/24
* onboard wifi as wireless uplink interface (if configured and can connect to uplink access point)
    * this onboard wifi interface will be renamed as wlan9 interface
* at least one usb wifi dongle is plugged and recognized by raspi (raspbian)
    * the usb wifi dongle will be identified as wlan0, or wlan1,wlan2,... (if there are more than one usb wifi dongle)
    * wlan0 will be configured as access point with the following default value:
        * ssid: pluto
        * passphrase: isitaplanet
        * subnet: 192.168.220.0/24
* NAT will be enabled by default on 192.168.220.0/24 subnet


## To Do

* use GPIO pin to "select operation mode" based on jumper connected to it:
    * disable/enable NAT 
    * disable/enable AP 
    * disable/enable AP mode on onboard wifi and/or onboard eth
    * ...




