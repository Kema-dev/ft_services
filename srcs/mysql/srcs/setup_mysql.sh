mysql_install_db --user=mysql --datadir=/var/lib/mysql

mkdir -p /run/openrc/
touch /run/openrc/softlevel
openrc sysinit
service mariadb start

echo "CREATE DATABASE wordpress;" | mysql -u root
echo "CREATE USER 'root'@'%' IDENTIFIED BY 'root';" | mysql -u root
echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root

service mariadb restart
sh