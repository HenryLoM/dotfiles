# packages.nix
{ pkgs }:

with pkgs;

[
    # ==============================
    # Programs
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
    bat     # pretty print of a code 𐃘 https://github.com/sharkdp/bat

    # ==============================
    # TUI apps
    # ==============================
    vim   # complex code editor 𐃘 https://github.com/vim/vim
    nano  # simple text editor  𐃘 https://github.com/madnight/nano
    yazi  # file manager        𐃘 https://github.com/sxyazi/yazi
    kew   # music player        𐃘 https://github.com/ravachol/kew
    htop  # process viewer      𐃘 https://github.com/htop-dev/htop

    # ==============================
    # CLI tools
    # ==============================
    git       # version contol             𐃘 https://github.com/git/git
    unar      # universal unarchiving tool 𐃘 https://github.com/ashang/unar
    exiftool  # meta-data reader + cleaner 𐃘 https://github.com/exiftool/exiftool

    # ==============================
    # Cool, why not
    # ==============================
    fastfetch  # system info print 𐃘 https://github.com/fastfetch-cli/fastfetch
    cmatrix    # matrix rain       𐃘 https://github.com/abishekvashok/cmatrix
    lolcat     # rainbow "cat"     𐃘 https://github.com/busyloop/lolcat

    # ==============================
    # Programming
    # ==============================
        # python
    python314                     # python 3.14 interpreter
    python314Packages.pip         # pip
    python314Packages.virtualenv  # venv
    uv                            # python package and project manager
    ruff                          # python linter and code formatter
        # c
    clang     # c/c++ compiler
    cmake     # c build system
    cppcheck  # c linter
        # docker
    docker          # docker cli
    docker-compose  # compose for yaml files
]
