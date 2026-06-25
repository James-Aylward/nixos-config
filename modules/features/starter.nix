{ inputs, ... }: {
  flake.nixosModules.starter = { pkgs, ... }: {

    imports = [
      inputs.niri.nixosModules.niri
    ];
    programs.niri.enable = true;

    services.xserver.desktopManager.cinnamon.enable = true;

    services.xserver.enable = true;
  };
}
