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

```

### Configure ngnix vhost
Create new virtual host `vim /etc/mginx/sites-available/username` then configure it
```nginx
server {
  listen 80;

}
```

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