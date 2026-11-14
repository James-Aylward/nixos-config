{
  self,
  lib,
  inputs,
  ...
}: {
  flake.homeModules.niriConfig = {
    config,
    pkgs,
    ...
  }: {
    config = lib.mkIf config.enableDesktop {
      # This makes it possible to run just the home manager config, but system config breaks

      # Things required by dux-shell for full feature
      home.packages = with pkgs; [
        quickshell
        dux-shell
        dux-gop
        wl-clipboard
        inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
        self.packages.${pkgs.stdenv.hostPlatform.system}.pidopen
        self.packages.${pkgs.stdenv.hostPlatform.system}.siopicker

        libnotify

        drawio
        libreoffice
        thunderbird
        obsidian
        darktable
        gimp3
        kdePackages.kdenlive
        imagemagick
        qimgv
      ];

      programs = {
        alacritty = {
          enable = true;
          settings = {
            env = {
              TERM = "xterm-256color";
            };
            window.padding = {
              x = 15;
              y = 15;
            };
          };
        };

        niri.settings = {
          spawn-at-startup = [
            {
              sh = "${lib.getExe pkgs.dux-shell} run";
            }
            {
              sh = "${lib.getExe pkgs.signal-desktop} --start-in-tray";
            }
            {
              sh = "${lib.getExe pkgs.pamixer} --set-volume 0";
            }
            {
              sh = "${lib.getExe pkgs.pamixer} --mute";
            }
          ];

          xwayland-satellite = {
            enable = true;
            path = "${lib.getExe pkgs.xwayland-satellite}";
          };

          prefer-no-csd = true;

          input.touchpad = {
            natural-scroll = true;
            tap = true;
          };

          layout = {
            focus-ring.active.color = "#d3869b";
            tab-indicator = {
              place-within-column = true;
              position = "top";
              active.color = "#b16286"; # bright orange
              width = 8;
            };
          };

          window-rules = [
            {
              geometry-corner-radius = {
                top-left = 5.0;
                bottom-left = 5.0;
                top-right = 5.0;
                bottom-right = 5.0;
              };
              clip-to-geometry = true;
            }
          ];

          binds = {
            "XF86AudioRaiseVolume".action.spawn = [
              "${lib.getExe pkgs.dux-shell}"
              "ipc"
              "audio"
              "increment"
              "5"
            ];
            "XF86AudioLowerVolume".action.spawn = [
              "${lib.getExe pkgs.dux-shell}"
              "ipc"
              "audio"
              "decrement"
              "5"
            ];
            "XF86AudioMute".action.spawn = [
              "${lib.getExe pkgs.dux-shell}"
              "ipc"
              "audio"
              "mute"
            ];
            "XF86MonBrightnessUp".action.spawn = [
              "${lib.getExe pkgs.brightnessctl}"
              "-e2"
              "-n2"
              "set"
              "5%+"
            ];
            "XF86MonBrightnessDown".action.spawn = [
              "${lib.getExe pkgs.brightnessctl}"
              "-e2"
              "-n2"
              "set"
              "5%-"
            ];

            "XF86AudioPlay".action.spawn = [
              "${lib.getExe pkgs.dux-shell}"
              "ipc"
              "mpris"
              "playPause"
            ];

            "XF86AudioPrev".action.spawn = [
              "${lib.getExe pkgs.dux-shell}"
              "ipc"
              "mpris"
              "previous"
            ];

            "XF86AudioNext".action.spawn = [
              "${lib.getExe pkgs.dux-shell}"
              "ipc"
              "mpris"
              "next"
            ];

            "Mod+Shift+Slash".action.show-hotkey-overlay = {};

            "Mod+Grave".action.spawn = [
              "${lib.getExe pkgs.dux-shell}"
              "ipc"
              "powermenu"
              "open"
            ];
            "Mod+Shift+S".action.spawn = [
              "${lib.getExe pkgs.dux-shell}"
              "ipc"
              "niri"
              "screenshot"
            ];
            "Mod+Shift+Ctrl+S".action.spawn = [
              "${lib.getExe pkgs.dux-shell}"
              "ipc"
              "screenshotWindow"
            ];

            "Mod+O".action.toggle-overview = {};
            "Mod+O".repeat = false;
            "Mod+V".action.spawn = [
              "${lib.getExe pkgs.dux-shell}"
              "ipc"
              "clipboard"
              "toggle"
            ];
            "Mod+Escape".action.spawn = [
              "${lib.getExe pkgs.dux-shell}"
              "ipc"
              "lock"
              "lock"
            ];
            "Mod+Shift+Q".action.close-window = {};
            "Mod+Shift+Q".repeat = false;

            "Mod+Space".action.spawn = [
              "${lib.getExe pkgs.fuzzel}"
              "--background-color=1d2021FF"
              "--text-color=ebdbb2FF"
              "--prompt-color=83a598FF"
              "--input-color=ebdbb2FF"
              "--placeholder-color=928374FF"
              "--message-color=d5c4a1FF"
              "--match-color=fe8019FF"
              "--selection-color=3c3836FF"
              "--selection-text-color=fbf1c7FF"
              "--selection-match-color=fe8019FF"
              "--border-color=b16286FF"
              "--border-width=4"
              "--width=50"
              "--line-height=20"
              "--no-icons"
            ];

            "Mod+N".action.spawn = [
              "${lib.getExe pkgs.dux-shell}"
              "ipc"
              "notepad"
              "toggle"
            ];

            "Mod+T".action.spawn = [
              "${lib.getExe pkgs.sioyek}"
              "--new-window"
            ];

            "Mod+Z".action.spawn = [
              "${lib.getExe pkgs.thunderbird}"
            ];

            "Mod+R".action.spawn = [
              "${lib.getExe pkgs.alacritty}"
              "-e"
              "${lib.getExe pkgs.btop}"
            ];

            "Mod+G".action.spawn = [
              "${lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.pidopen}"
              "-e"
              "${lib.getExe pkgs.lazygit}"
            ];

            "Mod+P".action.spawn = [
              "${lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.siopicker}"
            ];

            "Mod+S".action.spawn = [
              "${lib.getExe pkgs.signal-desktop}"
            ];

            "Mod+B".action.spawn = "${
              lib.getExe
              inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
            }";

            "Mod+Return".action.spawn = "${
              lib.getExe
              self.packages.${pkgs.stdenv.hostPlatform.system}.pidopen
            }";
            "Mod+BracketLeft".action.consume-or-expel-window-left = {};
            "Mod+BracketRight".action.consume-or-expel-window-right = {};
            #"Mod+Comma".action.consume-window-into-column = { };
            #"Mod+Period".action.expel-window-from-column = { };
            "Mod+H".action.focus-column-left = {};
            "Mod+L".action.focus-column-right = {};
            "Mod+J".action.focus-window-down = {};
            "Mod+K".action.focus-window-up = {};

            "Mod+Shift+H".action.move-column-left = {};
            "Mod+Shift+L".action.move-column-right = {};
            "Mod+Shift+J".action.move-window-down = {};
            "Mod+Shift+K".action.move-window-up = {};

            "Mod+Shift+Comma".action.move-column-to-monitor-next = {};
            "Mod+Comma".action.focus-monitor-next = {};

            "Mod+Tab".action.focus-workspace-previous = {};
            "Mod+A".action.switch-preset-column-width = {};
            "Mod+W".action.toggle-column-tabbed-display = {};
            "Mod+1".action.focus-workspace = 1;
            "Mod+2".action.focus-workspace = 2;
            "Mod+3".action.focus-workspace = 3;
            "Mod+4".action.focus-workspace = 4;
            "Mod+5".action.focus-workspace = 5;

            "Mod+Shift+1".action.move-column-to-workspace = 1;
            "Mod+Shift+2".action.move-column-to-workspace = 2;
            "Mod+Shift+3".action.move-column-to-workspace = 3;
            "Mod+Shift+4".action.move-column-to-workspace = 4;
            "Mod+Shift+5".action.move-column-to-workspace = 5;

            "Mod+Minus".action.set-column-width = "-10%";
            "Mod+Equal".action.set-column-width = "+10%";
            "Mod+Shift+Minus".action.set-window-height = "-10%";
            "Mod+Shift+Equal".action.set-window-height = "+10%";

            "Mod+F".action.maximize-column = {};
            "Mod+Shift+F".action.fullscreen-window = {};
            "Mod+C".action.center-column = {};
          };
        };
      };
    };
  };
}
