{ ... }: {
  flake.homeModules.syncthing = { pkgs, ... }: {
    programs.syncthing = {
      enable = true;
      tray.enable = true;
    };
  };
}
