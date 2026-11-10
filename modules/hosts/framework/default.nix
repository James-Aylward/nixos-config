{
  self,
  inputs,
  ...
}: {
  # System configuration
  flake.nixosConfigurations.framework = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      inputs.nixos-hardware.nixosModules.framework-13-7040-amd
      self.nixosModules.calibre
      self.nixosModules.displayManager
      self.nixosModules.filePicker
      self.nixosModules.frameworkConfig
      self.nixosModules.math
      self.nixosModules.homeManagerConfig
      self.nixosModules.niriSystem
      self.nixosModules.nixDev
      self.nixosModules.tailscale
      self.nixosModules.tex
      self.nixosModules.virtualisation
      self.nixosModules.vlc
    ];
  };
}
