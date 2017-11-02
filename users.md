# Configuring new user website
To add a new user on the server, with his ssh user and his mariaDB acces, we need a few steps of configuration.
To do this configuration quickly, we created a .sh script. This script will automaticaly create the user and all the needed configuration.
If you **dont want** to use this script we can manualy do the configuration following the steps a little lower.

## Using the .sh Script
Just launch the **addUser.sh as root**, and follow the steps.
The best way to use this .sh file on your system is to clone this repo on our home directory.
```bash
# go tou our directory
cd ~
# clone the repo
git clone https://github.com/bastiennicoud/CLD1-STACK-WEB.git
# move into the freshly cloned repo
cd CLD1-STACK-WEB
# launch the addUser.sh script
bash addUser.sh
```

## Manualy configure the user
In this tuto, we will use this example infos for our new user :
- Username : **site1**
- Password : **site1**
- Domain : **site1.ch**

### Creating new user
First we create a new user, the command will ask you a few question about the user.
```bash
# adds the user
adduser site1
# additional config
chown -R site1:site1 /home/site1
chmod -R 4770 /home/site1
```

Add a new www directory in the home diretory of the new user :
```bash
mkdir /home/site1/www
```

### Configure php pool
Here we create a new php pool dedicated to the new user :
```bash
sudo vim /etc/php/7.0/fpm/pool.d/site1.conf
```

And type this in the file :
```conf
[site1]
user = site1
group = site1
listen = /var/run/php7.0-fpm-site1.sock
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
```

Now, restart php
```bash
sudo service php7.0-fpm restart
```

### Nginx virtualhost Configuration
Now that the php-fpm pool was created, we can configure the Nginx Virtualhost.

First we're going to create a new file in the "sites-available" directory of the Nginx directory.

```bash
sudo vim /etc/nginx/sites-available/site1
```

After that, we add the nginx sites config :

```nginx
server {
  listen 80;

  server_name site1.ch;

  root /home/site1/www;
  index index.php index.html;

  location / {
    try_files $uri $uri/ /index.php;
  }

  location ~ \.php$ {
    try_files $uri =404;
    fastcgi_index index.php;
    fastcgi_pass unix:/var/run/php7.0-fpm-site1.sock;
    fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    include fastcgi_params;
  }
}
```

This configuration is a basic Virtual Host for a site.  
The different elements
- **root:** The source directory for sources files.
- **server_name:** The name of the application. We'll use this name to access it.
- **fastcgi_pass:** This is the socket where the previously configured php pool listen.

Now that the configuration file for "site1" is ready, to enable it, we'll have to create a link in the directory "sites-enabled".
```bash
sudo ln -s /etc/nginx/sites-available/site1 /etc/nginx/sites-enabled/site1
```

Restart the Nginx server and the virtual should be up and running.
```bash
sudo service nginx restart
```

### Create new mariaDB user
First connect you to mariaDB
```bash
mysql -u root -p
```

Then create a new database and user
```sql
CREATE DATABASE username;
GRANT ALL ON site1.* TO site1@localhost IDENTIFIED BY 'password';
```

<div align="center">
<hr>

**Installation steps**

[Home](README.md)

</div>