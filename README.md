# 🛠️ Dotfiles & Rice

This repo exists to save the configuration and image of my working machine — so I can rebuild it later if needed. Feel free to use anything you need.

## 🌲 Directory structure

```
~\
│
├── README.md
├── LICENSE
├── .gitignore
├── result.png
│
├── .mylife\
│   ├── firefox-setup.txt  # user.js and extensions list
│   └── env\
│       ├── flake.lock
│       ├── flake.nix      # system setup
│       └── packages.nix   # list of packages to install system-wide
│
└── .config\...            # directories with configurations
```

## 🗺️ Instruction

1. Copy directories `.mylife` and `.config` into your home directory (`~`)
2. Run these commands:

   ```bash
   # Install Nix (if not already present)
   curl -L https://nixos.org/nix/install | sh

   # Apply darwin configuration (macOS)
   sudo nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/.mylife/env/#darwin
   ```

3. Later aliases from the fish config become available.

## 🐟 Customization from fish

###### Path hierarchy
1. `/run/current-system/sw/bin` — system-wide nix packages
2. `/opt/homebrew/bin` — system-wide homebrew packages (regulates via flake.nix)

###### Short nix commands

| Command | Purpose | Raw version |
|---------|---------|-------------|
| `nix-first-run` | Runs nix as for the first time | `sudo nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/.mylife/env/#darwin` |
| `nix-update` | Updates system-wide packages | `sudo darwin-rebuild switch --flake ~/.mylife/env/#darwin` |
| `nix-lock-update` | Updates packages in flake.lock | `sudo nix --extra-experimental-features "nix-command flakes" flake update --flake ~/.mylife/env` |
| `nix-cleanup` | Collects garbage and cache | `nix-collect-garbage` |

## 📸 Result
![result](result.png)
