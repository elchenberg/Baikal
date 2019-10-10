FROM php:7.3.10-apache-buster AS php-apache-buster
RUN set -eux; \
    apt-get update \
    && apt-get install --assume-yes --no-install-recommends libsqlite3-dev=3.27.2-3 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-install -j"$(nproc)" pdo_sqlite

FROM composer:1.9.0 AS composer
WORKDIR /var/www
COPY composer.* .
RUN set -eux; composer install --ignore-platform-reqs --no-autoloader --no-dev
COPY . .
RUN set -eux; composer dump-autoload --classmap-authoritative --no-dev

FROM php-apache-buster
COPY --from=composer /var/www /var/www
ARG PORT
RUN set -eux; \
    chown -R www-data:www-data /var/www/Specific \
    && sed -i "s/^Listen 80/Listen ${PORT:-80}/g" /etc/apache2/ports.conf \
    && sed -i "s/^<VirtualHost *:80>/<VirtualHost *:${PORT:-80}>/g" /etc/apache2/sites-enabled/000-default.conf
VOLUME [ "/tmp", "/var/run/apache2", "/var/www/Specific" ]
WORKDIR /var/www/html
ENV APACHE_RUN_USER=www-data APACHE_RUN_GROUP=www-data
USER www-data:www-data
