#!/bin/sh

RELAY_CONFIG=/etc/tor/torrc

echo $RELAY_EXPERT

if [ -z "$RELAY_EXPERT" ] ; then
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
		export RELAY_PORT=443
	fi
	if [ -z "$RELAY_ADDRESS" ] ; then
		echo -n "ORPort $RELAY_PORT" >> $RELAY_CONFIG
	else
		echo "OutboundBindAddress $RELAY_ADDRESS" >> $RELAY_CONFIG
		echo -n "ORPort $RELAY_ADDRESS:$RELAY_PORT" >> $RELAY_CONFIG
	fi
	if [ "$RELAY_IPV4_ONLY" -eq 1 ] ; then
		echo " IPv4Only" >> $RELAY_CONFIG
	else
		echo "" >> $RELAY_CONFIG
	fi

	if [ -z "$RELAY_EXIT" ] || [ "$RELAY_EXIT" -eq 0 ] ; then
		echo "ExitRelay 0" >> $RELAY_CONFIG
	else
		echo "ExitRelay 1" >> $RELAY_CONFIG
	fi

	if [ -z "$RELAY_BANDWIDTH" ] ; then
		echo "Relay bandwidth not set!"
	else
		echo "BandwidthBurst $RELAY_BANDWIDTH" >> $RELAY_CONFIG
	fi
	if [ -z "$RELAY_TRANSFER" ] ; then
		echo "Relay transfer not set!"
	else
		echo "BandwidthRate $RELAY_TRANSFER" >> $RELAY_CONFIG
	fi

	if [ -n "$RELAY_MAXMEM" ] ; then
		echo "MaxMemInQueues $RELAY_MAXMEM" >> $RELAY_CONFIG
	fi

	if [ -n "$RELAY_FAMILY" ] ; then
		echo "MyFamily $RELAY_FAMILY" >> $RELAY_CONFIG
	fi

	echo "SocksPort 0" >> $RELAY_CONFIG
	echo "Log notice stdout" >> $RELAY_CONFIG
	echo "ControlPort 9051" >> $RELAY_CONFIG
	echo "User tor" >> $RELAY_CONFIG
	echo "DataDirectory /home/tor/tor-data" >> $RELAY_CONFIG
elif ! [ -f "$RELAY_CONFIG" ] ; then
	echo "ERROR: RELAY_EXPERT variable set but no config provided at"
	     "$RELAY_CONFIG"
	exit 1
fi

chown -R tor:tor /home/tor/tor-data
tor
