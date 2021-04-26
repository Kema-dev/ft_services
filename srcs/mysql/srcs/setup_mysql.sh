mkdir -p /var/lib/mysql
chmod 777 /var/lib/*

mysql_install_db --user=mysql --datadir=/var/lib/mysql

mkdir -p /run/openrc/
touch /run/openrc/softlevel
openrc sysinit
service mariadb start

echo "CREATE DATABASE wordpress;" | mysql -u root
echo "CREATE USER 'root'@'%' IDENTIFIED BY 'root';" | mysql -u root
echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root

service mariadb stop
chown -R root:root /var/lib/mysql
chmod 777 /var/lib/*
service mariadb start
pkill mysqld
mysqld --user=root --datadir=/var/lib/mysql