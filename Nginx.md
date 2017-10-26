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
By default Nginx doesn't start after installing the package, to start it : 
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

If you can access your server through a browser, the installion was successful.

#### Disable the tefault server
We want to deny the acces of the server if you type the ip on your navigator.
To do this we moify the default nginx server configuration.

```bash
sudo vim /etc/nginx/sites-available/default
```

Type this in the file :

```nginx
server {
  listen 80;
  server_name _;
  return 444;
}
```

<div align="center">
<hr>

**Installation steps**

[Previous](php.md) / [Next](mariaDB.md)

</div>