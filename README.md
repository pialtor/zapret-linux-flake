## 1. Использование
_Как и в оригинальном репозитории, для использования требуются права sudo._
> Данное решение позволяет использовать функционал [Zapret Discord YouTube Linux](https://github.com/Sergeydigl3/zapret-discord-youtube-linux) без внесения изменений в конфиг вашей NixOS системы. 
> Использование флейка - гарантирует воспроизводимость на разных системах.
> 
> Программа работает как «нативный пакет», независимый от конфига системы. 
> Все, что нужно для работы, Nix скачает и настроит автоматически в изолированном окружении.
> 
> Можно запускать приложение одной командой напрямую из github (nix run github:user/repo). 
> Не скачивая репозиторий вручную и не устанавливая зависимости в систему.

### 1.1 Запуск напрямую из github:
```
# Первичная загрузка зависимостей в рабочую директорию (WORK_DIR="/var/lib/zapret-service")
sudo nix run github:pialtor/zapret-linux-flake -- download-deps

# Последующие запуски (из любой директории):
sudo nix run github:pialtor/zapret-linux-flake
# или
sudo nix run github:pialtor/zapret-linux-flake#auto-tune
```

### 1.2 Локальный запуск:
```
# Скачиваем флейк в любую удобную директорию
git clone github:pialtor/zapret-linux-flake
cd zapret-linux-flake

# Подгружаем зависимости (один раз)
sudo nix run . download-deps

# Запуск (производится из директории с загруженным флейком)
sudo nix run
# или
sudo nix run .#auto-tune
```

## 2. Доступные команды
_Все команды из оригиального [репозитория](https://github.com/Sergeydigl3/zapret-discord-youtube-linux#%D0%B8%D1%81%D0%BF%D0%BE%D0%BB%D1%8C%D0%B7%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5) должны быть доступны._

### 2.1 Пример вызова:
```
# Вывод справки по командам
sudo nix run github:pialtor/zapret-linux-flake -- help

# Вывод стратегий
sudo nix run github:pialtor/zapret-linux-flake -- strategy list
```

## 3. Ссылка на оригинальный репозиторий:
https://github.com/Sergeydigl3/zapret-discord-youtube-linux



> Этот flake - просто удобная Nix-обёртка.
