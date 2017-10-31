# MariaDB installation

Install MariaDB
```bash
# Install MariaDB
sudo apt-get install mariadb-server
```
After that, you have to start the secure installation :
```bash
# Runs the secure installation
sudo mysql_secure_installation
```
This will ask you some questions :
- Change the root password? **Yes**
- Enter your root password for MariaDB
- Remove anonymous users? **Yes**
- Disallow root login remotely? **no** (This is best for security)
- Remove test database and access to it? **Yes**
- Reload privilege tables now? **Yes**

<div align="center">
<hr>

**Installation steps**

[< Previous](Nginx.md) / [Next >](users.md)

</div>