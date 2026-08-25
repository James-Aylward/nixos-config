{inputs, ...}: {
  flake.nixosModules.niriSystem = {pkgs, ...}: {
    imports = [
      inputs.niri.nixosModules.niri
    ];

    services.avahi.enable = true;
    services.accounts-daemon.enable = true;
    programs.niri.enable = true;

    fonts.packages = with pkgs; [
      nerd-fonts.iosevka
    ];
  };
}
