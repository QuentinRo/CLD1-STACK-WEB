# MariaDB

> A internet connection is necessary for this installation guide

## Installation Guide

### Before start

update and upgrade your packages
```bash
sudo apt-get update
sudo apt-get upgrade
```
### MariaDB installation

Import key and add repository (key need dirmgr and repository need software-properties-common).
We need to acces by the port 80 because the default port 11371 is blocked

Key :
* Debian 8 : 0xcbcb082a1bb943db
* Debian 9 : 0xF1656F24C74CD1D8

```bash
sudo apt-get install software-properties-common dirmngr
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
sudo add-apt-repository 'deb [arch=amd64,i386,ppc64el] http://mirror.host.ag/mariadb/repo/10.2/debian stretch main'
```

Install MariaDB
```bash
sudo apt-get update
sudo apt-get install mariadb-server mariadb-client
```

The installation ask a new password for the MariaDB "root" user, set it to :
```bash
root
```

Now add it to the bootom of your /etc/apt/sources.list
```
# MariaDB 10.2 repository list
# http://downloads.mariadb.org/mariadb/repositories/
deb [arch=amd64,i386,ppc64el] http://mariadb.kisiek.net/repo/10.2/debian stretch main
deb-src http://mariadb.kisiek.net/repo/10.2/debian stretch main
```

