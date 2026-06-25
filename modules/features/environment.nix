{ inputs, ... }: {
  flake.nixosModules.environment = { pkgs, ... }: {

    programs.neovim = {
      enable = true;
      defaultEditor = true;
    };

  };
}
