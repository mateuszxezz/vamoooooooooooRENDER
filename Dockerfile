FROM webdevops/php-nginx:8.2

WORKDIR /var/www/html

# Instala extensões do PHP
RUN docker-php-ext-install pdo pdo_pgsql zip

# Copia tudo
COPY . /var/www/html

# Permissões
RUN chown -R application:application /var/www/html

# Instala Composer
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

# Copia configs custom
COPY php.ini /opt/docker/etc/php/php.ini
COPY nginx.conf /opt/docker/etc/nginx/vhost.conf
COPY scripts/deploy.sh /etc/render/deploy.sh
RUN chmod +x /etc/render/deploy.sh

CMD ["/etc/render/deploy.sh"]
