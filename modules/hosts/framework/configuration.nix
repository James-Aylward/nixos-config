{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.frameworkConfig = {
    config,
    pkgs,
    ...
  }: {
    imports = [
      self.nixosModules.frameworkHardware
    ];

    boot.loader.grub.enable = true;
    boot.loader.grub.device = "nodev";
    boot.loader.grub.efiSupport = true;
    boot.loader.efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    services.gnome.gnome-keyring.enable = true;
    programs.nix-ld.enable = true;
    services.geoclue2.enable = true;
    services.localtimed.enable = true;

    # Printing
    ##############################################################################
    services.printing = {
      enable = true;
      drivers = with pkgs; [
        canon-cups-ufr2
        gutenprint
      ];
    };

    networking.hostName = "framework";

    networking.networkmanager.enable = true;

    networking.hosts = {
      "127.0.0.1" = [
        "chatgpt.com"
        "www.chatgpt.com"
      ];
    };

    i18n.defaultLocale = "en_AU.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_AU.UTF-8";
      LC_IDENTIFICATION = "en_AU.UTF-8";
      LC_MEASUREMENT = "en_AU.UTF-8";
      LC_MONETARY = "en_AU.UTF-8";
      LC_NAME = "en_AU.UTF-8";
      LC_NUMERIC = "en_AU.UTF-8";
      LC_PAPER = "en_AU.UTF-8";
      LC_TELEPHONE = "en_AU.UTF-8";
      LC_TIME = "en_AU.UTF-8";
    };

    services.xserver.xkb = {
      layout = "us";
      variant = "colemak_dh";
    };

    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;

    users.users.jamesa = {
      isNormalUser = true;
      description = "jamesa";
      extraGroups = [
        "input"
        "networkmanager"
        "wheel"
        "dialout"
        "plugdev"
      ];
    };
    home-manager.users.jamesa = {
      imports = [self.homeModules.jamesa];
      enableDesktop = true;
      home.stateVersion = "24.05";
    };

    services.power-profiles-daemon.enable = true;
    services.upower.enable = true;
    #services.auto-cpufreq.enable = true;
    #services.auto-cpufreq.settings = {
    #  battery = {
    #    governor = "powersave";
    #    turbo = "never";
    #  };
    #  charger = {
    #    governor = "performance";
    #    turbo = "auto";
    #  };
    #};

    nixpkgs.config.allowUnfree = true;

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
    services.blueman.enable = true;
    services.hardware.bolt.enable = true;
    services.fwupd.enable = true; # BIOS/firmware updates via LVFS

    services.udisks2.enable = true;
    services.gvfs.enable = true; # for MTP

    system.stateVersion = "24.11"; # release of first install; do not bump
  };
}
