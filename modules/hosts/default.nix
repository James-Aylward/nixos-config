{
  self,
  inputs,
  ...
}:
{

  # System configuration
  flake.nixosConfigurations.vm = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.vmConfig

      self.nixosModules.starter
      self.nixosModules.displayManager

      self.nixosModules.environment
      self.nixosModules.nix-dev
      self.nixosModules.office
      self.nixosModules.homeManagerConfig
    ];

  };

  # Home manager configuration
  flake.homeModules.jamesaModule = { pkgs, ... }: {

    # This is the part that breaks rebuild
    ###############################
    imports = [
      self.homeModules.shell
      self.homeModules.myniri
    ];
    ###############################

    home.stateVersion = "26.05";
  };
}
