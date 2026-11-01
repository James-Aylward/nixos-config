{...}: {
  flake.homeModules.media = {pkgs, ...}: {
    programs.ncspot.enable = true;

    home.packages = with pkgs; [
      slskd
      beets
      yt-dlp
      imagemagick
    ];
  };
}
