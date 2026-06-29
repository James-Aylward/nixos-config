{inputs, ...}: {
  flake.nixosModules.calibre = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      calibre
    ];

    networking.firewall = {
      enable = true;
      allowedUDPPorts = [54982];
      allowedTCPPorts = [9090];
    };
  };
}
