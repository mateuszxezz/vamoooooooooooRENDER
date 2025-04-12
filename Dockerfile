FROM php:8.3-fpm

# Instala dependências do sistema
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim unzip git curl \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    zip \
    unzip \
    && docker-php-ext-install pdo_mysql mbstring zip exif pcntl

# Instala o Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Seta o diretório de trabalho
WORKDIR /var/www

# Copia tudo
COPY . .

# Instala dependências do Laravel
RUN composer install --no-dev --optimize-autoloader

# Dá permissão
RUN chown -R www-data:www-data /var/www \
    && chmod -R 775 /var/www/storage /var/www/bootstrap/cache

# Expõe a porta
EXPOSE 8000

# Comando pra rodar
CMD php artisan serve --host=0.0.0.0 --port=8000
