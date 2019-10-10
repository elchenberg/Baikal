FROM php:7.3.10-fpm-alpine3.10 AS php-fpm-alpine
RUN set -eux; \
    apk add --no-cache sqlite-dev=3.28.0-r0 && \
    docker-php-ext-install -j"$(nproc)" \
    pdo_mysql \
    pdo_sqlite

FROM composer:1.9.0 AS composer
WORKDIR /var/www
COPY composer.* .
RUN set -eux; composer install --ignore-platform-reqs --no-autoloader --no-dev
COPY . .
RUN set -eux; composer dump-autoload --classmap-authoritative --no-dev

FROM php-fpm-alpine
COPY --from=composer /var/www /var/www
RUN set -eux; chown -R www-data:www-data /var/www/Specific
VOLUME [ "/tmp", "/var/www/Specific" ]
WORKDIR /var/www/html
USER www-data:www-data
