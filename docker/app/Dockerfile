FROM php:8.1-apache

# Install required system packages and Composer
RUN apt-get update && apt-get install -y \
    libzip-dev \
    libpng-dev \
    libjpeg-dev \
    libxml2-dev \
    libcurl4-openssl-dev \
    zlib1g-dev \
    libonig-dev \
    gettext \
    git \
    unzip \
    && docker-php-ext-install \
        gettext \
        zip \
        xmlwriter \
        mysqli \
        pdo \
        pdo_mysql \
        curl \
        gd

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Configure Apache to allow access to app folder
RUN echo '<VirtualHost *:80>\n\
    DocumentRoot /var/www/html\n\
    <Directory /var/www/html>\n\
        Options Indexes FollowSymLinks\n\
        AllowOverride All\n\
        Require all granted\n\
    </Directory>\n\
</VirtualHost>' > /etc/apache2/sites-available/000-default.conf

# Copy composer files and install dependencies in container
COPY composer.json composer.lock /var/www/html/
RUN cd /var/www/html && composer install --no-dev --optimize-autoloader --no-interaction

# Copy the entire application code
COPY . /var/www/html/

# Create necessary directories with proper permissions
RUN mkdir -p /var/www/html/files /var/www/html/custom_reports && \
    chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

# Copy and set up entrypoint script
COPY docker/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set the custom entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
