# packages.nix
{ pkgs }:

with pkgs;

[
    # ==============================
    # Shell & Terminal
    # ==============================
    fish      # shell    𐃘 https://github.com/fish-shell/fish-shell
    kitty     # terminal 𐃘 https://github.com/kovidgoyal/kitty
    starship  # prompt   𐃘 https://github.com/starship/starship

    # ==============================
    # Commands
    # ==============================
    tree    # classic directory tree 𐃘 https://github.com/Old-Man-Programmer/tree
    fzf     # fuzzy search           𐃘 https://github.com/junegunn/fzf
    zoxide  # better "cd"            𐃘 https://github.com/ajeetdsouza/zoxide
    eza     # better "ls"            𐃘 https://github.com/eza-community/eza
    bat     # pretty code print      𐃘 https://github.com/sharkdp/bat

    # ==============================
    # TUI programs
    # ==============================
    vim   # complex code editor        𐃘 https://github.com/vim/vim
    nano  # simple text editor         𐃘 https://github.com/madnight/nano
    yazi  # file manager               𐃘 https://github.com/sxyazi/yazi
    kew   # music player               𐃘 https://github.com/ravachol/kew
    htop  # interactive process viewer 𐃘 https://github.com/htop-dev/htop
    gtop  # monitoring process viewer  𐃘 https://github.com/aksakalli/gtop

    # ==============================
    # CLI tools
    # ==============================
    git       # version contol               𐃘 https://github.com/git/git
    unar      # universal unarchiving tool   𐃘 https://github.com/ashang/unar
    exiftool  # meta-data reader + cleaner   𐃘 https://github.com/exiftool/exiftool
    i2pd      # Anonymous I2P network router 𐃘 https://github.com/PurpleI2P/i2pd

    # ==============================
    # Cool, why not
    # ==============================
    fastfetch  # system info print 𐃘 https://github.com/fastfetch-cli/fastfetch
    cmatrix    # matrix rain       𐃘 https://github.com/abishekvashok/cmatrix
    lolcat     # rainbow "cat"     𐃘 https://github.com/busyloop/lolcat
    pipes      # pipes screensaver 𐃘 https://github.com/pipeseroni/pipes.sh

    # ==============================
    # Programming
    # ==============================
        # python
    python314                     # python 3.14 interpreter
    python314Packages.pip         # package manager
    python314Packages.virtualenv  # virtual environment
    uv                            # package and project manager
    ruff                          # linter and code formatter
        # c
    clang     # c/c++ compiler
    cmake     # c build system
    cppcheck  # linter
        # rust
    rustc  # rust compiler
    cargo  # package manager
        # docker
    docker          # docker cli
    docker-compose  # compose for yaml files
        # misc
    go      # go compiler and toolchain
    nodejs  # node runtime
    php     # php server
]
