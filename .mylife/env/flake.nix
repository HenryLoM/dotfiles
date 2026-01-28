# flake.nix
{
    description = "My CLI packages and macOS configuration";

    inputs = {
        # Must have
        nixpkgs.url                   = "github:NixOS/nixpkgs/nixpkgs-unstable";
        darwin.url                    = "github:LnL7/nix-darwin";
        darwin.inputs.nixpkgs.follows = "nixpkgs";
        nix-homebrew.url              = "github:zhaofengli/nix-homebrew";
        # Homebrew taps
        homebrew-core = {
            url   = "github:Homebrew/homebrew-core";
            flake = false;
        };
        homebrew-cask = {
            url   = "github:Homebrew/homebrew-cask";
            flake = false;
        };
        homebrew-bundle = {
            url = "github:Homebrew/homebrew-bundle";
            flake = false;
        };
        # Extra taps
        formulae-yabai-skhd = {
            url   = "github:koekeishiya/homebrew-formulae";
            flake = false;
        };
        formulae-sketchybar-borders = {
            url   = "github:felixkratz/homebrew-formulae";
            flake = false;
        };
        formulae-boringnotch = {
            url   = "github:TheBoredTeam/homebrew-boring-notch";
            flake = false;
        };
    };

    outputs = { self, darwin, nixpkgs, nix-homebrew, ... } @ inputs: let
        system = "aarch64-darwin";
        pkgs   = nixpkgs.legacyPackages.${system};

        configuration = { pkgs, config, ... }: {
            
            system.primaryUser = "henrylom";
            
            environment.systemPackages = import ./packages.nix { inherit pkgs; };    # system-wide packages
            fonts.packages = with pkgs; [ ubuntu-classic nerd-fonts.symbols-only ];  # system-wide fonts

            # ==============================
            # macOS UI tweaks
            # ==============================
            system.defaults = {
                dock = {
                    autohide          = true;   # hides dock
                    show-recents      = false;  # turns off "show suggested and recent in dock"
                    expose-group-apps = true;   # turns on  "group windows by application" in "mission control"
                };

                NSGlobalDomain = {
                    _HIHideMenuBar      = true;             # hides menu bar 
                    AppleInterfaceStyle = "Dark";           # sets "dark" in "appearance"
                    AppleShowScrollBars = "WhenScrolling";  # sets "when scrolling" in "show scroll bars" in "windows"
                };

                trackpad = {
                    Clicking = true;  # turns on "tap to click"
                };

                controlcenter = {
                    BatteryShowPercentage = true;  # shows percentage of the battery at the default menu bar
                };

                menuExtraClock = {
                    ShowAMPM = true;        # shows AM/PM in the clock at the default menu bar
                    ShowDate = 1;           # shows the date in the clock at the default menu bar
                    ShowDayOfMonth = true;  # shows the day of the month in the clock at the default menu bar
                };
            };

            # ==============================
            # Force persistent hostname
            # ==============================
            networking = {
                    hostName      = "hank";
                    localHostName = "hank";
                    computerName  = "Hank MacBook";
            };

            # ==============================
            # Nix Homebrew
            # ==============================
            nix-homebrew = {
                    enable        = true;
                    user          = "henrylom";
                    autoMigrate   = true;
                    enableRosetta = true;

                    taps = {
                        # Main
                        "homebrew/homebrew-core"   = inputs.homebrew-core;
                        "homebrew/homebrew-cask"   = inputs.homebrew-cask;
                        "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
                        # Extra
                        "koekeishiya/homebrew-formulae-yabai-skhd"         = inputs.formulae-yabai-skhd;
                        "koekeishiya/homebrew-formulae-sketchybar-borders" = inputs.formulae-sketchybar-borders;
                        "TheBoredTeam/homebrew-boring-notch"               = inputs.formulae-boringnotch;
                    };
                    mutableTaps = false;
            };

            # ==============================
            # Homebrew packages
            # ==============================
            homebrew = {
                    enable = true;
                    onActivation = {
                        autoUpdate = false;
                        upgrade    = false;
                        cleanup    = "zap";
                    };

                    brews = [
                        "yabai"            # Window Manager (WM)
                        "skhd"             # Shortcuts & Hotkeys
                        "sketchybar"       # Custom Menu Bar
                        "borders"          # Borders around windows
                        "mole"             # TUI system cleaner
                        "switchaudio-osx"  # CLI spund-source manager
                    ];

                    casks = [
                        "docker-desktop"  # Docker GUI
                        "iina"            # Video player
                        "sf-symbols"      # San-Francisco font support
                        "font-sf-mono"    # San-Francisco Mono font
                        "boring-notch"    # Island-like behavior utility
                        "hiddenbar"       # Hiding menu bar icons utility
                    ];
            };

            system.stateVersion = 5;
        };
    in {
        darwinConfigurations."darwin" = darwin.lib.darwinSystem {
            inherit system;
            modules = [
                    nix-homebrew.darwinModules.nix-homebrew
                    configuration
            ];
        };
    };
}
