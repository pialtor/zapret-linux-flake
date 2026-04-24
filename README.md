## Использование
_Как и в оригинальном репозитории, для использования требуются права sudo._

### 1. Первый запуск:
```
# Подгрузка зависимостей в рабочую директорию (WORK_DIR="/var/lib/zapret-service")
sudo nix run github:pialtor/zapret-linux-flake -- download-deps
```

### 2. Последующие запуски:
```
sudo nix run github:pialtor/zapret-linux-flake
# или
sudo nix run github:pialtor/zapret-linux-flake#auto-tune
```

## Локальный запуск:
```
git clone github:pialtor/zapret-linux-flake
cd zapret-linux-flake

# Подгрузка зависимостей (один раз)
sudo nix run . download-deps

# Запуск
sudo nix run
# или
sudo nix run .#auto-tune
```

## Ссылка на оригинальный репозиторий:
https://github.com/Sergeydigl3/zapret-discord-youtube-linux

---
Этот flake - только удобная Nix-обёртка.
