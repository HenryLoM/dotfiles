# flake.nix
{
    description = "My CLI packages and macOS configuration";

    inputs = {
        # Must have
        nixpkgs.url                   = "github:NixOS/nixpkgs/nixpkgs-unstable";
        darwin.url                    = "github:LnL7/nix-darwin";
        darwin.inputs.nixpkgs.follows = "nixpkgs";
        nix-homebrew.url              = "github:zhaofengli/nix-homebrew";

        # Brew
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
        # Brew taps
        formulae-yabai-skhd = {
            url   = "github:koekeishiya/homebrew-formulae";
            flake = false;
        };
        formulae-sketchybar-borders = {
            url   = "github:felixkratz/homebrew-formulae";
            flake = false;
        };
    };

    outputs = { self, darwin, nixpkgs, nix-homebrew, ... } @ inputs: let
        system = "aarch64-darwin";
        pkgs   = nixpkgs.legacyPackages.${system};

        configuration = { pkgs, config, ... }: {
            
            system.primaryUser = "henrylom";
            
            environment.systemPackages = import ./packages.nix { inherit pkgs; };

            # ==============================
            # macOS UI tweaks
            # ==============================
            system.defaults.dock.autohide                 = true;
            system.defaults.NSGlobalDomain._HIHideMenuBar = true;

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
                        "yabai"
                        "skhd"
                        "sketchybar"
                        "borders"
                        "switchaudio-osx"  # for sketchybar
                    ];

                    casks = [
                        "docker"
                        "iina"
                        "sf-symbols"
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
