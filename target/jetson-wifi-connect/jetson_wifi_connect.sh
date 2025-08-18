#!/bin/bash -e

SSID=$1
PASSWORD=$2

if [ -z "$SSID" ] || [ -z "$PASSWORD" ]; then
	echo "Usage: $0 <SSID> <PASSWORD>"
	exit 1
fi

sudo nmcli r wifi on

NMCLI_OUTPUT=$(sudo nmcli d wifi connect "$SSID" password "$PASSWORD")
DEVICE=$(echo "$NMCLI_OUTPUT" | grep -oP "Device '\K[^']+")

if [ -z "$DEVICE" ]; then
	echo "Could not determine device name from nmcli output."
	exit 2
fi

echo "Successfully connected to WiFi ($SSID) on device $DEVICE."
echo "Checking internet connectivity..."

if ping -w 5 google.com > /dev/null; then
	echo "Successful connection"
	echo "Device IP:"
	ip -4 addr show dev "$DEVICE" | grep -oP '(?<=inet\s)\d+(\.\d+){3}'
else
	echo "Connection failed"
fi