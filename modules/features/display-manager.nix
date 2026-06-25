{
  lib,
  inputs,
  ...
}: {
  flake.nixosModules.displayManager = {pkgs, ...}: {
    console = {
      earlySetup = true;
      useXkbConfig = true;
    };

    services.xserver.xkb = {
      layout = lib.mkForce "us,us";
      variant = lib.mkForce "colemak_dh,";
      options = "grp:alt_space_toggle,ctrl:swapcaps";
    };

    services.displayManager.ly = {
      enable = true;
      settings = {
        clear_password = true;
        bg = "0x00282828";
        fg = "0x00EBDBB2";
        border_fg = "0x00B16286";
        errors_bg = "0x00000000";
        errors_fg = "0x01CC241D";

        blank_box = false;
        box_title = "Hello, world!";
        hide_version_string = true;

        term_reset_cmd = "/usr/bin/tput reset; echo -en \"\\e]P0282828\"; echo -en \"\\e]P7EBDBB2\";";
      };
    };
  };
}
