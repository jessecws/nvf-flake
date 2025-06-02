{
  config.vim = {
    statusline = {
      lualine = {
        enable = true;
        theme = "tokyonight";
        setupOpts = {
          options = {
            component_separators = {
              left = "";
              right = "";
            };
            section_separators = {
              left = "";
              right = "";
            };
            globalstatus = true;
          };
        };
      };
    };

    theme = {
      enable = true;
      name = "tokyonight";
      style = "night";
      transparent = true;
      extraConfig = ''
        vim.g.tokyonight_terminal_colors = true
        vim.g.tokyonight_style_comments = { italic = true }
        vim.g.tokyonight_style_keywords = { italic = true }
      '';
    };

    highlight = {
      LineNr = {
        fg = "#ffff00";
        bold = true;
      };
    };
  };
}
