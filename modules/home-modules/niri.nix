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
      imports = [
        inputs.niri.nixosModules.niri
      ];

      # Things required by dms-shell for full feature
      home.packages = with pkgs; [
        quickshell
        dms-shell
        dgop
        wl-clipboard

        libreoffice-fresh
        thunderbird
        obsidian
        vlc
        darktable
        gimp3
        imagemagick
        qimgv
        yt-dlp
        beets
      ];

      programs.alacritty = {
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

      programs.niri.settings.spawn-at-startup = [
        {
          sh = "${lib.getExe pkgs.dms-shell} run";
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

      programs.niri.settings.xwayland-satellite = {
        enable = true;
        path = "${lib.getExe pkgs.xwayland-satellite}";
      };

      #programs.niri.settings.workspaces."sysmon" = { };
      #programs.niri.settings.window-rules = [
      #  {
      #    matches = [
      #      {
      #        app-id = "alacritty-btop";
      #      }
      #    ];

      #    open-focused = true;
      #    open-on-workspace = "sysmon";
      #  }
      #];

      programs.niri.settings.binds = {
        "XF86AudioRaiseVolume".action.spawn = ["${lib.getExe pkgs.pamixer}" "-i" "5"];
        "XF86AudioLowerVolume".action.spawn = ["${lib.getExe pkgs.pamixer}" "-d" "5"];
        "XF86AudioMute".action.spawn = ["${lib.getExe pkgs.pamixer}" "-t"];
        "XF86MonBrightnessUp".action.spawn = ["${lib.getExe pkgs.brightnessctl}" "-e2" "-n2" "set" "5%+"];
        "XF86MonBrightnessDown".action.spawn = ["${lib.getExe pkgs.brightnessctl}" "-e2" "-n2" "set" "5%-"];

        "Mod+Shift+Slash".action.show-hotkey-overlay = {};

        "Mod+Grave".action.spawn = ["${lib.getExe pkgs.dms-shell}" "ipc" "powermenu" "open"];
        "Mod+Shift+S".action.spawn = ["${lib.getExe pkgs.dms-shell}" "ipc" "niri" "screenshot"];
        "Mod+Shift+Ctrl+S".action.spawn = ["${lib.getExe pkgs.dms-shell}" "ipc" "screenshotWindow"];

        "Mod+O".action.toggle-overview = {};
        "Mod+O".repeat = false;
        "Mod+V".action.spawn = ["${lib.getExe pkgs.dms-shell}" "ipc" "clipboard" "toggle"];
        "Mod+Escape".action.spawn = ["${lib.getExe pkgs.dms-shell}" "ipc" "lock" "lock"];
        "Mod+Shift+Q".action.close-window = {};
        "Mod+Shift+Q".repeat = false;

        "Mod+Space".action.spawn = [
          "${lib.getExe pkgs.dms-shell}"
          "ipc"
          "launcher"
          "open"
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
          "${lib.getExe pkgs.alacritty}"
          "-e"
          "${lib.getExe pkgs.lazygit}"
        ];

        "Mod+S".action.spawn = [
          "${lib.getExe pkgs.signal-desktop}"
        ];

        "Mod+B".action.spawn = "${
          lib.getExe
          inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
        }";

        "Mod+Return".action.spawn = "${lib.getExe pkgs.alacritty}";
        "Mod+BracketLeft".action.consume-or-expel-window-left = {};
        "Mod+BracketRight".action.consume-or-expel-window-right = {};
        "Mod+Comma".action.consume-window-into-column = {};
        "Mod+Period".action.expel-window-from-column = {};
        "Mod+H".action.focus-column-left = {};
        "Mod+L".action.focus-column-right = {};
        "Mod+J".action.focus-window-down = {};
        "Mod+K".action.focus-window-up = {};

        "Mod+Shift+H".action.move-column-left = {};
        "Mod+Shift+L".action.move-column-right = {};
        "Mod+Shift+J".action.move-window-down = {};
        "Mod+Shift+K".action.move-window-up = {};

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
}
