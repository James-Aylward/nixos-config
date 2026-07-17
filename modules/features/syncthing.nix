{inputs, ...}: {
  flake.nixosModules.syncthing = {
    pkgs,
    config,
    ...
  }: {
    services.syncthing = {
      enable = true;
      openDefaultPorts = true;
    };
  };
}
