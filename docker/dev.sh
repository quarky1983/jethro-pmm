#!/bin/bash

# Jethro PMM Docker Development Helper Script
# This script provides common commands for Docker development

set -e

DOCKER_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$DOCKER_DIR")"

cd "$DOCKER_DIR"

case "${1:-help}" in
    "start"|"up")
        echo "🚀 Starting Jethro PMM Docker containers..."
        docker-compose up -d
        echo "✅ Containers started!"
        echo ""
        echo "🌐 Access points:"
        echo "   Jethro PMM:    http://localhost:8080"
        echo "   phpMyAdmin:    http://localhost:8081"
        echo "   SMTP4Dev:      http://localhost:8082"
        echo ""
        ;;
    "stop"|"down")
        echo "🛑 Stopping Jethro PMM Docker containers..."
        docker-compose down
        echo "✅ Containers stopped!"
        ;;
    "restart")
        echo "🔄 Restarting Jethro PMM Docker containers..."
        docker-compose restart
        echo "✅ Containers restarted!"
        ;;
    "rebuild")
        echo "🔨 Rebuilding Jethro PMM Docker containers..."
        docker-compose down
        docker-compose up --build -d
        echo "✅ Containers rebuilt and started!"
        ;;
    "logs")
        service="${2:-app}"
        echo "📋 Showing logs for service: $service"
        docker-compose logs -f "$service"
        ;;
    "shell")
        service="${2:-app}"
        echo "🐚 Opening shell in service: $service"
        docker-compose exec "$service" bash
        ;;
    "status")
        echo "📊 Container status:"
        docker-compose ps
        ;;
    "clean")
        echo "🧹 Cleaning up Docker resources..."
        echo "⚠️  This will remove all containers, volumes, and images!"
        read -p "Are you sure? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            docker-compose down -v
            docker system prune -f
            echo "✅ Cleanup complete!"
        else
            echo "❌ Cleanup cancelled."
        fi
        ;;
    "reset-db")
        echo "🗄️  Resetting database..."
        echo "⚠️  This will destroy all data in the database!"
        read -p "Are you sure? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            docker-compose stop mariadb
            docker volume rm jethro-pmm_dbdata || true
            docker-compose up -d mariadb
            echo "✅ Database reset complete!"
        else
            echo "❌ Database reset cancelled."
        fi
        ;;
    "install-composer")
        echo "📦 Installing Composer dependencies..."
        docker-compose exec app composer install
        echo "✅ Composer dependencies installed!"
        ;;
    "help"|*)
        echo "Jethro PMM Docker Development Helper"
        echo ""
        echo "Usage: $0 [command]"
        echo ""
        echo "Commands:"
        echo "  start           Start all containers"
        echo "  stop            Stop all containers"
        echo "  restart         Restart all containers"
        echo "  rebuild         Rebuild and start containers"
        echo "  logs [service]  Show logs (default: app)"
        echo "  shell [service] Open shell in container (default: app)"
        echo "  status          Show container status"
        echo "  clean           Clean up all Docker resources"
        echo "  reset-db        Reset database (destroys data)"
        echo "  install-composer Install PHP dependencies"
        echo "  help            Show this help"
        echo ""
        echo "Examples:"
        echo "  $0 start"
        echo "  $0 logs app"
        echo "  $0 shell mariadb"
        echo "  $0 rebuild"
        echo ""
        ;;
esac
