{ inputs, ... }: {

  flake.nixosModules.office = { pkgs, ... }: {

    environment.systemPackages = [
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

  };

}
