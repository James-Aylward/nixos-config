{
  lib,
  inputs,
  ...
}:
{
  flake.nixosModules.filePicker = { pkgs, ... }: {
    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-gnome
      ];
      config.common.default = "*";
    };

    # Install the GTK portal package
    environment.systemPackages = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };
}
