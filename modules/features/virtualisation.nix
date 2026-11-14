_: {
  flake.nixosModules.virtualisation = {pkgs, ...}: {
    virtualisation = {
      virtualbox.host = {
        enable = true;
        enableKvm = true;
        addNetworkInterface = false;
        enableExtensionPack = true;
      };
      libvirtd.enable = true;
      podman.enable = true;
    };

    environment.systemPackages = [
      pkgs.distrobox
      pkgs.distrobox-tui
    ];
  };
}
