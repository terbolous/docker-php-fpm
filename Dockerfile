FROM alpine:edge
MAINTAINER Erik Weber <erik@vangenplotz.no>

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk add --update \
        php7 \
        php7-opcache \
        php7-ctype \
        php7-curl \
        php7-fpm \
        php7-gd \
        php7-iconv \
        php7-json \
        php7-mbstring \
        php7-mcrypt \
        php7-openssl \
        php7-pdo \
        php7-pdo_mysql \
        php7-redis \

    && sed -i "s|;*date.timezone =.*|date.timezone = Europe/Oslo|i" /etc/php7/php.ini \
    && sed -i "s|;*upload_max_filesize =.*|upload_max_filesize = 50M|i" /etc/php7/php.ini \
    && sed -i "s|;*max_file_uploads =.*|max_file_uploads = 200|i" /etc/php7/php.ini \
    && sed -i "s|;*post_max_size =.*|post_max_size = 100M|i" /etc/php7/php.ini \
    && sed -i "s|;*cgi.fix_pathinfo=.*|cgi.fix_pathinfo= 0|i" /etc/php7/php.ini \
    && sed -i "s|error_log = .*|error_log = /proc/self/fd/2|i" /etc/php7/php-fpm.conf \
    && sed -i "s|;catch_workers_output = .*|catch_workers_output = yes|i" /etc/php7/php-fpm.d/www.conf \
    && sed -i "s|user = nobody|user = nobody|i" /etc/php7/php-fpm.d/www.conf \
    && sed -i "s|group = nobody|group = nobody|i" /etc/php7/php-fpm.d/www.conf \
    && sed -i "s|;clear_env = .*|clear_env = no|i" /etc/php7/php-fpm.d/www.conf \
    && sed -i "s|pm.start_servers = .*|pm.start_servers = 2|i" /etc/php7/php-fpm.d/www.conf \
    && sed -i "s|pm.max_spare_servers = .*|pm.max_spare_servers = 5|i" /etc/php7/php-fpm.d/www.conf \
    && sed -i "s|listen = .*|listen = [::]:9000|i" /etc/php7/php-fpm.d/www.conf  \

    && mkdir /app \
    && chown -R nobody:nobody /app \
    && rm -rf /var/cache/apk*

VOLUME /app
WORKDIR /app
EXPOSE 9000

CMD ["/usr/sbin/php-fpm7", "-F", "-c", "/etc/php7"]





