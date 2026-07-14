{
  ...
}:
{
  flake.homeModules.media = { pkgs, ... }: {
    programs.ncspot.enable = true;
  };
}
