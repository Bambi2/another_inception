#!bin/sh
if [ ! -f "/var/www/wp-config.php" ]; then
cat << EOF > /var/www/wp-config.php
<?php
define( 'DB_NAME', 'wordpress' );
define( 'DB_USER', '${USERNAME}' );
define( 'DB_PASSWORD', '${MARIADB_USER_PWD}' );
define( 'DB_HOST', '${MARIADB_HOST}' );
require_once ABSPATH . 'wp-settings.php';
EOF
fi