#!/bin/bash
# This script will automaticaly create a new user and configure his web stack

# creating the new users

# configuring a new php pool

# configuring new php vhost

# creating new mariaDB user and database
touch /tmp.sql
echo "CREATE DATABASE "$1";" > /tmp.sql
echo "GRANT ALL ON "$1".* TO "$1"@localhost IDENTIFIED BY '"$2"';" >> /tmp.sql

mysql -u root -p < /tmp.sql