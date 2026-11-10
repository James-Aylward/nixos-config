{...}: {
  flake.nixosModules.tex = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      texliveFull
      texlab # language server
      rubber
      sioyek
    ];
  };
}
