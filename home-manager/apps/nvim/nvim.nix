{ pkgs, lib, ... }:
let
  packages = with pkgs; {
    tools = [
      fswatch
      fzf
      git
      sqlite
      tree-sitter
    ];

    c = [
      cmake
      gcc gnumake
    ];

    luaTools = [
      lua-language-server
      lua51Packages.lua
      lua51Packages.luarocks-nix
      stylua
    ];

    nix = [
      deadnix
      manix
      nixd
      nixfmt-rfc-style
      nixpkgs-lint-community
      statix
    ];

    python = [
      black
      isort
      python3Packages.jedi-language-server
      ruff
      ruff-lsp
    ];

    shell = [
      nodePackages.bash-language-server
      shellcheck
      shfmt
    ];

    web = [
      deno
      nodePackages.sql-formatter
      nodePackages.typescript-language-server
      nodejs
      prettierd # multi-language formatters
      vscode-langservers-extracted
      yarn
    ];
  };
  in
  {
  home.packages = [
    pkgs.nixpkgs-fmt
    pkgs.cargo
    pkgs.texliveFull
  ];

  programs.neovim = {
    enable = true;

    extraPackages = lib.pipe packages [
      (lib.mapAttrsToList (name: value: value))
      lib.flatten
    ];

    # Enable other frameworks for plugins.
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;

    # Setup aliasing.
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    # Using normal neovim config to allow reuse on other systems.
  };

  xdg.configFile."nvim".source = ./nvim;
}
