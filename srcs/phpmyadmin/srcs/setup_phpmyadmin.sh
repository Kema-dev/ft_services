#clear
echo -e "\nstarting nginx configuration ...\n"
cd ..

echo -e "granting initial access ..."
chown -R root:root /var/www /var/lib/nginx
chmod -R 755 /var/www
echo -e "initial access granted"

echo -e "adding basic index ..."
mkdir /var/www/mysite
cat /tmp/index.html > /var/www/mysite/index.html
rm -rf /var/www/localhost
echo -e "basic index added"

echo -e "adding php proof ..."
touch /var/www/mysite/phpproof.php
echo "<?php phpinfo(); ?>" >> /var/www/mysite/phpproof.php
echo -e "php proof added"

echo -e "creating ssl certificate ..."
openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/ssl/mysite.pem -keyout /etc/ssl/mysite.key -subj "/C=FR/ST=FRANCE/L=Lyon/O=42 School/OU=jjourdan/CN=mysite" &> /dev/null
echo -e "ssl certificate created"


echo -e "configurating nginx ..."
mkdir -p /etc/nginx/sites-available/mysite/ /etc/nginx/sites-enabled/mysite /var/run/nginx/ /etc/nginx/snippets/
touch /var/run/nginx/nginx.pid
cat /tmp/fastcgi-php.conf > /etc/nginx/snippets/fastcgi-php.conf
cat /tmp/nginx.conf > /etc/nginx/nginx.conf
ln -s /etc/nginx/sites-available/mysite /etc/nginx/sites-enabled/mysite
echo -e "nginx configurated"

echo -e "configurating phpMyAdmin ..."
apk add php-mysqli
mv usr/share/webapps/phpmyadmin var/www/mysite/phpmyadmin
cat tmp/phpmyadmin.inc.php > etc/phpmyadmin/config.inc.php
echo -e "phpMyAdmin configurated"

php-fpm7
nginx -t
nginx

echo -e "If you want to print real-time server logs : tail -f /var/log/nginx/access.log /var/log/nginx/error.log"

ash
#tail -f /var/log/nginx/access.log /var/log/nginx/error.log
