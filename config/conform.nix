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
    # Add conform.nvim as an extra plugin for formatting
    extraPlugins = with pkgs.vimPlugins; {
      conform-nvim.package = conform-nvim;
    };

    # Configure conform.nvim using luaConfigRC
    luaConfigRC.conform-nvim = ''
      require('conform').setup({
        -- Format on save configuration
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },

        -- Configure formatters per filetype
        formatters_by_ft = {
          -- Nix
          nix = { 'alejandra' },

          -- Bash/Shell
          bash = { 'shfmt' },
          sh = { 'shfmt' },

          -- C/C++
          c = { 'clang-format' },
          cpp = { 'clang-format' },

          -- CSS
          css = { 'prettierd', 'prettier', stop_after_first = true },
          scss = { 'prettierd', 'prettier', stop_after_first = true },

          -- HTML
          html = { 'prettierd', 'prettier', stop_after_first = true },

          -- SQL
          sql = { 'sql-formatter' },

          -- Java
          java = { 'google-java-format' },

          -- Kotlin
          kotlin = { 'ktlint' },

          -- TypeScript/JavaScript
          typescript = { 'prettierd', 'prettier', stop_after_first = true },
          javascript = { 'prettierd', 'prettier', stop_after_first = true },
          typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
          javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
          json = { 'prettierd', 'prettier', stop_after_first = true },

          -- Go
          go = { 'gofmt', 'goimports' },

          -- Lua
          lua = { 'stylua' },

          -- Zig
          zig = { 'zigfmt' },

          -- Python
          python = { 'isort', 'black' },

          -- Typst
          typst = { 'typstfmt' },

          -- Rust - rustfmt is typically called via LSP
          rust = { 'rustfmt' },

          -- Additional common formats
          -- Using prettier with custom config for line wrapping
          markdown = { 'prettier' },
          yaml = { 'prettier' },
          toml = { 'taplo' },
        },

        -- Customize specific formatters
        formatters = {
          black = {
            prepend_args = { '--fast' },
          },
          shfmt = {
            prepend_args = { '-i', '2', '-ci' },
          },
          prettier = {
            -- Override default args to include our config
            args = { '--config', '${prettierConfig}', '--stdin-filepath', '$FILENAME' },
          },
          -- prettierd doesn't support --config well, so we'll rely on prettier
        },
      })
    '';

    # Add keybinding for manual formatting
    keymaps = [
      {
        key = "<leader>lf";
        mode = ["n" "v"];
        action = "<cmd>lua require('conform').format({ async = true, lsp_fallback = true }); vim.notify('Formatting triggered', vim.log.levels.INFO)<CR>";
        silent = true;
        desc = "Format: Format buffer or range";
      }
    ];
  };
}
