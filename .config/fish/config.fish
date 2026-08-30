if status is-interactive

    # ==============================
    # Must do stuff
    # ==============================

    # Path hierarchy
        # Main
    fish_add_path -g /opt/homebrew/bin       # homebrew
    fish_add_path -g $HOME/.environment/bin  # custom binaries
        # External
    fish_add_path -g --append "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/"  # "code" command
    fish_add_path -g --append $HOME/.spicetify                                                    # spicetify

    # Disables
    set -g  fish_greeting              # fish greeting
    set -gx HOMEBREW_NO_AUTO_UPDATE 1  # homebrew auto-updating
    set -gx HOMEBREW_NO_ENV_HINTS   1  # homebrew hints

    # Inits
    starship init fish | source
    zoxide   init fish | source

    # ==============================
    # Aliases
    # ==============================

    # Quick Brewfile management
    alias bb-install "brew bundle --file=~/.environment/packages/Brewfile --force install"
    alias bb-prune   "brew bundle --file=~/.environment/packages/Brewfile --force cleanup"
    alias bb-trust   "source ~/.environment/packages/Trust-list"
    alias bb-sync    "bb-prune && bb-trust && bb-install"

    # Quick daemon runners
        # for brew
    alias nudge "brew services start"
    alias kick  "brew services restart"
    alias slap  "brew services stop"
        # for skhd
    alias skhd-nudge "skhd --start-service"
    alias skhd-kick  "skhd --restart-service"
    alias skhd-slap  "skhd --stop-service"

    # Updated commands
        # default
    alias cd "z"
    alias ls "eza -lh --icons --time-style=+'%Y-%m-%d %H:%M'"
    alias cc "cc -std=c11 -Wall -Wextra -Wpedantic -Wconversion -Wshadow"
        # custom
    alias ef "exiftool -a -u -g2"
    alias ym 'yt-dlp -f ba -o "%(title)s.%(ext)s"'
    alias yv 'yt-dlp -f "bv*+ba/b" -o "%(title)s.%(ext)s"'
        # shortcuts
    alias debian-cli "docker run --rm -it debian:latest bash"
    alias note       "toast ~/.mylife/archive/texts"

    # ==============================
    # Functions
    # ==============================

    # Old "sudo !!"" trick
    function sudo
        if test "$argv" = "!!"
            eval command sudo $history[1]
        else
            command sudo $argv
        end
    end

    # WebP convertor
    function wb
        cwebp -q 100 -m 6 $argv -o (string replace -r '\.(png|jpe?g)$' '.webp' $argv)
    end

    # Metadata cleaner
    function clean-metadata
        exiftool -all= -overwrite_original_in_place -r $argv           # Generic metadata
        xattr -rc $argv                                                # macOS info
        find $argv -exec SetFile -d (date '+%m/%d/%Y %H:%M:%S') {} \;  # Birth timestamp
    end

    # Audio cleaner
    function clean-audio
        for f in $argv
            set tmp (mktemp)
            set out "$tmp.mp3"
            ffmpeg -loglevel error -y -i "$f" \
                -map 0:a           \
                -map_metadata -1   \
                -map_chapters -1   \
                -vn -sn -dn        \
                -c:a copy          \
                -write_xing    0   \
                -id3v2_version 0   \
                -write_id3v1   0   \
                -fflags  +bitexact \
                -flags:a +bitexact \
                "$out"
            and mv -f "$out" "$f"
            or rm -f "$out"
        end
    end

    # SSH key creator
    function create-ssh
        if test (count $argv) -gt 0
            set keyfile "$HOME/.ssh/id_ed25519_$argv[1]"
        else
            set keyfile "$HOME/.ssh/id_ed25519"
        end
        ssh-keygen -t ed25519 -f $keyfile
    end

    # Sync my dotfiles with .mylife
    function sync-environment
            # Define paths
        set SRC "$HOME/.config"
        set DST "$HOME/.environment/misc/.config"
            # Ensure destination exists
        mkdir -p "$DST"
            # Sync dotfiles
        cp -f "$SRC/starship.toml" "$DST/starship.toml"
        for dir in skhd sketchybar borders fish kitty mpv fastfetch
            rm -rf "$DST/$dir"
            cp -R  "$SRC/$dir" "$DST/$dir"
        end
    end

end

fish_add_path /Users/henrylom/.spicetify
