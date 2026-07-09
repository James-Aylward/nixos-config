{
  lib,
  inputs,
  ...
}: {
  flake.nixosModules.filePicker = {pkgs, ...}: {
    xdg.portal = {
      enable = true;

      extraPortals = with pkgs; [
        xdg-desktop-portal-gnome
        xdg-desktop-portal-termfilechooser
      ];

      config.common = {
        default = ["gnome"];

        "org.freedesktop.impl.portal.FileChooser" = ["termfilechooser"];
      };
    };
  };
}
