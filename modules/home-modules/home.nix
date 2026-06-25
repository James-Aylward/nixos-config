{
  self,
  lib,
  inputs,
  ...
}: {
  flake.homeModules.jamesa = {
    pkgs,
    config,
    ...
  }: {
    options = {
      enableDesktop = lib.mkEnableOption "desktop environment (niri)";
    };

    imports = [
      inputs.stylix.homeModules.stylix
      self.homeModules.shell
      self.homeModules.niriConfig
      self.homeModules.stylixConfig
    ];
  };
}
