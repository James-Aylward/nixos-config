_: {
  flake.homeModules.media = {
    pkgs,
    lib,
    config,
    ...
  }: {
    home.packages = with pkgs; [
      slskd
      beets
      yt-dlp
      imagemagick
    ];

    # Music daemon, with library as music dir
    services.mpd = {
      enable = true;
      musicDirectory = "${config.home.homeDirectory}/Music";
      extraConfig = ''
        audio_output {
          type "pipewire"
          name "PipeWire"
        }
      '';
    };

    # Exposes mpd over MPRIS so the media keys (dux-shell ipc mpris) control it
    services.mpd-mpris.enable = true;

    programs.rmpc = {
      enable = true;
      config = ''
        (
            theme: Some("gruvbox"),
        )
      '';
    };

    # rmpc's default theme, with its named terminal colours swapped for the
    # stylix gruvbox palette (so it stays in sync with the rest of the system)
    xdg.configFile."rmpc/themes/gruvbox.ron".source = let
      c = config.lib.stylix.colors.withHashtag;
    in
      pkgs.runCommand "rmpc-gruvbox.ron" {} ''
        ${lib.getExe pkgs.rmpc} theme | sed \
          -e 's/text_color: None/text_color: "${c.base05}"/' \
          -e 's/"black"/"${c.base00}"/g' \
          -e 's/"white"/"${c.base05}"/g' \
          -e 's/"blue"/"${c.base0D}"/g' \
          -e 's/"yellow"/"${c.base0A}"/g' \
          -e 's/"red"/"${c.base08}"/g' \
          -e 's/"light_green"/"${c.base0C}"/g' \
          -e 's/"green"/"${c.base0B}"/g' \
          -e 's/"magenta"/"${c.base0E}"/g' \
          > $out
      '';
  };
}
