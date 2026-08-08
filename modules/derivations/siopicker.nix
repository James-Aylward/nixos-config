{
  perSystem = {pkgs, ...}: {
    packages.siopicker = pkgs.writeShellApplication {
      name = "siopicker";

      runtimeInputs = with pkgs; [
        fuzzel
        poppler-utils
        sioyek
        coreutils
        gnugrep
        gnused
        gawk
        neovim
      ];

      text = ''
        db="$HOME/.siopicker"

        if [ ! -e "$db" ]; then
            touch "$db"
        fi

        if [ $# -eq 0 ]; then
            tmpfile="$(mktemp)"

            max_title_len=0

            while IFS= read -r path; do
                [ -f "$path" ] || continue

                title="$(pdfinfo "$path" 2>/dev/null | sed -n 's/^Title:[[:space:]]*//p')"

                if [ -z "$title" ]; then
                    title="''${path##*/}"
                    title="''${title%.pdf}"
                fi

                len=''${#title}
                [ "$len" -gt "$max_title_len" ] && max_title_len=$len
            done < "$db"

            choice="$(
                while IFS= read -r path; do
                    [ -f "$path" ] || continue

                    title="$(pdfinfo "$path" 2>/dev/null | sed -n 's/^Title:[[:space:]]*//p')"

                    if [ -z "$title" ]; then
                        title="''${path##*/}"
                        title="''${title%.pdf}"
                    fi

                    display_path="''${path/#$HOME/\~}"

                    printf '%s\t%s\n' "$title" "$path" >> "$tmpfile"

                    printf "%-''${max_title_len}s\t%s\n" \
                        "$title" \
                        "$display_path"

                done < "$db" |
                sort -f |
                fuzzel --dmenu \
                    --mesg "Open document" \
                    --background-color=1d2021FF \
                    --text-color=ebdbb2FF \
                    --prompt-color=83a598FF \
                    --input-color=ebdbb2FF \
                    --placeholder-color=928374FF \
                    --message-color=d5c4a1FF \
                    --match-color=fe8019FF \
                    --selection-color=3c3836FF \
                    --selection-text-color=fbf1c7FF \
                    --selection-match-color=fe8019FF \
                    --border-color=b16286FF \
                    --border-width=4 \
                    --width=80 \
                    --line-height=20 \
                    --no-icons
            )"

            if [ -n "$choice" ]; then
                selected_title="$(printf '%s\n' "$choice" | cut -f1 | sed 's/[[:space:]]*$//')"

                path="$(awk -F '\t' -v title="$selected_title" '$1 == title {print $2; exit}' "$tmpfile")"

                [ -n "$path" ] && sioyek --new-window "$path"
            fi

            rm "$tmpfile"
            exit
        fi

        if [[ $1 == "add" && $# -eq 2 ]]; then
            path="$(realpath "$2")"

            grep -Fxq "$path" "$db" || echo "$path" >> "$db"
            exit
        fi

        if [[ $1 == "rm" ]]; then
            tmpfile="$(mktemp)"

            while IFS= read -r path; do
                [ -f "$path" ] || continue

                title="$(pdfinfo "$path" 2>/dev/null | sed -n 's/^Title:[[:space:]]*//p')"

                if [ -z "$title" ]; then
                    title="''${path##*/}"
                    title="''${title%.pdf}"
                fi

                display_path="''${path/#$HOME/\~}"

                printf '%s\t%s\n' \
                    "$title — $display_path" \
                    "$path" >> "$tmpfile"

            done < "$db"

            choice="$(
                cut -f1 "$tmpfile" |
                sort -f |
                fuzzel --dmenu \
                    --mesg "Remove document from siopicker" \
                    --background-color=1d2021FF \
                    --text-color=ebdbb2FF \
                    --prompt-color=83a598FF \
                    --input-color=ebdbb2FF \
                    --placeholder-color=928374FF \
                    --message-color=d5c4a1FF \
                    --match-color=fe8019FF \
                    --selection-color=3c3836FF \
                    --selection-text-color=fbf1c7FF \
                    --selection-match-color=fe8019FF \
                    --border-color=b16286FF \
                    --border-width=4 \
                    --width=80 \
                    --line-height=20 \
                    --no-icons
            )"

            if [ -n "$choice" ]; then
                path="$(awk -F '\t' -v choice="$choice" '$1 == choice {print $2}' "$tmpfile")"

                if [ -n "$path" ]; then
                    sed -i "\|$(printf '%s' "$path" | sed 's/[.[\*^$\\\/]/\\&/g')|d" "$db"
                fi
            fi

            rm "$tmpfile"
            exit
        fi

        if [[ $1 == "edit" ]]; then
            if command -v nvim >/dev/null 2>&1; then
                nvim "$db"
            else
                "$EDITOR" "$db"
            fi
            exit
        fi
      '';
    };
  };
}
