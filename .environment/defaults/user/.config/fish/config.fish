if status is-interactive

    # ==============================
    # Must do stuff
    # ==============================

    # Path hierarchy
        # Main
    fish_add_path -g /opt/homebrew/bin                # homebrew
    fish_add_path -g $HOME/.environment/defaults/bin  # custom binaries
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
    alias bb-install "brew bundle --file=~/.environment/brew/Brewfile"
    alias bb-prune   "brew bundle --file=~/.environment/brew/Brewfile --force cleanup"
    alias bb-sync    "bb-prune && bb-install"

    # Quick daemon runners
        # for brew
    alias nudge "brew services start"
    alias kick  "brew services restart"
    alias slap  "brew services stop"
        # for yabai
    alias ynudge "yabai --start-service"
    alias ykick  "yabai --restart-service"
    alias yslap  "yabai --stop-service"
        # for skhd
    alias snudge "skhd --start-service"
    alias skick  "skhd --restart-service"
    alias sslap  "skhd --stop-service"

    # Updated default commands
    alias cd "z"
    alias ls "eza -lh --icons"
    alias cc "cc -std=c11 -Wall -Wextra -Wpedantic -Wconversion -Wshadow"

    # Debian VM
    alias debian-cli "docker run --rm -it debian:latest bash"

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

    # Metadata cleaner
    function clean-metadata
            # Generic metadata
        exiftool -all= -overwrite_original    $argv
        exiftool -all= -overwrite_original -r $argv
            # macOS info
        xattr -c  $argv
        xattr -rc $argv
    end

    # Audio cleaner
    function clean-audio
        for f in $argv
            set out (string replace -r '\.mp3$' '_cleaned.mp3' -- "$f")
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
        end
    end

    # Sync my dotfiles with .mylife
    function sync-environment
            # Define paths
        set SRC  "$HOME/.config"
        set DST  "$HOME/.environment/defaults/user/.config"
            # Ensure destination exists
        mkdir -p "$DST"
            # Sync dotfiles
        cp -f "$SRC/starship.toml" "$DST/starship.toml"
        for dir in yabai skhd sketchybar borders fish kitty mpv fastfetch
            rm -rf "$DST/$dir"
            cp -R  "$SRC/$dir" "$DST/$dir"
        end
    end

end
