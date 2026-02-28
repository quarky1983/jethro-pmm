<?php
/**
 * JETHRO PMM - Docker Configuration
 *
 * conf.docker.php - Docker-specific configuration for Jethro
 */

///////////////////////////////////////////////////////////////////////////
// ESSENTIAL SETTINGS - these must be filled in for the system to run at all:
///////////////////////////////////////////////////////////////////////////

// Name of the mysql database
define('DB_DATABASE', 'pmm');

// Username and password of the mysql account with which to access the mysql database
define('DB_USERNAME', 'pmmuser');
define('DB_PASSWORD', 'secret');

// The URL jethro will be running at.  NB The final slash is important!!
define('BASE_URL', 'http://localhost:8080/');

// Whether the system must be accessed by HTTPS.
// If this is true, the BASE_URL above must begin with https://
define('REQUIRE_HTTPS', FALSE);

///////////////////////////////////////////////////////////////////////////
// OPTIONAL DATABASE SETTINGS -
// you can use these for more precise control of your mysql database
///////////////////////////////////////////////////////////////////////////

// Server on which mysql is running - for Docker, this is the container name
define('DB_HOST', 'mariadb');

// Database type - usually mysql.
define('DB_TYPE', 'mysql');

// Database port
define('DB_PORT', '3306');

///////////////////////////////////////////////////////////////////////////
// SYSTEM SETTINGS
///////////////////////////////////////////////////////////////////////////

// Set timezone for the system
define('TIMEZONE', 'UTC');

// System name that appears in the title bar
define('SYSTEM_NAME', 'Jethro PMM (Docker)');

// Enable development features
define('DEBUG', FALSE);

// Show friendly error messages instead of technical ones
define('FRIENDLY_ERRORS', TRUE);

///////////////////////////////////////////////////////////////////////////
// EMAIL SETTINGS for Docker SMTP4DEV
///////////////////////////////////////////////////////////////////////////

// SMTP server settings for testing with smtp4dev
define('EMAIL_METHOD', 'smtp');
define('EMAIL_SMTP_SERVER', 'smtp4dev');
define('EMAIL_SMTP_PORT', '25');
define('EMAIL_SMTP_USERNAME', '');
define('EMAIL_SMTP_PASSWORD', '');

// Default "from" address for emails
define('EMAIL_FROM_ADDRESS', 'noreply@jethro-docker.local');
define('EMAIL_FROM_NAME', 'Jethro PMM Docker');

///////////////////////////////////////////////////////////////////////////
// FILE PATHS
///////////////////////////////////////////////////////////////////////////

// Where to store uploaded files
define('FILE_BASE_PATH', '/var/www/html/files/');

// Where custom reports are stored  
define('CUSTOM_REPORTS_PATH', '/var/www/html/custom_reports/');

///////////////////////////////////////////////////////////////////////////
// SECURITY SETTINGS
///////////////////////////////////////////////////////////////////////////

// Salt for password hashing - generate a random string for production
define('PASSWORD_SALT', 'docker-development-salt-change-in-production');

// Session timeout in minutes
define('SESSION_TIMEOUT_MINS', 60);

// Maximum number of login attempts before lockout
define('MAX_LOGIN_ATTEMPTS', 5);

///////////////////////////////////////////////////////////////////////////
// FEATURE FLAGS
///////////////////////////////////////////////////////////////////////////

// Enable various features
define('FEATURE_PHOTOS', TRUE);
define('FEATURE_DOCUMENTS', TRUE);
define('FEATURE_SMS', FALSE); // Disabled for Docker development
define('FEATURE_NOTES', TRUE);
define('FEATURE_ATTENDANCE', TRUE);
define('FEATURE_SERVICES', TRUE);
define('FEATURE_ROSTERS', TRUE);

///////////////////////////////////////////////////////////////////////////
// DATABASE CONFIGURATION
///////////////////////////////////////////////////////////////////////////

// Disable ONLY_FULL_GROUP_BY for MySQL compatibility
define('SQL_MODE_OVERRIDE', "ONLY_FULL_GROUP_BY");
