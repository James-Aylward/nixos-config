{
  self,
  lib,
  inputs,
  ...
}: {

  # Home configuration to use on non-NixOS machines
  flake.homeConfigurations.root = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
    modules = [
      self.homeModules.jamesa
      {
        home.username = "root";
        home.homeDirectory = "/root";
      }
    ];
  };

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
