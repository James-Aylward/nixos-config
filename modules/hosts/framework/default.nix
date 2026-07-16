{
  self,
  inputs,
  ...
}:
{
  # System configuration
  flake.nixosConfigurations.framework = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.calibre
      self.nixosModules.displayManager
      self.nixosModules.filePicker
      self.nixosModules.frameworkConfig
      self.nixosModules.homeManagerConfig
      self.nixosModules.niriSystem
      self.nixosModules.nixDev
      self.nixosModules.tailscale
      self.nixosModules.tex
      self.nixosModules.virtualisation
    ];
  };
}
