# PHP

## PHP 7 fpm
The repositories from debian9 comes by default with php7.
```bash
sudo apt-get install php-fpm
```

## PHP modules
We install a few helpful php modules
```bash
# Module to comuniques with mySQL databases
sudo apt-get install php-mysql
# To work with images in php
sudo apt-get install php-gd
# We always need curl
sudo apt-get install php-curl
```

## Automaticly start PHP-fpm
Just type this to automaticly start php-fpm wen your server starts.
```bash
sudo systemctl enable php7.0-fpm
# IF you dont want to restart your system, type this to start php now.
sudo service php7.0-fpm start
```

<div align="center">
<hr>

**Installation steps**

[< Previous](basetools.md) / [Next >](Nginx.md)

</div>