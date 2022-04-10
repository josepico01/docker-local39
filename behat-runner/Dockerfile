FROM eass_moodle:latest

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

RUN apt-get update -y \
    && apt-get install -y \
        wget

RUN cd /usr/src \
   && wget http://www.xmailserver.org/libxdiff-0.22.tar.gz \
   && tar -xzf libxdiff-0.22.tar.gz \
   && cd libxdiff-0.22 \
   && ./configure \
   && make \
   && make install \
   && cd .. \
   && mkdir php \
   && mkdir php/ext \
&& wget https://pecl.php.net/get/xdiff-2.1.0.tgz \
&& tar -xzf xdiff-2.1.0.tgz \
&& cp -r xdiff-2.1.0 /usr/src/php/ext/ \
 && apt-get install -y \
	php-pear \
    php-dev \
    && pecl install xdiff 
    
ENTRYPOINT [ "/entrypoint.sh" ]
