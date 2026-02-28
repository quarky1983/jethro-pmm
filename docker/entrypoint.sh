#!/bin/bash

# Docker entrypoint script for Jethro PMM
# This script sets up the environment and starts Apache

echo "Starting Jethro PMM Docker container..."

# Copy Docker configuration if conf.php doesn't exist
if [ ! -f /var/www/html/conf.php ]; then
    echo "Creating configuration file..."
    cp /var/www/html/conf.docker.php /var/www/html/conf.php
    echo "Configuration file created from Docker template"
fi

# Ensure proper permissions
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

# Start Apache in foreground
echo "Starting Apache web server..."
apache2-foreground
