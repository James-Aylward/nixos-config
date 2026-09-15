{
  lib,
  inputs,
  ...
}: {
  flake.nixosModules.filePicker = {pkgs, ...}: {
    xdg.portal.enable = true;
    xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
    xdg.portal.config = {
      niri.default = ["gtk"];
      common.default = ["gtk"];
    };
    environment.sessionVariables.GTK_USE_PORTAL = "1";
  };
}
