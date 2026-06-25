{ self, inputs, ... }: {
  flake.homeModules.myStarship = { pkgs, ... }: {

    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      presets = [
        "no-runtime-versions"
        "bracketed-segments"
        "nerd-font-symbols"
      ];
      settings = {
        aws = {
          symbol = " ";
          format = "\\[[\$symbol(\$profile)(\\(\$region\\))(\\[\$duration\\])]($style)\\]";
        };

        azure = {
          symbol = " ";
          format = "\\[[\$symbol(\$subscription)]($style)\\]";
        };

        battery = {
          full_symbol = "󰁹 ";
          charging_symbol = "󰂄 ";
          discharging_symbol = "󰂃 ";
          unknown_symbol = "󰂑 ";
          empty_symbol = "󰂎 ";
          format = "\\[[\$symbol\$percentage]($style)\\]";
        };

        buf = {
          symbol = " ";
          format = "\\[[\$symbol]($style)\\]";
        };

        bun = {
          symbol = " ";
          format = "\\[[\$symbol]($style)\\]";
        };

        c = {
          symbol = " ";
          format = "\\[[\$symbol(\$name)]($style)\\]";
        };

        cmake = {
          symbol = " ";
          format = "\\[[\$symbol]($style)\\]";
        };

        cobol = {
          symbol = " ";
          format = "\\[[\$symbol]($style)\\]";
        };

        conda = {
          symbol = " ";
          format = "\\[[\$symbol\$environment]($style)\\]";
        };

        container = {
          symbol = " ";
          format = "\\[[\$symbol \\[\$name\\]]($style)\\]";
        };

        cpp = {
          symbol = " ";
          format = "\\[[\$symbol(\$name)]($style)\\]";
        };

        crystal = {
          symbol = " ";
          format = "\\[[\$symbol]($style)\\]";
        };

        dart = {
          symbol = " ";
          format = "\\[[\$symbol]($style)\\]";
        };

        deno = {
          symbol = " ";
          format = "\\[[\$symbol]($style)\\]";
        };

        direnv = {
          symbol = " ";
          format = "\\[[\$symbol\$loaded/\$allowed]($style)\\]";
        };

        docker_context = {
          symbol = " ";
          format = "\\[[\$symbol\$context]($style)\\]";
        };

        dotnet = {
          symbol = " ";
          format = "\\[[\$symbol(🎯 \$tfm )]($style)\\]";
        };

        elixir = {
          symbol = " ";
          format = "\\[[\$symbol]($style)\\]";
        };

        elm = {
          symbol = " ";
          format = "\\[[\$symbol]($style)\\]";
        };

        erlang = {
          symbol = " ";
          format = "\\[[\$symbol]($style)\\]";
        };

        fennel = {
          symbol = " ";
          format = "\\[[\$symbol]($style)\\]";
        };

        fortran = {
          symbol = " ";
          format = "\\[[\$symbol]($style)\\]";
        };

        fossil_branch = {
          symbol = " ";
          format = "\\[[\$symbol\$branch]($style)\\]";
        };

        fossil_metrics = {
          format = "\\[[+\$added]($added_style)\\]\\[[-\$deleted]($deleted_style)\\]";
        };

        gcloud = {
          symbol = "󱇶 ";
          format = "\\[[\$symbol\$account(@\$domain)(\\(\$region\\))]($style)\\]";
        };

        git_branch = {
          symbol = " ";
          format = "\\[[\$symbol\$branch]($style)\\]";
        };

        git_commit = {
          tag_symbol = "  ";
          format = "\\[[\\(\$hash\$tag\\)]($style)\\]";
        };

        git_metrics = {
          format = "\\[[+\$added]($added_style)\\]\\[[-\$deleted]($deleted_style)\\]";
        };

        git_state = {
          format = "\\[[\$state (\$progress_current/\$progress_total)]($style)\\]";
        };

        git_status = {
          format = "([\\[\$all_status\$ahead_behind\\]]($style))";
        };

        gleam = {
          symbol = " ";
          format = "\\[[\$symbol]($style)\\]";
        };

        golang = {
          symbol = " ";
          format = "\\[[\$symbol]($style)\\]";
        };

        gradle = {
          symbol = " ";
          format = "\\[[\$symbol]($style)\\]";
        };

        guix_shell = {
          symbol = " ";
          format = "\\[[\$symbol]($style)\\]";
        };

        haskell = {
          symbol = " ";
          format = "\\[[\$symbol]($style)\\]";
        };

        haxe = {
          symbol = " ";
          format = "\\[[\$symbol]($style)\\]";
        };

        helm = {
          symbol = " ";
          format = "\\[[\$symbol]($style)\\]";
        };

        hg_branch = {
          symbol = " ";
          format = "\\[[\$symbol\$branch]($style)\\]";
        };

        hostname = {
          ssh_symbol = " ";
          format = "\\[[\$ssh_symbol(\$hostname)]($style)\\] ";
        };

        java = {
          symbol = " ";
          format = "\\[[\$symbol]($style)\\]";
        };

        jobs = {
          format = "\\[[\$symbol\$number]($style)\\]";
        };

        julia = {
          symbol = " ";
          format = "\\[[\$symbol]($style)\\]";
        };

        kotlin = {
          symbol = " ";
          format = "\\[[\$symbol]($style)\\]";
        };

        kubernetes = {
          symbol = "󱃾 ";
          format = "\\[[\$symbol\$context( \\(\$namespace\\))]($style)\\]";
        };

        localip = {
          format = "\\[[\$localipv4]($style)\\]";
        };

        lua = {
          symbol = " ";
          format = "\\[[\$symbol]($style)\\]";
        };

        maven = {
          symbol = " ";
          format = "\\[[\$symbol]($style)\\]";
        };

        memory_usage = {
          symbol = "󰍛 ";
          format = "\\[\$symbol[\$ram( | \$swap)]($style)\\]";
        };

        meson = {
          symbol = "󰔷 ";
          format = "\\[[\$symbol\$project]($style)\\]";
        };

        mise = {
          format = "\\[[\$symbol\$health]($style)\\]";
        };

        mojo = {
          symbol = "󰈸 ";
          format = "\\[[\$symbol]($style)\\]";
        };

        nats = {
          symbol = " ";
          format = "\\[[\$symbol\$name]($style)\\]";
        };

        netns = {
          symbol = "󰛳 ";
          format = "\\[[\$symbol \\[\$name\\]]($style)\\]";
        };

        nim = {
          symbol = " ";
          format = "\\[[\$symbol]($style)\\]";
        };

        nix_shell = {
          symbol = " ";
          format = "\\[[\$symbol]($style)\\]";
        };

        nodejs = {
          symbol = " ";
          format = "\\[[\$symbol]($style)\\]";
        };

        ocaml = {
          symbol = " ";
          format = "\\[[\$symbol(\\(\$switch_indicator\$switch_name\\))]($style)\\]";
        };

        odin = {
          symbol = "󰟢 ";
          format = "\\[[\$symbol]($style)\\]";
        };

        opa = {
          symbol = " ";
          format = "\\[[\$symbol]($style)\\]";
        };

        openstack = {
          symbol = " ";
          format = "\\[[\$symbol\$cloud(\\(\$project\\))]($style)\\]";
        };

        os = {
          format = "\\[[\$symbol]($style)\\]";

          symbols = {
            Ubuntu = " ";
            NixOS = " ";
            Arch = " ";
            Macos = " ";
            Windows = "󰍲 ";
            Linux = " ";
          };
        };

        package = {
          symbol = "󰏗 ";
          format = "\\[[\$symbol]($style)\\]";
        };

        perl = {
          symbol = " ";
          format = "\\[[\$symbol]($style)\\]";
        };

        php = {
          symbol = " ";
          format = "\\[[\$symbol]($style)\\]";
        };

        pijul_channel = {
          symbol = " ";
          format = "\\[[\$symbol\$channel]($style)\\]";
        };

        pixi = {
          symbol = "󰏗 ";
          format = "\\[[\$symbol(\$environment )]($style)\\]";
        };

        pulumi = {
          symbol = " ";
          format = "\\[[\$symbol\$stack]($style)\\]";
        };

        purescript = {
          symbol = " ";
          format = "\\[[\$symbol]($style)\\]";
        };

        python = {
          symbol = " ";
          format = "\\[[\${symbol}\${pyenv_prefix}(\\(\$virtualenv\\))]($style)\\]";
        };

        raku = {
          symbol = "󱖊 ";
          format = "\\[[\$symbol]($style)\\]";
        };

        red = {
          symbol = "󱍼 ";
          format = "\\[[\$symbol]($style)\\]";
        };

        rlang = {
          symbol = "󰟔 ";
          format = "\\[[\$symbol]($style)\\]";
        };

        ruby = {
          symbol = " ";
          format = "\\[[\$symbol]($style)\\]";
        };

        rust = {
          symbol = "󱘗 ";
          format = "\\[[\$symbol]($style)\\]";
        };

        scala = {
          symbol = " ";
          format = "\\[[\$symbol]($style)\\]";
        };

        shell = {
          format = "\\[[\$indicator]($style)\\]";
        };

        shlvl = {
          symbol = "󰹍 ";
        };

        singularity = {
          symbol = " ";
          format = "\\[[\$symbol\\[\$env\\]]($style)\\]";
        };

        solidity = {
          symbol = " ";
          format = "\\[[\$symbol]($style)\\]";
        };

        spack = {
          symbol = " ";
          format = "\\[[\$symbol\$environment]($style)\\]";
        };

        status = {
          symbol = " ";
          format = "\\[[\$symbol\$status]($style)\\]";
        };

        sudo = {
          symbol = " ";
          format = "\\[[as \$symbol]($style)\\]";
        };

        swift = {
          symbol = " ";
          format = "\\[[\$symbol]($style)\\]";
        };

        terraform = {
          symbol = " ";
          format = "\\[[\$symbol\$workspace]($style)\\]";
        };

        time = {
          format = "\\[[\$time]($style)\\]";
        };

        typst = {
          symbol = " ";
          format = "\\[[\$symbol]($style)\\]";
        };

        username = {
          format = "\\[[\$user]($style)\\]";
        };

        vagrant = {
          symbol = " ";
          format = "\\[[\$symbol]($style)\\]";
        };

        vcsh = {
          format = "\\[vcsh [\$symbol\$repo]($style)\\]";
        };

        vlang = {
          symbol = " ";
          format = "\\[[\$symbol]($style)\\]";
        };

        xmake = {
          symbol = " ";
          format = "\\[[\$symbol]($style)\\]";
        };

        zig = {
          symbol = " ";
          format = "\\[[\$symbol]($style)\\]";
        };

        directory = {
          read_only = " 󰌾";
        };
      };

    };
  };
}
