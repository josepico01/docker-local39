FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y \
    && apt-get install -y \
    curl \
    gnupg \
    git \
    locales \
    nginx \
    php \
    php-cli \
    php-curl \
    php-fpm \
    php-gd \
    php-intl \
    php-ldap \
    php-mbstring \
    php-mysql \
    php-pgsql \
    php-soap \
    php-xdebug \
    php-xml \
    php-xmlrpc \
    php-zip \
    python3 \
    python3-pip \
    vim \
    wget \
    php-pear \
    php-dev

RUN cd /usr/src \
   && wget https://xxdiff-mirror-24bf2559-f236-47d5-ac22-f79a57c71e8d.s3.ap-southeast-2.amazonaws.com/libxdiff-0.23.tar.gz \
   && tar -xvf libxdiff-0.23.tar.gz \
   && cd libxdiff-0.23 \
   && ./configure \
   && make \
   && make install \
   && pecl install xdiff \
   && echo "extension=xdiff.so" > /etc/php/7.2/mods-available/xdiff.ini \
   && phpenmod xdiff

RUN locale-gen en_AU.UTF-8

RUN cd /usr/local/lib/ && curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

RUN mkdir /var/lib/sitedata \
    && chmod 0777 /var/lib/sitedata \
    && mkdir /var/lib/testsitedata \
    && chmod 0777 /var/lib/testsitedata

COPY nginx-site /etc/nginx/sites-available/default
COPY nginx.conf /etc/nginx/nginx.conf
COPY xdebug.ini /etc/php/7.2/mods-available/xdebug.ini

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

WORKDIR /siteroot
