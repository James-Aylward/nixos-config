{
  self,
  lib,
  inputs,
  ...
}: {
  flake.homeModules.shell = {pkgs, ...}: {
    imports = [
      self.homeModules.myStarship
    ];

    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      silent = true;
      nix-direnv.enable = true;
    };

    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.yazi = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.neovim = {
      enable = false; # we want to use our own config
      defaultEditor = true;
    };

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      initContent = ''
        setopt ignore_eof
        ${lib.getExe pkgs.nitch}
      '';
    };

    home.shellAliases = {
      lg = "${lib.getExe pkgs.lazygit}";
    };

    programs.lazygit = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.btop.enable = true;
    programs.eza = {
      enable = true;
      enableZshIntegration = true;
    };
    programs.bat.enable = true;

    home.packages = with pkgs; [
      git
      gh
      neovim
      tree
      ripgrep
    ];
  };
}
