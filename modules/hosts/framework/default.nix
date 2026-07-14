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
      self.nixosModules.filePicker
      self.nixosModules.virtualisation
      self.nixosModules.nixDev
      self.nixosModules.tailscale
      self.nixosModules.calibre
      self.nixosModules.homeManagerConfig
    ];
  };
}
