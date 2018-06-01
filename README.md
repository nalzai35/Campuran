# Campuran

### catatan 1
```sh
mysqldump -u root namadb > db.sql

rsync -avz -e "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" --progress  /var/www/ root@173.222.222.222:/var/www/

mysql -u root -p -h localhost namadb < db2.sql

chown -R www-data:www-data htdocs

service mysql info
mysqld_safe --skip-grant-tables > /dev/null 2>&1 &
mysql -u root -e "use mysql; update user set password=PASSWORD('gantipassword') where User='root'; flush privileges;"
service mysql restart

nano /etc/mysql/conf.d/my.cnf

ee secure --auth
```
