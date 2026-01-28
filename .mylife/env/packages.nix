# packages.nix
{ pkgs }:

with pkgs;

[
    # ==============================
    # Programs
    # ==============================
    fish      # shell
    kitty     # terminal
    starship  # prompt

    # ==============================
    # Commands
    # ==============================
    tree    # classic directory tree
    fzf     # fuzzy search
    zoxide  # better "cd"
    eza     # better "ls"
    bat     # pretty print of a code
    lolcat  # rainbow "cat"

    # ==============================
    # TUI apps
    # ==============================
    vim   # complex code editor
    nano  # simple text editor
    yazi  # file manager
    kew   # music player

    # ==============================
    # CLI tools
    # ==============================
    git       # version contol
    unar      # universal unarchiving tool
    exiftool  # meta-data reader + cleaner

    # ==============================
    # Cool, why not
    # ==============================
    fastfetch  # system info print
    cmatrix    # matrix rain

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
