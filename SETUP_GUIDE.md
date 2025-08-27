# 🚀 Инструкция по запуску сервера и настройке клиента

## 📋 Содержание
1. [Подготовка сервера](#подготовка-сервера)
2. [Установка VPN сервера](#установка-vpn-сервера)
3. [Настройка клиентов](#настройка-клиентов)
4. [Проверка подключения](#проверка-подключения)
5. [Устранение проблем](#устранение-проблем)

---

## 🖥️ Подготовка сервера

### Требования к серверу:
- **ОС**: Ubuntu 20.04 или 22.04
- **RAM**: минимум 512MB (рекомендуется 1GB+)
- **Место**: минимум 2GB свободного места
- **Сеть**: Публичный IP адрес
- **Доступ**: Root или sudo права

### Рекомендуемые VPS провайдеры:
- **DigitalOcean**: от $5/месяц
- **Vultr**: от $3.50/месяц  
- **Linode**: от $5/месяц
- **Hetzner**: от €3/месяц

### Подключение к серверу:
```bash
# Замените YOUR_SERVER_IP на IP адрес вашего сервера
ssh root@YOUR_SERVER_IP
```

---

## ⚙️ Установка VPN сервера

### Шаг 1: Скачивание проекта
```bash
# Скачивание с GitHub
git clone https://github.com/yourusername/vpn_service.git
cd vpn_service

# Или прямое скачивание install.sh
wget https://raw.githubusercontent.com/yourusername/vpn_service/main/install.sh
chmod +x install.sh
```

### Шаг 2: Запуск установки
```bash
sudo ./install.sh
```

### Что произойдет:
1. ✅ Обновление системы
2. ✅ Установка shadowsocks-libev
3. ✅ Создание конфигурации с случайным паролем
4. ✅ Настройка файрвола
5. ✅ Запуск сервиса

### Пример вывода:
```
[INFO] Начинаем установку Shadowsocks...
[INFO] Обновление пакетов...
[INFO] Установка shadowsocks-libev...
[INFO] Создание конфигурации...
[INFO] Запуск Shadowsocks...
[INFO] Настройка файрвола...
[INFO] ✅ Shadowsocks установлен и запущен!

📋 Конфигурация:
{
    "server": "0.0.0.0",
    "server_port": 8388,
    "password": "ABcd1234EFgh5678",
    "timeout": 300,
    "method": "aes-256-gcm"
}

🔗 Для подключения используйте:
Сервер: 192.168.1.100
Порт: 8388
Пароль: ABcd1234EFgh5678
Метод: aes-256-gcm
```

### ⚠️ ВАЖНО: Сохраните данные подключения!
Скопируйте IP, порт, пароль и метод шифрования - они понадобятся для настройки клиентов.

---

## 📱 Настройка клиентов

### Android

#### Шаг 1: Установка приложения
- Откройте **Google Play Store**
- Найдите и установите **Shadowsocks**
- Или скачайте APK с [GitHub](https://github.com/shadowsocks/shadowsocks-android)

#### Шаг 2: Настройка подключения
1. Откройте приложение Shadowsocks
2. Нажмите **"+"** для добавления сервера
3. Выберите **"Вручную"**
4. Заполните поля:
   - **Сервер**: IP вашего сервера
   - **Порт**: 8388
   - **Пароль**: пароль из установки
   - **Метод шифрования**: aes-256-gcm
5. Нажмите **"Сохранить"**
6. Нажмите на переключатель для подключения

---

### iOS

#### Шаг 1: Установка приложения
- Откройте **App Store**
- Купите и установите **Shadowrocket** ($2.99)
- Альтернативы: **Quantumult X**, **Surge**

#### Шаг 2: Настройка подключения
1. Откройте Shadowrocket
2. Нажмите **"+"** в правом верхнем углу
3. Выберите **"Add Server"**
4. Выберите тип **"Shadowsocks"**
5. Заполните поля:
   - **Host**: IP вашего сервера
   - **Port**: 8388
   - **Password**: пароль из установки
   - **Algorithm**: aes-256-gcm
6. Нажмите **"Done"**
7. Включите переключатель для подключения

---

### Windows

#### Шаг 1: Установка клиента
1. Скачайте [Shadowsocks-Windows](https://github.com/shadowsocks/shadowsocks-windows/releases)
2. Распакуйте архив
3. Запустите `Shadowsocks.exe`

#### Шаг 2: Настройка
1. Щелкните правой кнопкой по иконке в трее
2. Выберите **"Servers" → "Edit Servers"**
3. Заполните поля:
   - **Server IP**: IP вашего сервера
   - **Server Port**: 8388
   - **Password**: пароль из установки
   - **Encryption**: aes-256-gcm
4. Нажмите **"OK"**
5. Щелкните правой кнопкой → **"Enable System Proxy"**

---

### macOS

#### Шаг 1: Установка клиента
1. Скачайте [ShadowsocksX-NG](https://github.com/shadowsocks/ShadowsocksX-NG/releases)
2. Установите приложение
3. Запустите из Applications

#### Шаг 2: Настройка
1. Щелкните по иконке в строке меню
2. Выберите **"Servers" → "Server Preferences"**
3. Нажмите **"+"** для добавления сервера
4. Заполните поля:
   - **Address**: IP вашего сервера
   - **Port**: 8388
   - **Password**: пароль из установки
   - **Method**: aes-256-gcm
5. Нажмите **"OK"**
6. Выберите сервер и включите **"Turn Shadowsocks On"**

---

### Linux

#### Установка через пакетный менеджер:
```bash
# Ubuntu/Debian
sudo apt install shadowsocks-libev

# CentOS/RHEL
sudo yum install shadowsocks-libev
```

#### Создание конфигурации:
```bash
# Создайте файл конфигурации
sudo nano /etc/shadowsocks-libev/config.json
```

Содержимое файла:
```json
{
    "server": "IP_ВАШЕГО_СЕРВЕРА",
    "server_port": 8388,
    "local_address": "127.0.0.1",
    "local_port": 1080,
    "password": "ВАШ_ПАРОЛЬ",
    "timeout": 300,
    "method": "aes-256-gcm"
}
```

#### Запуск:
```bash
ss-local -c /etc/shadowsocks-libev/config.json
```

---

## ✅ Проверка подключения

### Шаг 1: Проверка работы сервера
На сервере выполните:
```bash
# Проверка статуса сервиса
sudo systemctl status shadowsocks-libev

# Проверка порта
sudo netstat -tlnp | grep 8388

# Просмотр логов
sudo journalctl -f -u shadowsocks-libev
```

### Шаг 2: Проверка подключения клиента
1. Подключитесь к VPN на вашем устройстве
2. Откройте браузер
3. Перейдите на сайт проверки IP: 
   - [whatismyipaddress.com](https://whatismyipaddress.com)
   - [2ip.ru](https://2ip.ru)
4. Убедитесь, что IP изменился на IP вашего сервера

### Шаг 3: Тест скорости
- [Speedtest.net](https://speedtest.net)
- [Fast.com](https://fast.com)

---

## 🔧 Управление сервером

### Полезные команды:

#### Статус сервиса:
```bash
sudo systemctl status shadowsocks-libev
```

#### Перезапуск:
```bash
sudo systemctl restart shadowsocks-libev
```

#### Остановка:
```bash
sudo systemctl stop shadowsocks-libev
```

#### Просмотр конфигурации:
```bash
sudo cat /etc/shadowsocks-libev/config.json
```

#### Изменение пароля:
```bash
# Откройте конфигурацию
sudo nano /etc/shadowsocks-libev/config.json

# Измените пароль в поле "password"
# Сохраните файл (Ctrl+O, Enter, Ctrl+X)

# Перезапустите сервис
sudo systemctl restart shadowsocks-libev
```

---

## 🐛 Устранение проблем

### Проблема: Не могу подключиться к серверу

#### Решение 1: Проверьте файрвол
```bash
sudo ufw status
sudo ufw allow 8388/tcp
sudo ufw allow 8388/udp
```

#### Решение 2: Проверьте сервис
```bash
sudo systemctl status shadowsocks-libev
sudo systemctl restart shadowsocks-libev
```

#### Решение 3: Проверьте порт
```bash
sudo netstat -tlnp | grep 8388
```

### Проблема: Медленная скорость

#### Решение 1: Смените метод шифрования
Попробуйте более быстрые методы:
- `aes-256-cfb` 
- `chacha20-ietf-poly1305`

#### Решение 2: Оптимизация сети
```bash
# Увеличение буферов TCP
echo 'net.core.rmem_max = 67108864' >> /etc/sysctl.conf
echo 'net.core.wmem_max = 67108864' >> /etc/sysctl.conf
sudo sysctl -p
```

### Проблема: Сервис не запускается

#### Проверьте логи:
```bash
sudo journalctl -u shadowsocks-libev --no-pager
```

#### Проверьте конфигурацию:
```bash
# Проверка синтаксиса JSON
sudo python3 -m json.tool /etc/shadowsocks-libev/config.json
```

---

## 🔐 Безопасность

### Рекомендации:

1. **Регулярно обновляйте сервер:**
   ```bash
   sudo apt update && sudo apt upgrade
   ```

2. **Используйте сложные пароли:**
   ```bash
   # Генерация нового пароля
   openssl rand -base64 32
   ```

3. **Настройте автоматические обновления:**
   ```bash
   sudo apt install unattended-upgrades
   sudo dpkg-reconfigure unattended-upgrades
   ```

4. **Мониторьте подключения:**
   ```bash
   sudo journalctl -f -u shadowsocks-libev | grep "connect"
   ```

---

## 📞 Поддержка

При возникновении проблем:

1. **Проверьте логи сервера:**
   ```bash
   sudo journalctl -u shadowsocks-libev --no-pager
   ```

2. **Проверьте сетевое подключение:**
   ```bash
   ping ваш_сервер_ip
   telnet ваш_сервер_ip 8388
   ```

3. **Попробуйте другой клиент** для исключения проблем с приложением

4. **Обратитесь к документации** Shadowsocks на [shadowsocks.org](https://shadowsocks.org)

---

**🎉 Готово! Ваш VPN сервер настроен и готов к использованию!**
