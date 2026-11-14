_: {
  flake.homeModules.syncthing = _: {
    services.syncthing = {
      enable = true;
      tray.enable = true;
    };
  };
}
