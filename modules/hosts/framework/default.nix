{
  self,
  inputs,
  ...
}: {
  # System configuration
  flake.nixosConfigurations.framework = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.frameworkConfig
      self.nixosModules.displayManager
      self.nixosModules.niriSystem
      self.nixosModules.nix-dev
      self.nixosModules.tailscale
      self.nixosModules.calibre
      self.nixosModules.homeManagerConfig
    ];
  };
}
