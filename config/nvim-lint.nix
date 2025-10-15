{pkgs, ...}: {
  config.vim = {
    # Add nvim-lint as an extra plugin (NVF doesn't have native module yet)
    extraPlugins = with pkgs.vimPlugins; {
      nvim-lint.package = nvim-lint;
    };

    # Configure nvim-lint using luaConfigRC
    luaConfigRC.nvim-lint = ''
      local lint = require('lint')

      -- Configure linters per filetype
      lint.linters_by_ft = {
        -- Bash/Shell
        bash = { 'shellcheck' },
        sh = { 'shellcheck' },

        -- Python
        python = { 'ruff' },

        -- Go
        go = { 'golangcilint' },

        -- JavaScript/TypeScript
        javascript = { 'eslint_d' },
        typescript = { 'eslint_d' },
        javascriptreact = { 'eslint_d' },
        typescriptreact = { 'eslint_d' },

        -- Dockerfile
        dockerfile = { 'hadolint' },

        -- YAML
        yaml = { 'yamllint' },

        -- Markdown
        markdown = { 'markdownlint' },
      }

      -- Auto-lint on save, text change, and insert leave
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          local ok, err = pcall(lint.try_lint)
          if not ok then
            vim.notify("nvim-lint error: " .. tostring(err), vim.log.levels.ERROR)
          end
        end,
      })
    '';

    # Add keybinding for manual linting
    keymaps = [
      {
        key = "<leader>ll";
        mode = "n";
        action = "<cmd>lua require('lint').try_lint(); vim.notify('Linting triggered', vim.log.levels.INFO)<CR>";
        silent = true;
        desc = "Lint: Trigger linting for current buffer";
      }
    ];
  };
}
