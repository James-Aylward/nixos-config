{
  inputs,
  self,
  ...
}: {
  flake.nixosModules.niriSystem = {pkgs, ...}: {
    imports = [
      inputs.niri.nixosModules.niri
    ];

    services.avahi.enable = true;

    services.accounts-daemon.enable = true;
    programs.niri.enable = true;

    fonts.packages = with pkgs; [
      nerd-fonts.iosevka
      self.packages.${pkgs.stdenv.hostPlatform.system}.libron
    ];

    # For screencasting
    environment.systemPackages = [pkgs.gnome-network-displays];
    networking.firewall = {
      allowedTCPPorts = [
        7236
        7250
      ];
      allowedUDPPorts = [
        7236
        5353
      ];
    };
  };
}
