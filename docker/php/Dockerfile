FROM php:8.2-apache

RUN apt-get update \
    && apt-get install -y --no-install-recommends libcurl4-openssl-dev unzip git \
    && docker-php-ext-install pdo_mysql curl \
    && a2enmod rewrite headers \
    && sed -ri 's/AllowOverride None/AllowOverride All/g' /etc/apache2/apache2.conf \
    && rm -rf /var/lib/apt/lists/*

COPY --from=composer:2 /usr/bin/composer /usr/local/bin/composer
COPY docker/php/entrypoint.sh /usr/local/bin/devemm-entrypoint
RUN chmod +x /usr/local/bin/devemm-entrypoint

WORKDIR /var/www/html/ecommerce
ENTRYPOINT ["devemm-entrypoint"]
