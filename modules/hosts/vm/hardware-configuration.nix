{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.vmHardware = {
    config,
    lib,
    pkgs,
    modulesPath,
    ...
  }: {
    imports = [];

    boot.initrd.availableKernelModules = [
      "ata_piix"
      "ohci_pci"
      "ehci_pci"
      "ahci"
      "sd_mod"
      "sr_mod"
    ];
    boot.initrd.kernelModules = [];
    boot.kernelModules = [];
    boot.extraModulePackages = [];

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/aaec30ad-597a-456d-8abc-914293271441";
      fsType = "ext4";
    };

    swapDevices = [];

    networking.useDHCP = lib.mkDefault true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    virtualisation.virtualbox.guest.enable = true;
  };
}
