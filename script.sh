#! /bin/bash

cp -n /home/snmpd.conf /usr/local/etc/snmp
/usr/local/sbin/snmpd -Lo -f
#top -b
