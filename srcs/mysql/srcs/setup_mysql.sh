clear
echo -e "\nstarting mysql configuration ...\n"
cd ..

echo -e "granting initial access ..."
chown -R root:root /var/www/*
chmod -R 755 /var/www/*
echo -e "initial access granted"

echo -e "creating WordPress database ..."
service mysql start
echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;" | mysql -u root --skip-password
echo "update mysql.user set plugin='mysql_native_password' where user='root';" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password
echo -e "WordPress database created"

php-fpm7
