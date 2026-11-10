{inputs, ...}: {
  flake.nixosModules.vlc = {pkgs, ...}: {
    environment.systemPackages = [pkgs.vlc];

    # VLC serves media to Chromecast devices over HTTP on 8010/tcp
    networking.firewall.allowedTCPPorts = [8010];
  };
}
