{ inputs, ... }: {
  flake.nixosModules.nix-dev = { pkgs, ... }: {
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
    ];
  };
}
