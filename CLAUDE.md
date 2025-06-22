# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a NixOS Flake-based Neovim configuration using the [NVF (Neovim Flake)](https://github.com/notashelf/nvf) framework. It provides a declarative, reproducible Neovim setup with modular plugin management through Nix.

## Common Development Commands

### Build and Run
```bash
# Build the Neovim package
nix build

# Run directly without installing
nix run

# Install to user profile
nix profile install .
```

### Development Workflow
```bash
# Update flake inputs (nixpkgs, nvf)
nix flake update

# Check flake validity
nix flake check

# Show flake structure
nix flake show
```

## Architecture

The configuration follows a modular pattern:

1. **`flake.nix`** - Entry point that defines inputs (nixpkgs, nvf) and builds the Neovim package for multiple systems (x86_64/aarch64 Linux/Darwin)

2. **`config/default.nix`** - Central configuration hub that:
   - Imports all feature modules
   - Configures core vim settings (tabs, undo, search, clipboard)
   - Enables major features (LSP with format-on-save, treesitter, DAP debugger, telescope, git integration)
   - Sets up language support for 15+ languages

3. **Feature modules in `config/`** - Each file provides isolated configuration for specific features:
   - `avante.nix` - AI assistant integration (OpenAI, Claude, Gemini)
   - `theme.nix` - Tokyo Night theme and lualine statusline
   - `keymaps.nix` - Custom key bindings
   - `telescope-zoxide.nix`, `harpoon.nix` - Navigation tools
   - `oil.nix` - File manager
   - Other UI/utility modules

## Adding New Features

To add a new plugin or feature:
1. Create a new module file in `config/` (e.g., `config/my-feature.nix`)
2. Import it in `config/default.nix` under the imports list
3. Use `extraPlugins` for plugins not in NVF, or configure built-in NVF modules

Example module structure:
```nix
{
  config,
  lib,
  pkgs,
  ...
}: {
  # For NVF-supported features
  vim.someFeature.enable = true;
  
  # For custom plugins
  vim.extraPlugins = with pkgs.vimPlugins; [
    some-plugin
  ];
}
```

## Key Configuration Details

- **Theme**: Tokyo Night with transparency enabled
- **Undo files**: Stored in `~/.neovim/undodir`
- **Line numbers**: Highlighted in yellow
- **Column indicators**: At 80 and 160 characters
- **Clipboard**: System clipboard integration enabled
- **Format on save**: Enabled for all LSP-supported languages