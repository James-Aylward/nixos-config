{
  perSystem = {pkgs, ...}: {
    packages.libron = pkgs.stdenvNoCC.mkDerivation rec {
      pname = "libron";
      version = "0.32";

      # Libron_H is the ttfautohint-hinted build the project recommends for Linux.
      src = pkgs.fetchzip {
        url = "https://github.com/nicoverbruggen/libron/releases/download/v${version}/Libron_H.zip";
        hash = "sha256-nFFJsGLqFW3EQexDBdQUbzYZsHQf1zjiYsZNAP7XRos=";
        stripRoot = false;
      };

      installPhase = ''
        runHook preInstall
        install -Dm444 -t $out/share/fonts/truetype *.ttf
        runHook postInstall
      '';

      meta = {
        description = "Font revision of Readerly optimized for digital reading";
        homepage = "https://github.com/nicoverbruggen/libron";
        license = pkgs.lib.licenses.ofl;
        platforms = pkgs.lib.platforms.all;
      };
    };
  };
}
