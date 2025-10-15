{pkgs, ...}: let
  # Create prettier config in Nix store
  prettierConfig = pkgs.writeText "prettierrc.json" (builtins.toJSON {
    proseWrap = "always";
    printWidth = 80;
    tabWidth = 2;
    useTabs = false;
  });
in {
  config.vim = {
    # Add formatters and linters as extra packages to ensure they're available in PATH
    extraPackages = with pkgs; [
      # Formatters
      alejandra # Nix
      shfmt # Bash/Shell
      clang-tools # C/C++ (includes clang-format)
      nodePackages.prettier # CSS, HTML, JS, TS, JSON, YAML, Markdown
      prettierd # Faster prettier daemon
      nodePackages.sql-formatter # SQL
      google-java-format # Java
      ktlint # Kotlin
      go # Go (includes gofmt)
      gotools # Go imports (goimports)
      stylua # Lua
      zig # Zig (includes zigfmt)
      isort # Python imports
      black # Python
      typstfmt # Typst
      rustfmt # Rust formatter
      taplo # TOML

      # Linters
      shellcheck # Bash/Shell
      ruff # Python
      golangci-lint # Go
      nodePackages.eslint_d # JS/TS (faster eslint daemon)
      hadolint # Dockerfile
      yamllint # YAML
      nodePackages.markdownlint-cli # Markdown
    ];
  };
}
