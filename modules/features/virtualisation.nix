{
  ...
}:
{
  flake.nixosModules.virtualisation = { pkgs, ... }: {
    virtualisation.virtualbox.host.enable = true;
    virtualisation.libvirtd.enable = true;
    virtualisation.virtualbox.host.enableKvm = true;
    virtualisation.virtualbox.host.addNetworkInterface = false;
    virtualisation.virtualbox.host.enableExtensionPack = true;

    virtualisation.podman = {
      enable = true;
    };

    environment.systemPackages = [
      pkgs.distrobox
      pkgs.distrobox-tui
    ];
  };
}
