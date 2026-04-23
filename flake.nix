{
  description = "Zapret Service Wrapper Flake (Writable Workdir Version)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    zapret-src = {
      url = "github:Sergeydigl3/zapret-discord-youtube-linux";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, ... } @ inputs:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      commonInputs = pkgs: with pkgs; [
        bash curl iptables iproute2 ipset coreutils
        gnugrep gawk gnused pciutils procps git bc
      ];

      mkZapretApp = pkgs: scriptName: binName: pkgs.writeShellApplication {
        name = binName;
        runtimeInputs = commonInputs pkgs;
        text = ''
            # Проверка sudo
            if [ "$EUID" -ne 0 ]; then
              echo "Ошибка: Требуются права sudo."
              exit 1
            fi

            # Создание рабочей директории
            WORK_DIR="/var/lib/zapret-service"
            mkdir -p "$WORK_DIR"

            # Синхронизация исходников в WORK_DIR
            cp -rf ${inputs.zapret-src}/. "$WORK_DIR/"
            chmod -R +w "$WORK_DIR"
            cd "$WORK_DIR"

            if [ -f "./${scriptName}" ]; then
              echo "--- Запуск ${scriptName} ---"
              exec bash "./${scriptName}" "$@"
            else
              echo "Ошибка: Скрипт ${scriptName} не найден в репозитории."
              exit 1
            fi
        '';
      };
    in {
      # Пакеты для систем
      packages = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in {
          default = mkZapretApp pkgs "service.sh" "zapret-service";
          auto-tune = mkZapretApp pkgs "auto_tune_youtube.sh" "zapret-auto-tune";
        });

      # Приложения для вызова через nix run
      apps = forAllSystems (system: {
        # Команда по умолчанию `nix run .`
        default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/zapret-service";
        };
        # Команда для авто-тюна `nix run .#auto-tune`
        auto-tune = {
          type = "app";
          program = "${self.packages.${system}.auto-tune}/bin/zapret-auto-tune";
        };
      });
    };
}
