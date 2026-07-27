{ inputs, ... }: {
  flake.nixosModules.math = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      mathematica
    ];
  };
}
