_: {
  flake.nixosModules.frameworkHardware = {
    config,
    lib,
    ...
  }: {
    boot = {
      initrd.availableKernelModules = [
        "nvme"
        "xhci_pci"
        "thunderbolt"
      ];
      initrd.kernelModules = [];
      kernelModules = ["kvm-amd"];
      extraModulePackages = [];
    };

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/e0cae9bd-f4b1-492d-a565-0226a946374d";
      fsType = "ext4";
    };

    fileSystems."/boot/efi" = {
      device = "/dev/disk/by-uuid/0714-8070";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };

    swapDevices = [{device = "/dev/disk/by-uuid/d6618fac-45fa-4954-a40b-d7b9d4ed18cb";}];

    hardware = {
      graphics.enable = true;
      graphics.enable32Bit = true;
      enableRedistributableFirmware = true;
      cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };

    networking.useDHCP = lib.mkDefault true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  };
}
