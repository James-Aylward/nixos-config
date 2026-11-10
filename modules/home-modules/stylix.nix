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
      overlays.enable = false;
      targets.rofi.enable = false;
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
          #package = pkgs.dejavu_fonts;
          package = pkgs.nerd-fonts.iosevka;
          #name = "DejaVu Sans Mono";
          name = "Iosevka Nerd Font Mono";
        };
      };
    };
  };
}
