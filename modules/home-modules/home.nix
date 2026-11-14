{
  self,
  lib,
  inputs,
  ...
}: {
  # Headless home configuration for non-NixOS machines: shell/dev tools only
  flake.homeConfigurations.root = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs {system = "x86_64-linux";};
    modules = [
      self.homeModules.shell
      inputs.stylix.homeModules.stylix
      self.homeModules.stylixConfig
      {
        # Only theme the terminal tools; skip GTK/KDE/GNOME/fonts on headless boxes
        stylix.autoEnable = false;
        stylix.targets = {
          bat.enable = true;
          btop.enable = true;
          fzf.enable = true;
          lazygit.enable = true;
          starship.enable = true;
          yazi.enable = true;
        };
      }
      {
        home = {
          username = "root";
          homeDirectory = "/root";
          stateVersion = "26.05";
        };
        # Headless box: no D-Bus session, so skip the dconfSettings activation step
        dconf.enable = false;
        programs.home-manager.enable = true;
      }
    ];
  };

  flake.homeModules.jamesa = {...}: {
    options = {
      enableDesktop = lib.mkEnableOption "desktop environment (niri)";
    };

    imports = [
      inputs.stylix.homeModules.stylix
      self.homeModules.niriConfig
      self.homeModules.shell
      self.homeModules.media
      self.homeModules.stylixConfig
      self.homeModules.syncthing
    ];
  };
}
