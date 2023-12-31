#!bin/sh
#set -eux

# sql commands to create user, update adming password and create wordpress database
# TODO: add permissions of wordpress db to username
cat << EOF > /tmp/init.sql
USE mysql;
FLUSH PRIVILEGES;
DELETE FROM mysql.user WHERE User='';
DROP DATABASE test;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PWD}';
CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER '${USERNAME}'@'%' IDENTIFIED by '${MARIADB_USER_PWD}';
FLUSH PRIVILEGES;
EOF

# run sql script
/usr/bin/mysqld --user=mysql --bootstrap < /tmp/init.sql
rm -f /tmp/init.sql