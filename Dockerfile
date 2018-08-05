FROM alpine:edge

LABEL maintainer="TossPig <docker@TossP.com>" \
      version="2.0.1" \
      description="php7服务"

ENV TIMEZONE Asia/Shanghai

# RUN echo -e "http://mirrors.aliyun.com/alpine/edge/main/\nhttp://mirrors.aliyun.com/alpine/edge/community/" > /etc/apk/repositories
RUN apk update &&  apk upgrade && \ 
	apk add --no-cache tzdata logrotate && \
	apk add --no-cache --virtual php7_tools php7-fpm \
			# php7-dev php7-cli php7-pear php7-phar \
	        php7-intl \
			php7-openssl \
			php7-sqlite3 \
			php7-tokenizer \
			php7-gmp \
			php7-sodium \
			php7-pcntl \
			php7-common \
			php7-oauth \
			php7-xsl \
			php7-gmagick \
			# php7-imagick \ #会出现版本警告
			php7-enchant \
			php7-pspell \
			php7-redis \
			php7-snmp \
			php7-fileinfo \
			php7-mbstring \
			php7-xmlrpc \
			php7-embed \
			php7-xmlreader \
			php7-exif \
			php7-recode \
			php7-opcache \
			php7-ldap \
			php7-posix \
			php7-session \
			php7-gd \
			php7-gettext \
			php7-mailparse \
			php7-json \
			php7-xml \
			php7-mongodb \
			php7-iconv \
			php7-sysvshm \
			php7-curl \
			php7-shmop \
			php7-imap \
			php7-xdebug \
			php7-zip \
			php7-ctype \
			php7-amqp \
			php7-mcrypt \
			php7-wddx \
			php7-bcmath \
			php7-calendar \
			php7-tidy \
			php7-dom \
			php7-sockets \
			php7-zmq \
			php7-memcached \
			php7-yaml \
			php7-soap \
			php7-apcu \
			php7-sysvmsg \
			php7-ssh2 \
			php7-ftp \
			php7-sysvsem \
			php7-bz2 \
			php7-simplexml \
			php7-xmlwriter \		
			php7-sqlite3 php7-pgsql php7-mysqli php7-mysqlnd \
			php7-pdo_sqlite php7-pdo_pgsql php7-pdo_mysql && \
	# 清理数据
	cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
	echo "${TIMEZONE}" > /etc/timezone && \
	mkdir -p /run/nginx && \
	apk del tzdata && \
	rm -rf /var/cache/apk/* && \
	

	echo '#!/bin/sh' > /ENTRYPOINT.sh  && \
	echo 'cp -rf /etc/php7/* /def_conf' >> /ENTRYPOINT.sh  && \
	echo '/usr/sbin/php-fpm7 -t -y /conf/php-fpm.conf -c /conf/php.ini' >> /ENTRYPOINT.sh && \
	echo '/usr/sbin/php-fpm7 -F -y /conf/php-fpm.conf -c /conf/php.ini' >> /ENTRYPOINT.sh && \
	chmod 755 /ENTRYPOINT.sh

VOLUME ["/log","/def_conf","/conf","/hosts"]

EXPOSE 9000

CMD ["/ENTRYPOINT.sh"]
