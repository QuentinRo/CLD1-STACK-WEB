#!/bin/bash
# This script will automaticaly create a new user and configure his web stack

# creating the new users

# configuring a new php pool

# configuring new php vhost

# creating new mariaDB user and database
echo "Enter the DB name :"
read DBName
echo "Enter the username :"
read username
echo "Enter the user password :"
read -s password

touch /tmp.sql
echo "CREATE DATABASE "$DBName";" > /tmp.sql
echo "GRANT ALL ON "$DBName".* TO "$username"@localhost IDENTIFIED BY '"$password"';" >> /tmp.sql

mysql -u root -p < /tmp.sql