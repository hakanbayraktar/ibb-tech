# PHP 8.1 FPM tabanlı bir görüntü kullanıyoruz
FROM php:8.1-fpm

# Gerekli paketleri yükleyin
RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libfreetype6-dev \
    libzip-dev unzip git libonig-dev libcurl4-openssl-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd zip mysqli \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug

# Composer'ı yükleyin
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Çalışma dizinini ayarlayın
WORKDIR /var/www
RUN rm -rf *
# Laravel'i Composer ile kurun
RUN composer create-project --prefer-dist laravel/laravel .

# Uygulama portunu açın
EXPOSE 80

# PHP-FPM servisini başlatın
CMD ["php-fpm"]

