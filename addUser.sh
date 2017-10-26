#!/bin/bash

# Demande les infos a l'utilisateur
echo -e "\033[32m\033[1m"
echo "------------------------------------------------------"
echo "This his the automatic user configuration script !"
echo "Follow the instructions !"
echo -e "\033[0m"

echo 
echo "Enter the new username : "
read username
echo

echo 
echo "Enter the new domain name of this site : "
read domain
echo

echo "Enter the new username password : "
read -s password
echo

echo "Enter the mysql root password : "
read -s rootpwd
echo

read -p "Are you sure (y/n) ? " -n 1 -r
echo

if [[ ! $REPLY =~ ^[Yy]$ ]]
then
  echo
  echo -e "\033[33m"
  echo "Canceled !"
  echo -e "\033[0m"
  echo
else

echo -e "\033[33m"

# ajoute un utilisateur
adduser --disabled-password --gecos "" $username
echo $username":"$password|chpasswd

# Add phpinfo in the www site of the user
mkdir /home/$username/www
cat > /home/$username/www/index.php <<TEXTBLOCK
<?php
phpinfo();
TEXTBLOCK

chown -R $username:$username /home/$username
chmod -R 4770 /home/$username


# crée un pool php

cat > /etc/php/7.0/fpm/pool.d/$username.conf <<TEXTBLOCK
[$username]
user = $username
group = $username
listen = /var/run/php7.0-fpm-$username.sock
listen.owner = www-data
listen.group = www-data
php_admin_value[disable_functions] = exec,passthru,shell_exec,system
php_admin_flag[allow_url_fopen] = off
pm = dynamic
pm.max_children = 5
pm.start_servers = 2
pm.min_spare_servers = 1
pm.max_spare_servers = 3
chdir = /
TEXTBLOCK



# config nginx

cat > /etc/nginx/sites-available/$username <<TEXTBLOCK
server {
  listen 80;

  server_name $domain;

  root /home/$username/www;
  index index.php index.html;

  location / {
    try_files \$uri \$uri/ /index.php;
  }

  location ~ \.php$ {
    try_files \$uri =404;
    fastcgi_index index.php;
    fastcgi_pass unix:/var/run/php7-fpm-$username.sock;
    fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
    include fastcgi_params;
  }
}
TEXTBLOCK

ln -s /etc/nginx/sites-available/$username /etc/nginx/sites-enabled/$username



# utilisateur mariaDB
echo "CREATE DATABASE DB_"$username";" > /tmp.sql
echo "GRANT ALL ON DB_"$username".* TO "$username"@localhost IDENTIFIED BY '"$password"';" >> /tmp.sql

mysql -u "root" -p$rootpwd < /tmp.sql


# Restart nginx/php
echo "Reloading configs !"
service nginx reload
service php7.0-fpm reload


# Little sucess message
echo
echo -e "\033[32m"
echo "Sucessfull !"
echo -e "\033[0m"
echo

fi