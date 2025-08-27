#!/bin/bash

# Outline VPN Server Installer
# Простейшая установка VPN сервера от Google Jigsaw
# Требует Ubuntu 18.04+ и Docker

set -e

# Цвета для вывода
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log() {
    echo -e "${GREEN}[INFO] $1${NC}"
}

warn() {
    echo -e "${YELLOW}[WARNING] $1${NC}"
}

error() {
    echo -e "${RED}[ERROR] $1${NC}"
    exit 1
}

# Проверка root
if [[ $EUID -ne 0 ]]; then
    error "Запустите скрипт от root: sudo $0"
fi

log "🚀 Начинаем установку Outline VPN Server..."

# Проверка ОС
if ! grep -qi ubuntu /etc/os-release; then
    warn "Этот скрипт протестирован на Ubuntu. Продолжаем на свой страх и риск..."
fi

# Обновление системы
log "📦 Обновление системы..."
apt update

# Установка необходимых пакетов
log "🔧 Установка необходимых пакетов..."
apt install -y curl wget ufw

# Установка Docker (если не установлен)
if ! command -v docker &> /dev/null; then
    log "🐳 Установка Docker..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    systemctl enable docker
    systemctl start docker
    rm get-docker.sh
    log "✅ Docker установлен"
else
    log "✅ Docker уже установлен"
fi

# Настройка файрвола
log "🔥 Настройка файрвола..."
ufw --force reset
ufw default deny incoming
ufw default allow outgoing

# SSH доступ
ufw allow 22/tcp

# Outline порты (случайные порты будут открыты автоматически)
# Открываем диапазон для Outline
ufw allow 1024:65535/tcp
ufw allow 1024:65535/udp

ufw --force enable
log "✅ Файрвол настроен"

# Создание директории для Outline
mkdir -p /opt/outline
cd /opt/outline

# Скачивание и запуск установщика Outline
log "📥 Скачивание установщика Outline..."
curl -sS https://raw.githubusercontent.com/Jigsaw-Code/outline-server/master/src/server_manager/install_scripts/install_server.sh > install_outline.sh

# Запуск установки Outline
log "⚙️ Установка Outline Server..."
bash install_outline.sh

# Проверка установки
if docker ps | grep -q shadowbox; then
    log "✅ Outline Server успешно установлен!"
else
    error "❌ Ошибка установки Outline Server"
fi

# Получение информации о сервере
log "📋 Получение информации о сервере..."

# Ожидание запуска контейнера
sleep 10

# Получение API URL и ключа
API_URL=""
CERT_SHA256=""

if [ -f "install_outline.log" ]; then
    API_URL=$(grep -o 'https://[^"]*' install_outline.log | head -1)
    CERT_SHA256=$(grep -o 'cert=[^"]*' install_outline.log | sed 's/cert=//' | head -1)
fi

# Если не удалось получить из лога, пробуем из контейнера
if [ -z "$API_URL" ]; then
    log "🔍 Получение данных из контейнера..."
    API_URL=$(docker logs shadowbox 2>&1 | grep -o 'https://[^"]*' | head -1)
    CERT_SHA256=$(docker logs shadowbox 2>&1 | grep -o 'cert=[^"]*' | sed 's/cert=//' | head -1)
fi

# Сохранение информации
cat > /opt/outline/server_info.txt <<EOF
Outline Server Information
==========================
Server IP: $(curl -s ipinfo.io/ip || echo 'YOUR_SERVER_IP')
Management URL: $API_URL
Certificate SHA256: $CERT_SHA256

Installation Date: $(date)
Docker Container: shadowbox
EOF

# Вывод информации
echo ""
echo "🎉 =========================================="
echo "   OUTLINE VPN SERVER УСТАНОВЛЕН!"
echo "=========================================="
echo ""
echo "📍 IP сервера: $(curl -s ipinfo.io/ip || echo 'YOUR_SERVER_IP')"
echo ""
echo "🔗 Данные для Outline Manager:"
echo "   URL: $API_URL"
echo "   Certificate: $CERT_SHA256"
echo ""
echo "📱 Следующие шаги:"
echo "1. Скачайте Outline Manager на компьютер:"
echo "   https://getoutline.org/get-started/#step-1"
echo ""
echo "2. Добавьте сервер используя URL выше"
echo ""
echo "3. Скачайте клиенты Outline:"
echo "   - Android: https://play.google.com/store/apps/details?id=org.outline.android.client"
echo "   - iOS: https://apps.apple.com/app/outline-app/id1356177741"
echo "   - Windows: https://github.com/Jigsaw-Code/outline-client/releases"
echo "   - macOS: https://itunes.apple.com/app/outline-secure-internet-access/id1356178125"
echo ""
echo "📄 Информация сохранена в: /opt/outline/server_info.txt"
echo ""
echo "🔧 Управление сервером:"
echo "   Статус: docker ps | grep shadowbox"
echo "   Логи: docker logs shadowbox"
echo "   Перезапуск: docker restart shadowbox"
echo "   Остановка: docker stop shadowbox"
echo ""
echo "✅ Установка завершена!"
echo "=========================================="
