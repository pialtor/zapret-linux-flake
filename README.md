# Использование

1. Первый запуск:
```
# Подгрузка зависимостей в рабочую директорию (WORK_DIR="/var/lib/zapret-service")
sudo nix run github:pialtor/zapret-linux-flake --download-deps
```

2. Последующие запуски:
```
sudo nix run github:pialtor/zapret-linux-flake
# или
sudo nix run github:pialtor/zapret-linux-flake#auto-tune
```

# Ссылка на оригинальный репозиторий:
https://github.com/Sergeydigl3/zapret-discord-youtube-linux

---
Этот flake - только удобная Nix-обёртка.
