#!/bin/sh

mkdir -p /run/openrc/
touch /run/openrc/softlevel
openrc sysinit
service vsftpd start

mkdir -p /etc/vsftpd/

tail -f /dev/null