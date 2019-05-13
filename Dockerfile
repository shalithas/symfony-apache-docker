FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y php apache2 libapache2-mod-php7.0 php-mysql php-intl git git-core curl php-curl php-xml composer zip unzip php-zip mcrypt

# 1. Normal Update
RUN apt-get update -y && apt-get install -y libpng-dev curl libcurl4-openssl-dev libxml2-dev php-soap

# # 3. Install Redis PHP extension
# # install phpredis extension
# RUN apt-get install php-pear

# ENV PHPREDIS_VERSION 3.1.2

# RUN pecl install -o -f redis \
# &&  rm -rf /tmp/pear \
# &&  docker-php-ext-enable redis


# 4. Copy certificates
COPY my-dev.insead.edu.crt /etc/ssl/certs/
COPY my-dev.insead.edu.key /etc/ssl/private/
COPY my-dev.insead.edu.conf /etc/apache2/sites-available/
COPY apache2.conf /etc/apache2/

# Configure Apache
# RUN rm -rf /var/www/* 

RUN mkdir /var/www/html/web

RUN a2enmod headers
RUN a2enmod rewrite
RUN a2enmod ssl

RUN service apache2 restart

RUN a2ensite my-dev.insead.edu.conf

RUN service apache2 restart
EXPOSE 80 443

RUN service apache2 restart