#!/bin/sh
if [ ! -f /conf/aria2.conf ]; then
	cp /conf-copy/aria2.conf /conf/aria2.conf
	if [ $SECRET ]; then
		echo "rpc-secret=${SECRET}" >> /conf/aria2.conf
	fi
fi

mkdir /data/.aria2
touch /data/.aria2/aria2.session

nginx -g "daemon off;" &
aria2c --conf-path=/conf/aria2.conf
