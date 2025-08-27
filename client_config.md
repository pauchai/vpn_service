# 📱 Конфигурация клиента Shadowsocks

## 🔗 Быстрое подключение
**SS URL:** `ss://YWVzLTI1Ni1nY206Q3AweUJpQkJjQTN6WFFWaU5SVytUUT09QDY0LjIyNi4xMDIuMTY1OjgzODg=`

## ⚙️ Ручные настройки
- **Сервер:** `64.226.102.165`
- **Порт:** `8388`
- **Пароль:** `Cp0yBiBBcA3zXQViNRW+TQ==`
- **Метод шифрования:** `aes-256-gcm`

## 📱 Клиенты для установки

### Android
- **Shadowsocks** ([Google Play](https://play.google.com/store/apps/details?id=com.github.shadowsocks))
- **v2rayNG** ([Google Play](https://play.google.com/store/apps/details?id=com.v2ray.ang))

### iOS
- **Shadowrocket** (App Store, платный)
- **Quantumult X** (App Store, платный)

### Windows
- **Shadowsocks-Windows** ([GitHub](https://github.com/shadowsocks/shadowsocks-windows/releases))
- **v2rayN** ([GitHub](https://github.com/2dust/v2rayN/releases))

### macOS
- **ShadowsocksX-NG** ([GitHub](https://github.com/shadowsocks/ShadowsocksX-NG/releases))
- **ClashX** ([GitHub](https://github.com/yichengchen/clashX/releases))

### Linux
```bash
# Ubuntu/Debian
sudo apt install shadowsocks-libev

# Создать конфигурацию
sudo tee /etc/shadowsocks-libev/config.json << EOF
{
    "server": "64.226.102.165",
    "server_port": 8388,
    "local_address": "127.0.0.1",
    "local_port": 1080,
    "password": "Cp0yBiBBcA3zXQViNRW+TQ==",
    "timeout": 300,
    "method": "aes-256-gcm"
}
EOF

# Запустить клиент
ss-local -c /etc/shadowsocks-libev/config.json
```

## 🔧 Настройка браузера
После запуска клиента настройте прокси в браузере:
- **Тип:** SOCKS5
- **Адрес:** 127.0.0.1
- **Порт:** 1080

## ✅ Проверка подключения
1. Подключитесь к VPN
2. Откройте [whatismyipaddress.com](https://whatismyipaddress.com)
3. IP должен быть: `64.226.102.165`

## 🌐 Настройка браузера с прокси

### Chromium/Chrome
```bash
# Запуск с VPN прокси
chromium --proxy-server="socks5://127.0.0.1:1080" &

# Или с отдельным профилем
chromium --proxy-server="socks5://127.0.0.1:1080" --user-data-dir=~/.config/chromium-vpn &
```

### Firefox
1. Откройте `about:preferences#general`
2. Прокрутите до "Параметры сети"
3. Нажмите "Настроить..."
4. Выберите "Ручная настройка прокси"
5. SOCKS Host: `127.0.0.1`, Port: `1080`
6. Выберите "SOCKS v5"

### Системный прокси (для всех приложений)
```bash
# Экспорт переменных окружения
export http_proxy="socks5://127.0.0.1:1080"
export https_proxy="socks5://127.0.0.1:1080"
export all_proxy="socks5://127.0.0.1:1080"

# Запуск приложения с прокси
env http_proxy=socks5://127.0.0.1:1080 https_proxy=socks5://127.0.0.1:1080 firefox &
```

## 🔧 Управление VPN

### Статус подключения
```bash
# Проверить работу клиента
ps aux | grep ss-local

# Проверить IP через VPN
curl --socks5 127.0.0.1:1080 https://ifconfig.me

# Проверить обычный IP
curl https://ifconfig.me
```

### Управление клиентом
```bash
# Запустить клиент
ss-local -c ~/.config/shadowsocks/client.json &

# Остановить клиент
pkill ss-local

# Запустить в фоне с логами
nohup ss-local -c ~/.config/shadowsocks/client.json > /tmp/ss-client.log 2>&1 &

# Посмотреть логи
tail -f /tmp/ss-client.log
```

## 🔒 Безопасность
- Не делитесь этой конфигурацией
- Регулярно меняйте пароль
- Используйте VPN только для законных целей
- Проверяйте IP перед важными действиями: `curl --socks5 127.0.0.1:1080 ifconfig.me`
