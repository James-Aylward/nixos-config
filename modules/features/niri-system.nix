{inputs, ...}: {
  flake.nixosModules.niriSystem = {pkgs, ...}: {
    imports = [
      inputs.niri.nixosModules.niri
    ];

    services.avahi.enable = true;
    programs.niri.enable = true;
  };
}
