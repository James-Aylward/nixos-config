{
  description = "A simple script";

  outputs = { self, nixpkgs }: {
    defaultPackage.x86_64-linux = self.packages.x86_64-linux.my-script;

    packages.x86_64-linux.my-script =
      let
        pkgs = import nixpkgs { system = "x86_64-linux"; };
      in
      pkgs.writeShellScriptBin "my-script" ''
            window_class = $(niri msg --json focused-window | jq -r '.app_id')
        if [[ "$window_class" != "Alacritty" ]]; then
            alacritty
            exit 0
        fi

        parent_pid=$(hyprctl activewindow | grep pid | awk '{print $2}')
        echo $parent_pid is parent pid
        pid=$(pgrep -P $parent_pid | head -n 1)

        # Check if pid is empty
        if [ -z "$pid" ]; then
            alacritty
        else
            working_dir=$(readlink /proc/$pid/cwd)
            alacritty --working-directory $working_dir
        fi
      '';
  };
}
