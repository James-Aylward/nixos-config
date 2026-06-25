{inputs, ...}: {
  flake.nixosModules.environment = {pkgs, ...}: {
   # programs.zsh = {
   #   enable = true;
   #   autosuggestions.enable = true;
   #   enableCompletion = true;
   #   syntaxHighlighting.enable = true;
   # };

   # programs.zoxide = {
   #k   enable = true;
   #   enableZshIntegration = true;
   # };

    programs.neovim = {
      enable = true;
      defaultEditor = true;
    };

    #programs.git.enable = true;
    #programs.lazygit.enable = true;

    environment.systemPackages = with pkgs; [
      alacritty
   #   github-cli

   #   eza
   #   bat
   #   btop
    ];
  };
}
