# Configuring new user website
To add a new user on the server, with his ssh user and his mariaDB acces, we nedd a few steps of configuration.
To do this configuration quickly, we created a .sh script. This script will automaticaly create the user and all the neded configuration.
If you **dont want** to use this script we can manualy do the configuration following the next steps.

## Using the .sh Script
Just launch the addUser.sh as root, and follow the steps.
The best way to use this .sh file on your system is to clone this repo on our home directory.
```bash
# go tou our directory
cd ~~
# clone the repo
git clone https://github.com/bastiennicoud/CLD1-STACK-WEB.git
# move into the freshly cloned repo
cd CLD1-STACK-WEB
# launch the addUser.sh script
./addUser.sh
```

## Manualy configure the user
### Creating new user
First we create a new user, the command will ask you a few question about the user.
```bash
adduser username
```

### Configure php pool
Here we create a new php pool dedicatet to the new user
```bash
sudo vim /etc/php5/fpm/pool.d/app1.conf
```

And type this in the file
```conf
[app1]
user = app1
group = app1
listen = /var/run/php7.0-fpm-site1.sock
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
```

### Nginx virtualhost Configuration
Now that the php-fpm pools was created, we can configure the Nginx Virtualhost.

First we're going to create a new file in the "sites-available" directory. We're going to use "app1" as an example.

```bash
sudo vi /etc/nginx/sites-available/app1
```
Note : The editor used doesn't matter
~~~nginx
server {
       listen 80;

       server_name app1.com;

       root /usr/directory;
       index index.php index.html;

       location / {
               try_files $uri $uri/ /index.php;
       }

       location ~ \.php$ {
           try_files $uri =404;
           fastcgi_index index.php;
           fastcgi_pass unix:/var/run/php7-fpm-app1.sock;
        fastcgi_param SCRIPT_FILENAME            $document_root$fastcgi_script_name;
        include fastcgi_params;
       }
}
~~~
This configuration is a basic Virtual Host for a site.</br>
The different elements
* root: The source directory for sources files.
* server_name: The name of the application. We'll use this name to access it.
* fastcgi_pass: This is the PHP pool that was previously created.

Now that the configuration file for "app1" is ready, to enable it, we'll have to create a link in the directory "sites-enabled".
```bash
sudo ln -s /etc/nginx/sites-available/app1 /etc/nginx/sites-enabled/app1
```

Restart the Nginx server and the virtual should be up and running.

### Create new mariaDB user
First connect you to mariaDB
```bash
mysql -u root -p
```

Then create new database and user
```sql
CREATE DATABASE username;
GRANT ALL ON username.* TO username@localhost IDENTIFIED BY 'password';
```