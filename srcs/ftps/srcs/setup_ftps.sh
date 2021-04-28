#!/bin/sh

mkdir -p /run/openrc/
touch /run/openrc/softlevel
openrc sysinit

openssl req -x509 -nodes -days 365 -subj "/C=FR/ST=RHONE/L=Lyon/O=Kemadev/CN=kema_ftps" -newkey rsa:2048 -keyout /etc/ssl/private/ftps-selfsigned.key -out /etc/ssl/certs/ftps-selfsigned.crt

mkdir -p /etc/vsftpd/
mv vsftpd.conf /etc/vsftpd/vsftpd.conf
echo -e "anonymous\n" > /etc/vsftpd/user_list

service vsftpd start

tail -f /dev/null