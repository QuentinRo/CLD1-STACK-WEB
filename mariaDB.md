# MariaDB
## Installation Guide


Import key and add repository (key need dirmgr and repository need software-properties-common)

```sh
sudo apt-get install software-properties-common dirmngr
sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xF1656F24C74CD1D8
sudo add-apt-repository 'deb [arch=amd64,i386,ppc64el] http://mirror.host.ag/mariadb/repo/10.2/debian stretch main'
```

Install MariaDB
```sh
sudo apt-get update
sudo apt-get install mariadb-server
```