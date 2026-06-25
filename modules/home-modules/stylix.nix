{
  self,
  lib,
  ...
}: {
  flake.homeModules.stylixConfig = {
    pkgs,
    config,
    ...
  }: {
    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
      polarity = "dark";
      fonts = {
        serif = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "DejaVu Serif";
        };

        sansSerif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Sans";
        };

        monospace = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Sans Mono";
        };
      };
    };
  };
}
