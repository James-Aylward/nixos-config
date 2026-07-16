{
  config,
  pkgs,
  ...
}:

{
  flake.nixosModules.tex =
    {
      config,
      pkgs,
      ...
    }:
    let
      tex = pkgs.texlive.combine {
        inherit (pkgs.texlive)
          scheme-full
          pgf
          ec
          gensymb
          cm-super
          environ
          txfonts
          parskip
          pgfplots
          etoolbox
          stackengine
          advdate
          titlesec
          pdfpages
          biblatex
          biblatex-ieee
          pdflscape
          float
          microtype
          siunitx
          tcolorbox
          listings
          enumitem
          psnfss
          ;
      };
    in
    {
      programs.sioyek.enable = true;

      home.packages = [
        tex
      ];
    };
}
