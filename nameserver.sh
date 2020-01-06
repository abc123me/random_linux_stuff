#!/bin/sh

while true; do
	echo >/etc/resolv.conf
	for ns in $@; do
		echo "nameserver $ns" >>/etc/resolv.conf
	done
	sleep 0.25
done
