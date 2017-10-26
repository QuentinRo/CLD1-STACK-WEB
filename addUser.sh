#!/bin/bash

echo
echo
echo "Enter the new username : "
read username
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
        echo "Canceled !"
        echo
else
        adduser --disabled-password --gecos "" $username
        echo $username":"$password|chpasswd
        chown -R $username:$username /home/$username

        '
        echo << toEnd
        "["$username"]"
        "user = "$username
        "group = "$username
        "listen = /var/run/php7.0-fpm-site1.sock"
        "listen.owner = www-data"
        "listen.group = www-data"
        "php_admin_value[disable_functions] = exec,passthru,shell_exec,system"
        "php_admin_flag[allow_url_fopen] = off"
        "pm = dynamic"
        "pm.max_children = 5"
        "pm.start_servers = 2"
        "pm.min_spare_servers = 1"
        "pm.max_spare_servers = 3"
        "chdir = /"
        toEnd
        '

        touch /tmp.sql
        echo "CREATE DATABASE DB_"$username";" > /tmp.sql
        echo "GRANT ALL ON DB_"$username".* TO "$username"@localhost IDENTIFIED BY '"$password"';" >> /tmp.sql

        mysql -u "root" -p$rootpwd < /tmp.sql

        echo
        echo "Sucessfull !"
        echo
fi

