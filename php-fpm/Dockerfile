FROM php:7-fpm

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -yqq && \
    apt-get install -y apt-utils

# ext-zip
RUN apt-get install libzip-dev -y && \
    docker-php-ext-configure zip --with-libzip && \
    docker-php-ext-install zip

# ext-bcmath
RUN docker-php-ext-install bcmath

# ext-mysqli
RUN docker-php-ext-install mysqli

# ext-intl
RUN apt-get install -y zlib1g-dev libicu-dev g++ && \
    docker-php-ext-configure intl && \
    docker-php-ext-install intl

# ext-opcache
RUN docker-php-ext-install opcache

# ext-imagick
RUN apt-get install -y libmagickwand-dev imagemagick && \
    pecl install imagick && \
    docker-php-ext-enable imagick

# Image Optimizers
RUN apt-get install -y jpegoptim optipng pngquant gifsicle

COPY pool.conf /usr/local/etc/php-fpm.d

USER root

# Clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm /var/log/lastlog /var/log/faillog

RUN usermod -u 1000 www-data

WORKDIR /var/www

CMD ["php-fpm"]

EXPOSE 9000