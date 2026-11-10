{
  lib,
  inputs,
  ...
}: {
  flake.nixosModules.displayManager = {
    config,
    pkgs,
    ...
  }: {
    console = {
      earlySetup = true;
      useXkbConfig = true;
    };

    services.xserver.xkb = {
      layout = lib.mkForce "us,us";
      variant = lib.mkForce "colemak_dh,";
      options = "grp:alt_space_toggle,ctrl:swapcaps";
    };

    # DMS greeter (renamed dux-greeter in nixpkgs), runs inside niri via greetd
    services.displayManager.dux-greeter = {
      enable = true;
      compositor = {
        name = "niri";
        # Greeter's niri session doesn't read the xkb settings above, so pass
        # them through or the password prompt would be QWERTY
        customConfig = let
          xkb = config.services.xserver.xkb;
        in ''
          input {
              keyboard {
                  xkb {
                      layout "${xkb.layout}"
                      variant "${xkb.variant}"
                      options "${xkb.options}"
                  }
              }
              touchpad {
                  tap
                  natural-scroll
              }
          }
          hotkey-overlay {
              skip-at-startup
          }
        '';
      };
      # Copy dux-shell settings/wallpaper/colours so the greeter matches the desktop
      configHome = "/home/jamesa";
    };

    # services.displayManager.ly = {
    #   enable = true;
    #   settings = {
    #     clear_password = true;
    #     bg = "0x00282828";
    #     fg = "0x00EBDBB2";
    #     border_fg = "0x00B16286";
    #     errors_bg = "0x00000000";
    #     errors_fg = "0x01CC241D";
    #
    #     blank_box = false;
    #     box_title = "Hello, world!";
    #     hide_version_string = true;
    #
    #     term_reset_cmd = "/usr/bin/tput reset; echo -en \"\\e]P0282828\"; echo -en \"\\e]P7EBDBB2\";";
    #   };
    # };
  };
}
