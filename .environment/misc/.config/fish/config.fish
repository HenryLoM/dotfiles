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
    alias bb-sync    "bb-trust && bb-prune && bb-install"

    # Quick daemon runners
    alias nudge "brew services start"
    alias kick  "brew services restart"
    alias slap  "brew services stop"

    # Updated commands
        # default
    alias cd "z"
    alias ls "eza -lh --icons --time-style=+'%Y-%m-%d %H:%M'"
    alias cc "cc -std=c11 -Wall -Wextra -Wpedantic -Wconversion -Wshadow"
        # custom
    alias ef "exiftool -a -u -g2"
    alias ym 'yt-dlp -o "%(title)s.%(ext)s" --cookies-from-browser safari -f ba'
    alias yv 'yt-dlp -o "%(title)s.%(ext)s" --cookies-from-browser safari -f "bv*+ba/b"'

    # ==============================
    # Functions
    # ==============================

    # Metadata cleaner
    function clean-metadata
        for f in $argv; test -f "$f"; or return 1; end        # Forbid directories
        for f in $argv
            exiftool -all= -overwrite_original_in_place "$f"  # Generic metadata
            xattr -c "$f"                                     # macOS info
            SetFile -d (date '+%m/%d/%Y %H:%M:%S') "$f"       # Birth timestamp
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

    # Sync my dotfiles with .environment
    function sync-environment
            # Define paths
        set SRC "$HOME/.config"
        set DST "$HOME/.environment/misc/.config"
            # Ensure destination exists
        mkdir -p "$DST"
            # Sync dotfiles
        cp -f "$SRC/starship.toml" "$DST/starship.toml"
        for dir in fish rio skhd sketchybar borders fastfetch mpv
            rm -rf "$DST/$dir"
            cp -R  "$SRC/$dir" "$DST/$dir"
        end
    end

end
