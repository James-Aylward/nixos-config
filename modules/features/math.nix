{inputs, ...}: {
  flake.nixosModules.math = {pkgs, ...}: let
    oldPkgs = import inputs.mathematica-old-pkgs {
      inherit (pkgs.stdenv.hostPlatform) system;
      config.allowUnfree = true;
    };
  in {
    environment.systemPackages = [
      oldPkgs.mathematica
    ];
  };
}
