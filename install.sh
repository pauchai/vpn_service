#!/bin/bash

# Этап 1: Простая установка Shadowsocks
# Устанавливает Shadowsocks сервер с базовой конфигурацией

set -e

# Цвета для вывода
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

log() {
    echo -e "${GREEN}[INFO] $1${NC}"
}

error() {
    echo -e "${RED}[ERROR] $1${NC}"
    exit 1
}

# Проверка root
if [[ $EUID -ne 0 ]]; then
    error "Запустите скрипт от root: sudo $0"
fi

log "Начинаем установку Shadowsocks..."

# Обновление системы
log "Обновление пакетов..."
apt update

# Установка Shadowsocks
log "Установка shadowsocks-libev..."
apt install -y shadowsocks-libev

# Создание конфигурации
log "Создание конфигурации..."
mkdir -p /etc/shadowsocks-libev

cat > /etc/shadowsocks-libev/config.json <<EOF
{
    "server": "0.0.0.0",
    "server_port": 8388,
    "password": "$(openssl rand -base64 16)",
    "timeout": 300,
    "method": "aes-256-gcm"
}
EOF

# Запуск сервиса
log "Запуск Shadowsocks..."
systemctl enable shadowsocks-libev
systemctl start shadowsocks-libev

# Настройка файрвола
log "Настройка файрвола..."
ufw allow 8388/tcp
ufw allow 8388/udp

log "✅ Shadowsocks установлен и запущен!"
echo ""
echo "📋 Конфигурация:"
cat /etc/shadowsocks-libev/config.json
echo ""
echo "🔗 Для подключения используйте:"
echo "Сервер: $(curl -s ipinfo.io/ip || echo 'YOUR_SERVER_IP')"
echo "Порт: 8388"
echo "Пароль: $(grep '"password"' /etc/shadowsocks-libev/config.json | cut -d'"' -f4)"
echo "Метод: aes-256-gcm"
