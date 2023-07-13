FROM ubuntu:22.04

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
    php-dev \
    xfonts-75dpi

#Install xdiff
RUN cd /usr/src \
   && wget https://xxdiff-mirror-24bf2559-f236-47d5-ac22-f79a57c71e8d.s3.ap-southeast-2.amazonaws.com/libxdiff-0.23.tar.gz \
   && tar -xvf libxdiff-0.23.tar.gz \
   && cd libxdiff-0.23 \
   && ./configure \
   && make \
   && make install \
   && pecl install xdiff \
   && echo "extension=xdiff.so" > /etc/php/8.1/mods-available/xdiff.ini \
   && phpenmod xdiff

#Install dependancy for wkhtmltopdf in ubuntu 22.04
RUN wget https://mirror.sit.fraunhofer.de/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1l-1ubuntu1.2_amd64.deb \
    && dpkg -i libssl1.1_1.1.1l-1ubuntu1.2_amd64.deb

#Install wkhtmltopdf
RUN wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6.1-2/wkhtmltox_0.12.6.1-2.jammy_amd64.deb \
    && apt-get update \
    && apt-get install -y xvfb libfontconfig fontconfig libpng16-16 libxrender1 xfonts-75dpi build-essential xorg \
    && dpkg -i wkhtmltox_0.12.6.1-2.jammy_amd64.deb \
    && which wkhtmltopdf

#Install Imagick
RUN apt-get update \
    && apt-get install -y libmagickwand-dev ghostscript --no-install-recommends \
    && pecl install imagick \
	&& echo "extension=imagick.so"  > /etc/php/8.1/mods-available/imagick.ini \
    && phpenmod imagick \
    && sed -i 's/^.*policy.*coder.*none.*PDF.*//' /etc/ImageMagick-6/policy.xml

#Install php-excimer
RUN apt-get update \
    && pecl install excimer \
	&& echo "extension=excimer.so"  > /etc/php/8.1/mods-available/excimer.ini \
    && phpenmod excimer

RUN locale-gen en_AU.UTF-8

RUN python3 -m pip install --upgrade awscli jinja2-cli

RUN cd /usr/local/lib/ && curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

RUN mkdir /var/lib/sitedata \
    && chmod 0777 /var/lib/sitedata \
    && mkdir /var/lib/testsitedata \
    && chmod 0777 /var/lib/testsitedata

COPY nginx-site /etc/nginx/sites-available/default
COPY nginx.conf /etc/nginx/nginx.conf
COPY xdebug.ini /etc/php/8.1/mods-available/xdebug.ini
COPY php.ini /etc/php/8.1/mods-available/php.ini
RUN ln -s /etc/php/8.1/mods-available/php.ini /etc/php/8.1/fpm/conf.d/20-php.ini

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

WORKDIR /siteroot
