echo -e "\nstarting nginx configuration ...\n"

cd ..

echo -e "granting initial access ..."
chown -R root:root /var/www/*
chmod -R 755 /var/www/*
echo -e "initial access granted"

echo -e "adding basic index ..."
mkdir /var/www/mysite
cat /tmp/index.html > /var/www/mysite/index.html
echo -e "basic index added"

echo -e "adding php proof ..."
touch /var/www/mysite/phpproof.php
echo "<?php phpinfo(); ?>" >> /var/www/mysite/phpproof.php
echo -e "php proof added"

echo -e "adding openrc softlevel ..."
openrc
touch /run/openrc/softlevel
chmod 755 /run/openrc/softlevel
service nginx start
service nginx configtest
echo -e "openrc softlevel added"

echo -e "creating ssl certificate ..."
openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/ssl/mysite.pem -keyout /etc/ssl/mysite.key -subj "/C=FR/ST=FRANCE/L=Lyon/O=42 School/OU=jjourdan/CN=mysite" &> /dev/null
echo -e "ssl certificate created"

echo -e "configurating nginx ..."
echo -e "$PWD"
mv ./tmp/nginx.conf /etc/nginx/sites-available/mysite
ln -s /etc/nginx/sites-available/mysite /etc/nginx/sites-enabled/mysite
rm -rf /etc/nginx/sites-enabled/default
echo -e "nginx configurated"

service nginx reload
service nginx restart
service nginx status

ash
