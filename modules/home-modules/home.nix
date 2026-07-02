{
  self,
  lib,
  inputs,
  ...
}: {
  # Home configuration to use on non-NixOS machines
  flake.homeConfigurations.root = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs {system = "x86_64-linux";};
    modules = [
      self.homeModules.jamesa
      inputs.niri.homeModules.niri
      {
        home.username = "root";
        home.homeDirectory = "/root";
        home.stateVersion = "26.05";
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
      self.homeModules.niriConfig
      self.homeModules.shell
      self.homeModules.stylixConfig
    ];
  };
}
