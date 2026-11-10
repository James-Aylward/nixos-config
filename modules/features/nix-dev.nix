{inputs, ...}: {
  flake.nixosModules.nixDev = {pkgs, ...}: {
    imports = [
      inputs.nix-index-database.nixosModules.nix-index
    ];

    nix.settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      # Hardlink identical files as each new store path is added
      auto-optimise-store = true;
    };

    # Periodic `nix store optimise` pass over the whole store
    nix.optimise.automatic = true;

    # Prebuilt nix-index database: provides `nix-locate`, the shell's
    # "command not found" suggestions, and a `comma` wired up to it
    programs.nix-index-database.comma.enable = true;
    programs.nix-index.enableZshIntegration = true;

    programs.nh = {
      enable = true;
      flake = "/home/jamesa/projects/nixos-config"; # sets NH_FLAKE
      clean = {
        enable = true; # weekly GC timer
        extraArgs = "--keep 5 --keep-since 7d";
      };
    };

    environment.systemPackages = with pkgs; [
      # language servers
      nil
      nixd
      statix

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
