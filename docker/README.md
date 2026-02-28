# Jethro PMM Docker Setup

This directory contains Docker configuration files to run Jethro PMM in a containerized environment for development and testing.

## Quick Start

1. **Start the containers:**
   ```bash
   cd docker
   docker-compose up -d
   ```

2. **Access the applications:**
   - **Jethro PMM**: http://localhost:8080
   - **phpMyAdmin**: http://localhost:8081 (Database management)
   - **SMTP4Dev**: http://localhost:8082 (Email testing interface)

3. **Stop the containers:**
   ```bash
   docker-compose down
   ```

## Services Included

### Application Stack
- **jethro-app**: Main Jethro PMM application (PHP 8.1 + Apache)
- **mariadb**: Database server (MariaDB 10.6)
- **phpmyadmin**: Web-based database administration
- **smtp4dev**: SMTP server for email testing

### Ports
- `8080`: Jethro PMM web interface
- `8081`: phpMyAdmin
- `8082`: SMTP4Dev web interface
- `2525`: SMTP server (internal)

## Database Configuration

The MariaDB container is configured with:
- **Database**: `pmm`
- **Username**: `pmmuser`
- **Password**: `secret`
- **Root Password**: `rootpass`

## Default Application Login

For first-time access to Jethro PMM, use these default credentials:
- **Username**: `admin`
- **Password**: `Th1sIsAS3cr3t!`

⚠️ **Important**: Change this password immediately after first login for security!

## Email Testing

Emails sent by Jethro PMM are captured by SMTP4Dev instead of being sent to real recipients. This is perfect for development and testing:
- View sent emails at http://localhost:8082
- No real emails are sent outside the container

## File Persistence

The following data is persisted in Docker volumes:
- `dbdata`: MariaDB database files
- `smtpdata`: SMTP4Dev message storage

## Development Workflow

1. **Make code changes** in the main Jethro PMM directory
2. **Changes are reflected immediately** due to volume mounting
3. **View database** using phpMyAdmin
4. **Test emails** using SMTP4Dev interface

## Configuration

The Docker setup uses a dedicated configuration file (`conf.docker.php`) that:
- Connects to the MariaDB container
- Uses SMTP4Dev for email testing
- Sets appropriate paths for the containerized environment
- Enables debugging features for development

## Troubleshooting

### Container Issues
```bash
# View container logs
docker-compose logs app
docker-compose logs mariadb

# Restart specific service
docker-compose restart app

# Rebuild containers after Dockerfile changes
docker-compose up --build
```

### Database Issues
```bash
# Connect to database directly
docker-compose exec mariadb mysql -u pmmuser -psecret pmm

# Reset database (warning: destroys all data)
docker-compose down
docker volume rm jethro-pmm_dbdata
docker-compose up -d
```

### Application Issues
```bash
# Access application container shell
docker-compose exec app bash

# Check PHP configuration
docker-compose exec app php -m

# View Apache error logs
docker-compose logs app
```

## Production Considerations

This Docker setup is designed for development and testing. For production use:

1. **Change default admin password** from `Th1sIsAS3cr3t!` to a strong password
2. **Change default database passwords** in docker-compose.yml
3. **Use HTTPS** and update BASE_URL in configuration
4. **Configure proper email server** instead of SMTP4Dev
5. **Set up proper backup strategy** for database volumes
6. **Use environment variables** for sensitive configuration
7. **Consider using Docker secrets** for passwords
8. **Set up proper logging** and monitoring

## Next Steps

After the containers are running:

1. **Access Jethro PMM** at http://localhost:8080
2. **Log in with default credentials**: 
   - Username: `admin`
   - Password: `Th1sIsAS3cr3t!`
3. **⚠️ IMPORTANT**: Change the default password immediately!
4. **Complete the initial setup** if this is a fresh installation
3. **Create your first user account** through the web interface
4. **Import sample data** if available
5. **Test email functionality** using SMTP4Dev

## File Structure

```
docker/
├── docker-compose.yml    # Main Docker Compose configuration
├── app/
│   └── Dockerfile       # Application container definition
├── entrypoint.sh        # Container startup script
└── README.md           # This file

conf.docker.php          # Docker-specific Jethro configuration
db-init/
└── init.sql            # Database initialization script
```
