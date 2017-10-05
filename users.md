# Configuring new user website
To add a new user on the server, with his ssh user and his mariaDB acces, we nedd a few steps of configuration.

## Creating new user
```bash
adduser username
```
Then complet the information ask by the bash

## Configure php pool
```bash

```

## Configure ngnix vhost
Create new virtual host `vim /etc/mginx/sites-available/username`
```nginx
server {
  listen 80;

}
```

## Create new mariaDB user
```bash
mysql -u root -p
```

```sql
CREATE DATABASE username;
GRANT ALL ON username.* TO username@localhost IDENTIFIED BY 'password';
```