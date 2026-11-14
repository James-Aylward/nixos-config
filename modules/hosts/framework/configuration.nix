{self, ...}: {
  flake.nixosModules.frameworkConfig = {pkgs, ...}: {
    imports = [
      self.nixosModules.frameworkHardware
    ];

    boot.loader = {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };

    services = {
      gnome.gnome-keyring.enable = true;
      geoclue2.enable = true;
      localtimed.enable = true;

      printing = {
        enable = true;
        drivers = with pkgs; [
          canon-cups-ufr2
          gutenprint
        ];
      };

      xserver.xkb = {
        layout = "us";
        variant = "colemak_dh";
      };

      power-profiles-daemon.enable = true;
      upower.enable = true;

      blueman.enable = true;
      hardware.bolt.enable = true;
      fwupd.enable = true; # BIOS/firmware updates via LVFS

      udisks2.enable = true;
      gvfs.enable = true; # for MTP
    };

    programs.nix-ld.enable = true;

    networking = {
      hostName = "framework";
      networkmanager.enable = true;
      hosts = {
        "127.0.0.1" = [
          "chatgpt.com"
          "www.chatgpt.com"
        ];
      };
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

    nixpkgs.config.allowUnfree = true;

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = false;
    };

    system.stateVersion = "24.11"; # release of first install; do not bump
  };
}
