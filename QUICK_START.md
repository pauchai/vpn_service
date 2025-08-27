# ⚡ Быстрый старт VPN

## 🖥️ На сервере (5 минут):

```bash
# 1. Подключитесь к серверу
ssh root@YOUR_SERVER_IP

# 2. Скачайте и запустите установщик
wget https://raw.githubusercontent.com/yourusername/vpn_service/main/install.sh
chmod +x install.sh
sudo ./install.sh

# 3. Сохраните данные подключения из вывода!
```

## 📱 На клиенте:

### Android:
1. Установите **Shadowsocks** из Google Play
2. Добавьте сервер с данными из установки
3. Подключитесь

### iOS:
1. Купите **Shadowrocket** в App Store ($2.99)
2. Добавьте сервер с данными из установки
3. Подключитесь

### Windows:
1. Скачайте [Shadowsocks-Windows](https://github.com/shadowsocks/shadowsocks-windows/releases)
2. Добавьте сервер с данными из установки
3. Включите системный прокси

## ✅ Проверка:
- Откройте [2ip.ru](https://2ip.ru) 
- IP должен измениться на IP вашего сервера

## 📚 Подробная инструкция:
Смотрите [SETUP_GUIDE.md](SETUP_GUIDE.md) для детальных инструкций.
