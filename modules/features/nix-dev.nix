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

      comma

      # formatter
      alejandra
      shfmt

      # other
      just
      nix-inspect
      nix-search
    ];
  };
}
