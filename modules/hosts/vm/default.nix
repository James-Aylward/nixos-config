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
      self.nixosModules.displayManager
      self.nixosModules.niriSystem
      self.nixosModules.nix-dev
      self.nixosModules.homeManagerConfig
    ];
  };
}
