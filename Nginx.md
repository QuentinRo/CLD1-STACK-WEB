# NGINX

### Install the basic package

We'll start by installing the Nginx package
```bash
sudo apt-get install nginx
```
By default Nginx doesn't start after installing the package, to start it : 
```bash
sudo service nginx start
```
To test that nginx is running, open a browser and go on serverIp:80 and the default welcome Nginx page should show up.
> Use `ip addr` to get the ip of our server.

### Nginx Files

Some infos about the config files of nginx

#### Server Configuration Files
* `/etc/nginx`: The Nginx configuration directory, all configuration files are stored there.
* `/etc/nginx/nginx.conf`: Global configuration file.
* `/etc/nginx/sites-available/`: Directory where the configuration files for the different websites will reside.
* `/etc/nginx/sites-enabled/`: This directory will enable or disable the configuration files in the sites-available directory
* `/etc/nginx/snippets`: This directory contains fragments of configuration that can be used in configuration files. Useful to store basic configurations.
#### Server Logs  
* `/var/log/nginx/access.log`: Every request to the Nginx server will be logged in this file, unless you configure the configuration file of Nginx.
* `/var/log/nginx/error.log`: Any Nginx error will be recorded in this log file.


### Disable the default server
We want to deny the acces of the server if you type the ip on your navigator.
To do this we moify the default nginx server configuration.

```bash
sudo vim /etc/nginx/sites-available/default
```

Clear the file, and type this in the file :

```nginx
server {
  listen 80 default_server;
  server_name _;
  return 444;
}
```

Then restart the nginx server with :
```bash
sudo service nginx restart
```

<div align="center">
<hr>

**Installation steps**

[< Previous](php.md) / [Next >](mariaDB.md)

</div>