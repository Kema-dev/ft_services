clear
echo -e "\nstarting server configuration ...\n"

cd ..

echo -e "granting initial access ..."
chown -R root:root /var/www/*
chmod -R 755 /var/www/*
echo -e "initial access granted"

echo -e "adding basic index ..."
mkdir /var/www/mysite && touch /var/www/mysite/index.html
cat /tmp/index.html >> /var/www/mysite/index.html
echo -e "basic index added"

echo -e "adding php proof ..."
touch /var/www/mysite/phpproof.php
echo "<?php phpinfo(); ?>" >> /var/www/mysite/phpproof.php
echo -e "php proof added"

echo -e "creating ssl certificate ..."
openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/ssl/mysite.pem -keyout /etc/ssl/mysite.key -subj "/C=FR/ST=FRANCE/L=Lyon/O=42 School/OU=jjourdan/CN=mysite" &> /dev/null
echo -e "ssl certificate created"

echo -e "configurating nginx ..."
rm -f /etc/nginx/sites-available/default
rm -rf /etc/nginx/sites-enabled/default
cp ./tmp/nginx-conf-off /etc/nginx/sites-available/mysite
ln -s /etc/nginx/sites-available/mysite /etc/nginx/sites-enabled/mysite
echo -e "nginx configurated"

echo -e "configurating phpMyAdmin ..."
mkdir /var/www/mysite/phpmyadmin
cd /tmp/
echo -e "retrieving phpMyAdmin's source"
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz &> /dev/null
echo -e "phpMyAdmin source retrieved"
tar -xvf phpMyAdmin-4.9.0.1-all-languages.tar.gz --strip-components 1 -C ../var/www/mysite/phpmyadmin &> /dev/null
echo -e "phpMyAdmin source uncompressed"
rm -f phpMyAdmin-4.9.0.1-all-languages.tar.gz
mv phpmyadmin.inc.php ../var/www/mysite/phpmyadmin/config.inc.php
echo -e "phpMyAdmin configurated"

echo -e "creating WordPress database ..."
service mysql start
echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;" | mysql -u root --skip-password
echo "update mysql.user set plugin='mysql_native_password' where user='root';" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password
echo -e "WordPress database created"

echo -e "configurating WordPress ..."
echo -e "retrieving WordPress' source"
wget -c https://wordpress.org/latest.tar.gz &> /dev/null
echo -e "WordPress source retrieved"
tar -xvzf latest.tar.gz &> /dev/null
echo -e "WordPress source uncompressed"
rm -f latest.tar.gz
mv wordpress/ /var/www/mysite
mv /tmp/wp-config.php /var/www/mysite/wordpress
echo -e "WordPress configurated"

cd ..

service php7.3-fpm start
service php7.3-fpm status
service nginx reload
service nginx configtest
service nginx start
service nginx status
service mysql status

echo -e "\nserver configuration finished\n"

bash
