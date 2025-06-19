# 🚀 Neovim Configuration

My personal Neovim setup.

![image](https://github.com/user-attachments/assets/42a3a73c-e61c-470c-9788-258df57abfbe)

## ✨ Key Features

- Modular and organized configuration
- Fast startup with lazy.nvim
- Smart completions with nvim-cmp
- Easy LSP management with Mason
- Efficient navigation with Telescope and Neo-tree
- Elegant themes with Nightfox
- Discord Rich Presence integration

## 🛠️ Plugin Stack

### Core
- [lazy.nvim](https://github.com/folke/lazy.nvim) - Plugin manager
- [mason.nvim](https://github.com/williamboman/mason.nvim) - LSP/formatter manager
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - LSP configuration

### UI
- [nightfox.nvim](https://github.com/EdenEast/nightfox.nvim) - Beautiful theme
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) - Status line
- [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) - File explorer
- [alpha-nvim](https://github.com/goolord/alpha-nvim) - Startup screen

### Productivity
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) - Fuzzy finder
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Syntax highlighting
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) - Autocompletion
- [null-ls.nvim](https://github.com/nvimtools/none-ls.nvim) - Formatters and linters

### Extras
- [presence.nvim](https://github.com/andweeb/presence.nvim) - Discord Rich Presence

## 📂 Project Structure

```sh
~/.config/nvim/
├── init.lua              # Entry point
├── lazy-lock.json        # Plugin versions
└── lua/
    ├── config/
    │   ├── lazy.lua      # lazy.nvim setup
    │   └── vim-options.lua # Vim options
    └── plugins/
        ├── alpha-nvim.lua       # Startup screen
        ├── completions.lua      # Autocompletion
        ├── discord-rich-presence.lua # Discord integration
        ├── lsp-config.lua       # LSP setup
        ├── lualine.lua          # Status line
        ├── neotree.lua          # File explorer
        ├── nightfox.lua         # Color theme
        ├── none-ls.lua          # Formatters/linters
        ├── telescope.lua        # Fuzzy finder
        └── treesitter.lua       # Syntax highlighting
```

## ⌨️ Key Bindings

| Key Binding    | Action                      | Related Plugin |
|----------------|-----------------------------|----------------|
| `<leader>ff`   | Find files                  | Telescope      |
| `<leader>fg`   | Live grep                   | Telescope      |
| `<C-p>`        | Find git files              | Telescope      |
| `<leader>e`    | Toggle Neo-tree             | Neo-tree       |
| `<leader>ca`   | Code actions (auto-import)  | LSP            |
| `<leader>gf`   | Format code                 | null-ls        |
| `<C-Space>`    | Trigger completions         | nvim-cmp       |

## ⚙️ Installation

### Prerequisites
Ensure you have these installed first:
- [Neovim 0.9+](https://github.com/neovim/neovim/releases)
- [Git](https://git-scm.com/downloads)
- [Node.js](https://nodejs.org/)
- [Nerd Font](https://www.nerdfonts.com/)

### 1. Backup existing config (if any)
```sh
mv ~/.config/nvim ~/.config/nvim.bak  # Optional backup
```

### 2. Clone and install
```sh
git clone https://github.com/gustavommcv/NeovimSettings.git ~/.config/nvim
nvim +LazyInstall
```

### 3. Install Language Servers
After Neovim launches:
```vim
:Mason
```
Then install recommended LSPs:
- lua_ls (for Lua config files)
- tsserver (for JavaScript/TypeScript)
- Any other language servers you need

### 4. Verify installation
Run health checks:
```vim
:checkhealth
```

## 🙏 Acknowledgments

Special thanks to:

- [Typecraft](https://www.youtube.com/@typecraft_dev) - For the excellent Neovim free course, thanks nerd! :)
- [LazyVim](https://www.lazyvim.org/) - Plugin organization concepts
- Neovim community for all the amazing plugins and support!
# minimal-neovim
