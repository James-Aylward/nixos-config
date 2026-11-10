{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.vmConfig = {
    config,
    pkgs,
    ...
  }: {
    imports = [
      self.nixosModules.vmHardware
    ];

    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/sda";
    boot.loader.grub.useOSProber = true;

    networking.hostName = "nixos";

    networking.networkmanager.enable = true;

    time.timeZone = "Australia/Brisbane";

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
        "networkmanager"
        "wheel"
      ];
    };
    home-manager.users.jamesa = {
      imports = [self.homeModules.jamesa];
      enableDesktop = true;
      home.stateVersion = "26.05";
    };

    services.getty.autologinUser = "jamesa";

    nixpkgs.config.allowUnfree = true;

    system.stateVersion = "24.11"; # release of first install; do not bump
  };
}
