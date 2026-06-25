{
  self,
  lib,
  inputs,
  ...
}:
{
  flake.homeModules.shell = { pkgs, ... }: {

    imports = [
      self.homeModules.starship
    ];

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
      enable = true;
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

    home.packages = with pkgs; [
      git
      gh

      eza
      bat
      tree
      btop

      ripgrep
    ];

  };
}
