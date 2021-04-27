#!/bin/sh
mkdir -p /www
mkdir -p /run/nginx
adduser -D -g 'www' www
chown -R www:www /var/lib/nginx
chown -R www:www /www

openssl req -x509 -nodes -days 365 -subj "/C=FR/ST=RHONE/L=Lyon/O=Kemadev/CN=kema_nginx" -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt

mkdir -p /run/openrc/
touch /run/openrc/softlevel
openrc sysinit
service nginx start
tail -f /dev/null
#telegraf conf