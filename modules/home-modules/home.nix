{
  self,
  lib,
  ...
}:
{
  flake.homeModules.jamesa = { pkgs, config, ... }: {
    options = {
      enableDesktop = lib.mkEnableOption "desktop environment (niri)";
    };

    imports = [
      self.homeModules.shell
      self.homeModules.niriConfig
    ];

  };
}
