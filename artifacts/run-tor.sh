#!/bin/sh

RELAY_CONFIG=/etc/tor/torrc

rm $RELAY_CONFIG

if [ -z "$RELAY_NICKNAME" ] ; then
	echo "No relay nickname set!"
else
	echo "Nickname $RELAY_NICKNAME" >> $RELAY_CONFIG
fi

if [ -z "$RELAY_CONTACT" ] ; then
	echo "No relay contact set!"
else
	echo "ContactInfo $RELAY_CONTACT" >> $RELAY_CONFIG
fi

if [ -z "$RELAY_PORT" ] ; then
	echo -n "ORPort 443" >> $RELAY_CONFIG
else
	echo -n "ORPort $RELAY_PORT" >> $RELAY_CONFIG
fi
if [ "$IPV4_ONLY" -eq 1 ] ; then
	echo " IPv4Only" >> $RELAY_CONFIG
else
	echo "" >> $RELAY_CONFIG
fi

if [ -z "$RELAY_EXIT" ] || [ "$RELAY_EXIT" -eq 0 ] ; then
	echo "ExitRelay 0" >> $RELAY_CONFIG
else
	echo "ExitRelay 1" >> $RELAY_CONFIG
fi

echo "SocksPort 0" >> $RELAY_CONFIG
echo "Log notice stdout" >> $RELAY_CONFIG
echo "DataDirectory /var/lib/tor/data" >> $RELAY_CONFIG
echo "ControlPort 9051" >> $RELAY_CONFIG
echo "User tor" >> $RELAY_CONFIG
echo "DataDirectory /home/tor/tor-data" >> $RELAY_CONFIG

if [ -z "$RELAY_BANDWIDTH" ] ; then
	echo "Relay bandwidth not set!"
else
	echo "BandwidthRate $RELAY_BANDWIDTH" >> $RELAY_CONFIG
	echo "BandwidthBurst $RELAY_BANDWIDTH" >> $RELAY_CONFIG
fi

chown -R tor:tor /home/tor/tor-data
tor
