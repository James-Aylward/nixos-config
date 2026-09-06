{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:denful/import-tree";
    stylix.url = "github:danth/stylix";
    zen-browser.url = "github:youwen5/zen-browser-flake";
    mathematica-old-pkgs.url = "github:nixos/nixpkgs/3d46470bb3030020f7e1361f33514854f5bfa86d";
    #niri.url = "github:sodiboo/niri-flake";
    niri.url = "github:epireyn/niri-flake";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} (inputs.import-tree ./modules);
}
