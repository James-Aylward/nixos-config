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
      shellWrapperName = "y"; # silence state version change
      plugins = with pkgs.yaziPlugins; {
        ouch.package = ouch;
        bookmarks.package = bookmarks;
        full-border = {
          package = full-border;
          setup = true;
        };
      };
      keymap = {
        mgr.prepend_keymap = [
          {
            on = ["m"];
            run = "plugin bookmarks save";
          }
          {
            on = ["'"];
            run = "plugin bookmarks jump";
          }
          {
            on = [
              "b"
              "d"
            ];
            run = "plugin bookmarks delete";
          }
          {
            on = [
              "b"
              "D"
            ];
            run = "plugin bookmarks delete_all";
          }
        ];
      };
    };

    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    home.sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      # EDITOR=nvim would otherwise make zsh default to vi keybindings
      defaultKeymap = "emacs";

      initContent = ''
        setopt ignore_eof
        ${lib.getExe pkgs.nitch}
      '';
    };

    programs.delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        navigate = true;
        line-numbers = true;
        side-by-side = false;
        syntax-theme = "gruvbox-dark";

        # gruvbox-tinted backgrounds for added/removed lines
        minus-style = "syntax #3c1f1e";
        minus-emph-style = "syntax #6b2b27";
        plus-style = "syntax #32361a";
        plus-emph-style = "syntax #4f5a1f";

        line-numbers-minus-style = "#fb4934";
        line-numbers-plus-style = "#b8bb26";
        line-numbers-zero-style = "#7c6f64";
        file-style = "bold #fabd2f";
        hunk-header-style = "file line-number syntax";
        hunk-header-decoration-style = "#504945 box";
      };
    };

    programs.lazygit = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        git.diffRenderers = [
          {
            command = "delta --dark --paging=never";
          }
        ];
      };
    };

    programs.btop.enable = true;
    programs.eza = {
      enable = true;
      enableZshIntegration = true;
    };
    programs.bat.enable = true;

    home.packages = with pkgs; [
      file
      gcc
      gh
      git
      killall
      moreutils
      gdu
      bandwhich
      neovim
      pwgen
      ripgrep
      shfmt
      tldr
      tree
      unzip
      usbutils
      zip
    ];
  };
}
