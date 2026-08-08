{inputs, ...}: {
  flake.nixosModules.calibre = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      calibre
    ];

    networking.firewall = {
      enable = true;
      allowedUDPPorts = [54982];
      allowedTCPPorts = [9090 8010];
      # TODO 8010 is for VLC
    };
  };
}
