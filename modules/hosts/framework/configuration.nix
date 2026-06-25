# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
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
      # Include the results of the hardware scan.
      self.nixosModules.frameworkHardware
    ];

    # Bootloader.
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

    networking.hostName = "framework"; # Define your hostname.

    # Enable networking
    networking.networkmanager.enable = true;

    # Select internationalisation properties.
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

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "us";
      variant = "colemak_dh";
    };

    # Define a user account. Don't forget to set a password with ‘passwd’.
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

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
    services.blueman.enable = true;
    services.hardware.bolt.enable = true;
    services.udisks2.enable = true;
    services.gvfs.enable = true; # for MTP

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "24.11"; # Did you read the comment?
  };
}
