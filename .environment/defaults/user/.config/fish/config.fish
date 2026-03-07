if status is-interactive

    # ==============================
    # Must do stuff
    # ==============================

    # Disable fish greeting
    set fish_greeting ""

    # Path hierarchy
    set -gx PATH                   \
        /opt/homebrew/bin          \
        $PATH

    # Disable auto-updates and env hints for nix-homebrew
    set -gx HOMEBREW_NO_AUTO_UPDATE 1
    set -gx HOMEBREW_NO_ENV_HINTS   1

    # Inits
    starship init fish | source
    zoxide   init fish | source

    # ==============================
    # Aliases
    # ==============================

    # Quick Brewfile management
    alias bb-update  "brew bundle --file=~/.environment/brew/Brewfile"
    alias bb-cleanup "brew bundle --file=~/.environment/brew/Brewfile --force cleanup"

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

    # Why not?
    alias woman "man"

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

    # Metadata cleaner
    function clean-metadata
            # macOS info
        xattr -c $argv
        xattr -rc $argv
            # Generic metadata
        exiftool -all= -overwrite_original $argv
        exiftool -all= -overwrite_original -r $argv
    end

    # Sync my dotfiles with .mylife
    function sync-environment
            # Define paths
        set SRC  "$HOME/.config"
        set DST  "$HOME/.environment/defaults/user/.config"
        set ENV  "$HOME/.environment"
        set REPO "$HOME/myprogs/Codeberg/dotfiles"
            # Sync dotfiles
        cp -f "$SRC/starship.toml" "$DST/starship.toml"
        for dir in yabai skhd sketchybar borders customs fish kitty fastfetch
            rm -rf "$DST/$dir"
            cp -R "$SRC/$dir" "$DST"
        end
    end

end

# ==============================
# External paths
# ==============================

fish_add_path $HOME/.config/customs/binaries                                      # custom binaries
fish_add_path "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/"  # "code" command
fish_add_path $HOME/.spicetify                                                    # spicetify
