#!/usr/bin/env bash

#Instalar apache
yum install -y httpd

#Instalar mariadb
yum install mariadb-server -y

#Instalar php-mysql
yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum -y install yum-utils
yum-config-manager --enable remi-php70
yum -y install php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo
yum -y install php-xml php-mbstring

#activando apache
systemctl enable httpd
systemctl start httpd

#activando mariadb
systemctl enable mariadb
systemctl start mariadb

#wget y descargar joomla
yum -y install wget

wget https://downloads.joomla.org/es/cms/joomla3/3-9-15/Joomla_3-9-15-Stable-Full_Package.zip

#Descomprimir joomla
yum install -y unzip
mv Joomla_3-9-15-Stable-Full_Package.zip /var/www/html

cd /var/www/html
unzip Joomla_3-9-15-Stable-Full_Package.zip

chown -R apache:apache /var/www/html
chmod -R 775 /var/www/html


#Crear base de datos
sudo mysql -e "CREATE DATABASE bdjoomla CHARACTER SET utf8 COLLATE utf8_Spanish_ci;"
sudo mysql -e "CREATE USER 'ujoomla'@'bdjoomla' identified by 'ujoomla';"
sudo mysql -e "GRANT ALL PRIVILEGES ON bdjoomla.* to 'ujoomla' IDENTIFIED BY 'ujoomla';"
sudo mysql -e "FLUSH PRIVILEGES;"
