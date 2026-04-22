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
    in {
      packages = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in {
          default = pkgs.writeShellApplication {
            name = "zapret-service";

            runtimeInputs = with pkgs; [
              bash
              curl
              iptables
              iproute2
              ipset
              coreutils
              gnugrep
              gawk
              gnused
              pciutils
              procps
              git # ОБЯЗАТЕЛЬНО: для загрузки стратегий через service.sh
            ];

            text = ''
              if [ "$EUID" -ne 0 ]; then
                echo "Ошибка: Пожалуйста, запустите через sudo."
                exit 1
              fi

              # Создаем постоянную рабочую директорию для хранения стратегий и конфигов
              WORK_DIR="/var/lib/zapret-service"
              mkdir -p "$WORK_DIR"

              # Копируем файлы из Nix Store в рабочую директорию.
              # Используем -f для обновления скриптов при обновлении флейка.
              cp -rf ${inputs.zapret-src}/. "$WORK_DIR/"
              chmod -R +w "$WORK_DIR"

              cd "$WORK_DIR"

              # Запуск скрипта со всеми переданными аргументами
              exec bash ./service.sh "$@"
            '';
          };
        });

      apps = forAllSystems (system: {
        default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/zapret-service";
        };
      });
    };
}
