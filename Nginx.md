# Nginx

## Nginx Installation on a Debian distribution

In this guide I will be using the "sudo" command which may not be installed in every distribution of Debian.

### Install the basic package

First, we will need to update the apt packages installer
```bash
sudo apt-get update
```
Then we can install the Nginx package
```bash
sudo apt-get install nginx
```
By default Nginx doesnd't start after installing the package, to start it : 
```bash
sudo nginx start
```
To test that nginx is running, open a browser and go on localhost:80 and the default welcome Nginx page should show up.

### Nginx Files

#### Server Configuration Files
* /etc/nginx: The Nginx configuration directory, all configuration files are stored there.
* /etc/nginx/nginx.conf: Global configuration file.
* /etc/nginx/sites-available/: Directory where the configuration files for the different websites will reside.
* /etc/nginx/sites-enabled/: This directory will enable or disable the configuration files in the sites-available directory
* /etc/nginx/snippets: This directory contains fragments of configuration that can be used in configuration files. Useful to store basic configurations.
#### Server Logs  
* /var/log/nginx/access.log: Every request to the Nginx server will be logged in this file, unless you configure the configuration file of Nginx.
* /var/log/nginx/error.log: Any Nginx error will be recorded in this log file.

Now that the server is installed, we can start to configure ir.

### Nginx Configuration
Before going into this step, php-fpm pools should be configured (at least for one site).

First we're going to create a new file in the "sites-available" directory. We're going to use "app1" as an example.

```bash
sudo vi /etc/nginx/sites-available/app1
```
Note : The editor used doesn't matter
~~~bash
server {
       listen 80;

       server_name app1.com;

       root /usr/share/nginx;
       index index.php index.html;

       location / {
               try_files $uri $uri/ =404;
       }

       location ~ \.php$ {
           try_files $uri =404;
           
       }
}

}
~~~



