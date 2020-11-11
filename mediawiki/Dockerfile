FROM centos:7

# Install Apache
RUN yum -y update
RUN yum -y install httpd httpd-tools

# Install EPEL Repo
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
 && rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm

# Install PHP
RUN yum  -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
RUN yum-config-manager --enable remi-php73
RUN yum -y install  php73   php73-php php73-php-mbstring php73-php-mysqlnd php73-php-gd php73-php-xml

# Install Media wiki
RUN yum -y install wget unzip
RUN wget https://releases.wikimedia.org/mediawiki/1.35/mediawiki-1.35.0.tar.gz
RUN tar -zxvf mediawiki-1.35.0.tar.gz
RUN mv mediawiki-1.35.0 /var/www/mediawiki
COPY LocalSettings.php /var/www/mediawiki/LocalSettings.php

COPY httpd.conf /etc/httpd/conf/httpd.conf
RUN chown -R apache:apache /var/www/mediawiki

EXPOSE 80

# Start Apache
CMD ["/usr/sbin/httpd","-D","FOREGROUND"]
