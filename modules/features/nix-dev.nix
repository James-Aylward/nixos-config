{inputs, ...}: {
  flake.nixosModules.nixDev = {pkgs, ...}: {
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    environment.systemPackages = with pkgs; [
      # language servers
      nil
      nixd
      statix

      # formatter
      alejandra

      # other
      nix-inspect
      nix-search
    ];
  };
}
