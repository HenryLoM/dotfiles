# 🛠️ Dotfiles & Rice

This repo exists to save the configuration and image of my working machine — so I can rebuild it later if needed. Feel free to use anything you need.

> 🍺 I moved from Nix package manager back to Brew (and its Brewfile) because of the complexity Nix was bringing to the system.

## 🌲 Directory structure

```
~/
│
├── README.md
├── LICENSE
├── .gitignore
├── result.png
│
├── .environment/
│   ├── instructions.txt   # all the necessary instructions
│   ├── firefox-setup.txt  # user.js and extensions list
│   ├── defaults/...       # system-wide & user files/binaries/wallpapers
│   ├── brew/...           # brew-based environment — brewfile
│   └── nix/...            # nix-based environment — flake
│
└── .config/...            # directories with configurations
```

## 🗺️ Instruction

1. Copy directories `.environment` and `.config` into your home directory (`~`)
2. Run these commands:

    ```bash
    # Install Brew (if not already present)
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.bashrc
    eval "$(/opt/homebrew/bin/brew shellenv)"

    # Move to the necessary directory
    cd ~/.environment/brew/

    # Apply bundle (Brewfile) configuration & Remove odd binaries
    brew bundle install
    brew bundle cleanup --global --force
    ```

3. Later aliases from the fish config become available.

## 🐟 Customization from Fish

###### Path hierarchy
1. `/opt/homebrew/bin`               — system-wide homebrew packages
2. `$HOME/.environment/defaults/bin` — custom binaries I compiled and stored myself

###### Short brew commands

| Command | Purpose | Raw version |
|---------|---------|-------------|
| `bb-update`  | Updates binaries according to the Brewfile      | `brew bundle --file=~/.environment/brew/Brewfile` |
| `bb-cleanup` | Removes binaries that are not from the Brewfile | `brew bundle --file=~/.environment/brew/Brewfile --force cleanup` |
| `nudge`      | Starts a daemon                                 | `brew services start` |
| `kick`       | Restarts a daemon                               | `brew services restart` |
| `slap`       | Stops a daemon                                  | `brew services stop` |

## 📸 Result
![result](result.png)
