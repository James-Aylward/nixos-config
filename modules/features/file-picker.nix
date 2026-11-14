_: {
  flake.nixosModules.filePicker = {pkgs, ...}: {
    xdg.portal = {
      enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
      config = {
        niri.default = ["gtk"];
        common.default = ["gtk"];
      };
    };
    environment.sessionVariables.GTK_USE_PORTAL = "1";
  };
}
