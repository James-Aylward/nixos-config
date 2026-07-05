{
  perSystem = {pkgs, ...}: {
    packages.pidopen = pkgs.writeShellApplication {
      name = "pidopen";

      runtimeInputs = with pkgs; [
        alacritty
        jq
        niri
        procps
        coreutils
      ];

      text = ''
        set -euo pipefail

        window=$(niri msg --json focused-window)

        window_class=$(jq -r '.app_id' <<<"$window")

        if [[ "$window_class" != "Alacritty" ]]; then
          exec alacritty "$@"
        fi

        parent_pid=$(jq -r '.pid' <<<"$window")
        pid=$(pgrep -P "$parent_pid" | head -n1 || true)

        if [[ -n "$pid" ]] &&
           working_dir=$(readlink "/proc/$pid/cwd" 2>/dev/null); then
          exec alacritty --working-directory "$working_dir" "$@"
        else
          exec alacritty "$@"
        fi
      '';
    };
  };
}
