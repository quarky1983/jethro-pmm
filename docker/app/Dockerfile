FROM php:8.1-apache

# Install required system packages
RUN apt-get update && apt-get install -y \
    libzip-dev \
    libpng-dev \
    libjpeg-dev \
    libxml2-dev \
    libcurl4-openssl-dev \
    zlib1g-dev \
    libonig-dev \
    gettext \
    && docker-php-ext-install \
        gettext \
        zip \
        xmlwriter \
        mysqli \
        pdo \
        pdo_mysql \
        curl \
        gd

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Configure Apache to allow access to mounted app folder
RUN echo '<VirtualHost *:80>\n\
    DocumentRoot /var/www/html\n\
    <Directory /var/www/html>\n\
        Options Indexes FollowSymLinks\n\
        AllowOverride All\n\
        Require all granted\n\
    </Directory>\n\
</VirtualHost>' > /etc/apache2/sites-available/000-default.conf
