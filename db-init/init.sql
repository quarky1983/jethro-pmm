-- Create the database if it doesn't exist
CREATE DATABASE IF NOT EXISTS pmm CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Create the user and grant privileges
CREATE USER IF NOT EXISTS 'pmmuser'@'%' IDENTIFIED BY 'secret';
GRANT ALL PRIVILEGES ON pmm.* TO 'pmmuser'@'%';

-- Ensure MySQL compatibility settings
SET GLOBAL sql_mode = 'STRICT_TRANS_TABLES,NO_ZERO_DATE,NO_ZERO_IN_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';

FLUSH PRIVILEGES;
