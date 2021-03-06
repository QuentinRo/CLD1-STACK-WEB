#!/bin/bash

# Message de bienvenue sur le script
echo -e "\033[1;32m"
cat <<TEXTBLOCK
--------------------------------------------------------------
      This his the automatic user configuration script !
 He create new user and the related config for his Web stack.
                  Follow the instructions !
--------------------------------------------------------------
            	 _      _
            	| |    (_)
            	| |     _  _ __   _   _ __  __
            	| |    | || '_ \ | | | |\ \/ /
            	| |____| || | | || |_| | >  <
            	\_____/|_||_| |_| \__,_|/_/\_\
        	______                                _
        	| ___ \                              | |
        	| |_/ /  ___  __      __  ___  _ __  | |
        	|  __/  / _ \ \ \ /\ / / / _ \| '__| | |
        	| |    | (_) | \ V  V / |  __/| |    |_|
        	\_|     \___/   \_/\_/   \___||_|    (_)

--------------------------------------------------------------
TEXTBLOCK
echo -e "\033[0m"

# Demande les différentes infos a l'utilisateur
echo -e "\033[1m"
echo "Enter the new username : "
echo -e "\033[0m"
read username

echo -e "\033[1m"
echo "Enter the domain name for this site : "
echo -e "\033[0m"
read domain
echo

echo -e "\033[1m"
echo "Enter the new username password : "
echo -e "\033[0m"
read -s password
echo

echo -e "\033[1m"
echo "Enter the actual mysql root password : "
echo -e "\033[0m"
read -s rootpwd
echo

echo -e "\033[1m"
read -p "Are you sure (y/n) ? " -n 1 -r
echo -e "\033[0m"
echo

# Si la réponse est négative, le script est coupé
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
  echo
  echo -e "\033[1;33m"
cat <<TEXTBLOCK
--------------------------------------------------------------
                          CANCELED !
--------------------------------------------------------------
TEXTBLOCK
  echo -e "\033[0m"
  echo
else

echo -e "\033[34m"

# ajoute un utilisateur
adduser --disabled-password --gecos "" $username
echo $username":"$password|chpasswd

# Add little php homepage on the future user repertory
echo "- Configuring website repertory"
mkdir /home/$username/www

echo "- Adding homepage with phpinfo"
cat > /home/$username/www/index.php <<TEXTBLOCK
<div style="text-align: center;">
  <h1>Welcome to our new website !</h1>
  <h3>domain: $domain // username: $username</h3>
  <hr>
</div>

<?php
  phpinfo();
TEXTBLOCK


# Configure rights for the user
echo "- Configuring user rights"
chown -R $username:$username /home/$username
chmod -R 4770 /home/$username

# adds nginx user to the group
usermod -a -G $username www-data


# create php pool
echo "- Configuring php pool"
cat > /etc/php/7.0/fpm/pool.d/$username.conf <<TEXTBLOCK
[$username]
user = $username
group = $username
listen = /var/run/php7.0-fpm-$username.sock
listen.owner = www-data
listen.group = www-data
php_admin_value[disable_functions] = exec,passthru
php_admin_flag[allow_url_fopen] = off
pm = dynamic
pm.max_children = 5
pm.start_servers = 2
pm.min_spare_servers = 1
pm.max_spare_servers = 3
chdir = /
TEXTBLOCK



# config nginx
echo "- Configuring nginx"
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
    fastcgi_pass unix:/var/run/php7.0-fpm-$username.sock;
    fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
    include fastcgi_params;
  }
}
TEXTBLOCK

# enable the new site
ln -s /etc/nginx/sites-available/$username /etc/nginx/sites-enabled/$username



# utilisateur mariaDB
echo "- Creating database"
echo "CREATE DATABASE DB_"$username";" > /tmp.sql
echo "GRANT ALL ON DB_"$username".* TO "$username"@localhost IDENTIFIED BY '"$password"';" >> /tmp.sql

mysql -u "root" -p$rootpwd < /tmp.sql


# Restart nginx/php
echo "- Reloading configs"
service nginx reload
service php7.0-fpm reload
echo "- Config reloaded"


# Little sucess message
echo -e "\033[1;32m"
cat <<TEXTBLOCK
--------------------------------------------------------------
                  User sucessfuly created !
                         Enjoy your work !
--------------------------------------------------------------
                    Username : $username
                    Password : ***
                 Domain Name : $domain
                SQL Database : DB_$username

     You can use your identifiers to copy files into your
            dedicated repertory with CP over SSH
--------------------------------------------------------------
TEXTBLOCK
echo -e "\033[0m"

fi
