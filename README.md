# Neovim Flake Configuration

This project provides a modular, reproducible Neovim configuration using
[Nix flakes](https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-flake.html)
and [NVF](https://github.com/notashelf/nvf).

## Features

- **Reproducible builds**: All plugins and settings are managed declaratively
  with Nix.
- **Modular configuration**: Each feature or plugin is configured in its own
  file under `config/`.
- **Easy extensibility**: Add or override plugins and settings with minimal
  effort.
- **Multi-platform**: Works on Linux and macOS (Darwin) systems.
- **Modern Neovim**: Includes LSP, Treesitter, Telescope, and many popular
  plugins.
- **AI Integration**: Out-of-the-box support for Avante.nvim with OpenAI,
  Claude, and Gemini models.

## Usage

### Prerequisites

- [Nix](https://nixos.org/download.html) (with flakes enabled)
- [NVF](https://github.com/notashelf/nvf) as a flake input (handled
  automatically)
- Neovim 0.9+ (managed by the flake)

### Build and Run

1. **Clone this repository:**
   ```sh
   git clone <your-repo-url>
   cd <your-repo>
   ```

---

Here’s a detailed comparison of your **nixvim** plugin list versus your current
**nvf** configuration (based on the provided config files). I’ll highlight
what’s **missing or not directly mapped** in your nvf setup, and note any
differences in approach.

---

## 1. Plugins Present in Both (or Equivalent)

| Nixvim Plugin      | Present in NVF? | Notes                                                                   |
| ------------------ | --------------- | ----------------------------------------------------------------------- |
| lualine            | Yes             | `config/theme.nix` (statusline.lualine)                                 |
| dap                | Yes             | `config/default.nix` (debugger.nvim-dap.enable)                         |
| dap-ui             | Yes             | `config/default.nix` (debugger.nvim-dap.ui.enable)                      |
| friendly-snippets  | Yes             | `config/default.nix` (snippets.luasnip.enable)                          |
| treesitter         | Yes             | `config/default.nix` (languages.enableTreesitter)                       |
| undotree           | Yes             | `config/undotree.nix`                                                   |
| fugitive           | Yes             | `config/default.nix` (git.enable, gitsigns.enable, fugitive via keymap) |
| indent-blankline   | Yes             | `config/default.nix` (visuals.indent-blankline.enable)                  |
| todo-comments      | Yes             | `config/default.nix` (notes.todo-comments.enable)                       |
| gitsigns           | Yes             | `config/default.nix` (git.gitsigns.enable)                              |
| nvim-autopairs     | Yes             | `config/default.nix` (autopairs.nvim-autopairs.enable)                  |
| treesitter-context | Yes             | `config/default.nix` (treesitter.context.enable)                        |
| project-nvim       | Yes             | `config/default.nix` (projects.project-nvim.enable)                     |
| vim-surround       | Yes             | `config/default.nix` (utility.surround.enable)                          |
| markdown-preview   | Yes             | `config/default.nix` (utility.preview.markdownPreview.enable)           |
| comment-nvim       | Yes             | `config/default.nix` (comments.comment-nvim.enable)                     |
| todo-comments      | Yes             | `config/default.nix` (notes.todo-comments.enable)                       |
| nvim-bqf           | Yes             | `config/bqf.nix` (extraPlugins)                                         |

---

## 2. Plugins **Missing** or **Not Directly Mapped** in NVF

| Nixvim Plugin    | Present in NVF? | Notes/Recommendation                                                     |
| ---------------- | --------------- | ------------------------------------------------------------------------ |
| git-worktree     | **Partial**     | Telescope git worktree keymap exists, but plugin not explicitly enabled. |
| tmux-navigator   | **No**          | Not present. Add to `utility` or as an extra plugin.                     |
| ts-autotag       | **No**          | Not present. Add to `languages` or as an extra plugin.                   |
| emmet            | **No**          | Not present. Add to `languages` or as an extra plugin.                   |
| lsp-format       | **No**          | You have `lsp.formatOnSave = true;` but not the `lsp-format` plugin.     |
| mini             | **No**          | Not present. Add as a plugin/module if you want `mini.nvim` features.    |
| csv-vim          | **No**          | Not present. Add to `utility` or as an extra plugin.                     |
| html5-vim        | **No**          | Not present. Add to `utility` or as an extra plugin.                     |
| telescope-zoxide | **No**          | Not present. Add to `telescope` extensions or as an extra plugin.        |
| vim-jsx-pretty   | **No**          | Not present. Add to `languages` or as an extra plugin.                   |
| vim-sleuth       | **No**          | Not present. Add to `utility` or as an extra plugin.                     |
| nvim-neoclip-lua | **No**          | Commented out in your list, but not present in NVF config.               |

| Plugin           | GitHub/Upstream Repo Link                         |
| ---------------- | ------------------------------------------------- |
| nvim-bqf         | https://github.com/kevinhwang91/nvim-bqf          |
| git-worktree     | https://github.com/ThePrimeagen/git-worktree.nvim |
| tmux-navigator   | https://github.com/christoomey/vim-tmux-navigator |
| ts-autotag       | https://github.com/windwp/nvim-ts-autotag         |
| emmet            | https://github.com/mattn/emmet-vim                |
| lsp-format       | https://github.com/lukas-reineke/lsp-format.nvim  |
| mini             | https://github.com/echasnovski/mini.nvim          |
| csv-vim          | https://github.com/chrisbra/csv.vim               |
| html5-vim        | https://github.com/othree/html5.vim               |
| telescope-zoxide | https://github.com/jvgrootveld/telescope-zoxide   |
| vim-jsx-pretty   | https://github.com/maxmellon/vim-jsx-pretty       |
| vim-sleuth       | https://github.com/tpope/vim-sleuth               |
| nvim-neoclip-lua | https://github.com/AckslD/nvim-neoclip.lua        |

---

## 3. Other Notes

- **Neo-tree vs nvim-tree:**\
  You have `neo-tree` enabled, which is a more modern file explorer than
  `nvim-tree`. If you specifically want `nvim-tree`, you need to add it.

- **Mini.nvim:**\
  This is a meta-plugin with many modules. If you want its features, you’ll need
  to add and configure it explicitly.

- **Telescope Extensions:**\
  You have `telescope` enabled, but not all extensions (like `zoxide`) are
  present.

- **LSP Format:**\
  You have formatting on save, but not the `lsp-format` plugin, which provides
  more granular control.

- **Extra Plugins:**\
  Several plugins from your `extraPlugins` list are not present in the NVF
  config.

---

## 4. **Summary Table**

| Plugin           | Present in NVF? | Action Needed?      |
| ---------------- | --------------- | ------------------- |
| nvim-tree        | No              | Add if needed       |
| nvim-bqf         | No              | Add if needed       |
| git-worktree     | Partial         | Add plugin for full |
| tmux-navigator   | No              | Add if needed       |
| ts-autotag       | No              | Add if needed       |
| emmet            | No              | Add if needed       |
| lsp-format       | No              | Add if needed       |
| mini             | No              | Add if needed       |
| csv-vim          | No              | Add if needed       |
| html5-vim        | No              | Add if needed       |
| telescope-zoxide | No              | Add if needed       |
| vim-jsx-pretty   | No              | Add if needed       |
| vim-sleuth       | No              | Add if needed       |
| nvim-neoclip-lua | No              | Add if needed       |

---

## 5. **How to Add Missing Plugins in NVF**

- For plugins with NVF support, add to the appropriate section (e.g., `utility`,
  `languages`, `filetree`, etc.).
- For others, use `extraPlugins` in your config module, e.g.:
  ```nix
  extraPlugins = with pkgs.vimPlugins; [
    nvim-bqf
    tmux-navigator
    ts-autotag
    emmet-vim
    lsp-format-nvim
    mini-nvim
    csv-vim
    html5-vim
    telescope-zoxide
    vim-jsx-pretty
    vim-sleuth
    nvim-neoclip-lua
  ];
  ```

---

## 6. **Conclusion**

**Your NVF config covers most core functionality, but you are missing several
plugins from your old nixvim config.**\
If you want full parity, you should add the missing plugins as shown above.

Would you like a ready-to-paste Nix block to add all the missing plugins to your
NVF config? Or do you want to discuss any plugin in detail?
