if status is-interactive

    # ==============================
    # Must do stuff
    # ==============================

    # Disable fish greeting
    set fish_greeting ""

    # Nix: load daemon if it exists
    if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
        source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
    end

    # Path hierarchy
    set -gx PATH                   \
        /run/current-system/sw/bin \
        /opt/homebrew/bin          \
        $PATH
    
    # Golang path
    set -gx GOPATH $HOME/.cache/go

    # Disable auto-updates and env hints for nix-homebrew
    set -gx HOMEBREW_NO_AUTO_UPDATE 1
    set -gx HOMEBREW_NO_ENV_HINTS   1

    # Inits
    starship init fish | source
    zoxide   init fish | source

    # ==============================
    # Aliases
    # ==============================

    # Quick Nix management
    alias nix-first-run      'sudo nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/.mylife/env/#darwin'
    alias nix-update         "sudo darwin-rebuild switch --flake ~/.mylife/env/#darwin"
    alias nix-lock-update    'sudo nix --extra-experimental-features "nix-command flakes" flake update --flake ~/.mylife/env'
    alias nix-cleanup        "nix-collect-garbage"

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
    alias cdd "z"
    alias lss "eza -lh --icons"
    alias ccc "cc -std=c11 -Wall -Wextra -Wpedantic -Wconversion -Wshadow"

    # Debian VM
    alias debian-cli 'docker run --rm -it debian:latest bash'

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

    # Sync my dotfiles in repository
    function sync-dotfiles-repo
            # Sync environment directory with dotfiles repo (overwrite)
        rm -rf "/Users/henrylom/My programs/Codeberg/dotfiles/.mylife/env"
        cp -R "/Users/henrylom/.mylife/env" "/Users/henrylom/My programs/Codeberg/dotfiles/.mylife/env"
            # Define paths
        set SRC "/Users/henrylom/.config"
        set DST "/Users/henrylom/My programs/Codeberg/dotfiles/.config"
            # Ensure destination exists
        mkdir -p "$DST"
            # Directories to sync
        for dir in yabai skhd sketchybar borders customs fish kitty fastfetch
            rm -rf "$DST/$dir"
            cp -R "$SRC/$dir" "$DST/"
        end
            # Single file to sync
        cp -f "$SRC/starship.toml" "$DST/starship.toml"
    end

end

# ==============================
# External paths
# ==============================

fish_add_path $HOME/.config/customs/binaries                                      # custom binaries
fish_add_path "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/"  # "code" command
fish_add_path $HOME/.spicetify                                                    # spicefy
