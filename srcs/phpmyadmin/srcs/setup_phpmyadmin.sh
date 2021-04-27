#!/bin/sh
sh setup_nginx.sh
service php-fpm7 start
tail -f /dev/null