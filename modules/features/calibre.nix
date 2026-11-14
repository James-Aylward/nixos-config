_: {
  flake.nixosModules.calibre = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      calibre
    ];

    # Calibre "wireless device connection": 9090/tcp for the connection,
    # 54982/udp for the broadcast that lets devices discover it.
    networking.firewall = {
      enable = true;
      allowedUDPPorts = [54982];
      allowedTCPPorts = [9090];
    };
  };
}
