# Minimal Neovim
A modern, modular Neovim configuration optimized for productivity and aesthetics. Built with Lua.

![image](https://github.com/user-attachments/assets/dc73f007-d5e4-4b2f-a612-90b4789a68e0)
![image](https://github.com/user-attachments/assets/02c1a55d-516d-418f-939a-b892a185822b)
![image](https://github.com/user-attachments/assets/93563bef-2a8c-49d7-93e5-9b2c71a64cd5)


## Key Features
- **Lightning Fast** - Optimized startup with `lazy.nvim` plugin manager
- **Modular Design** - Clean, organized structure for easy maintenance
- **Themes** - Beautiful colorschemes with `nightfox` and easy switching
- **Completions** - Completions with `nvim-cmp`
- **Language Support** - Easy LSP management with `Mason`
- **Code Formatting** - Integrated formatting/linting via `none-ls`
- **Syntax Highlighting** - Enhanced highlighting with `Treesitter`
- **Fuzzy Search** - Powerful file navigation with `Telescope`
- **File Explorer** - Sidebar with `Neo-tree`
- **Status Line** - Informative `lualine`
- **Dashboard** - Startup screen with `alpha-nvim`
- **Discord Integration** - Show what you're coding with `presence.nvim`
- **Git Integration** - Visual git indicators with `gitsigns`
- **UI Enhancements** - Notifications and better cmdline with `noice.nvim`

## Project Structure

```sh
├── init.lua
├── lazy-lock.json
├── lua
│   ├── config
│   │   └── lazy.lua
│   ├── core
│   │   ├── keymaps.lua
│   │   ├── options.lua
│   │   └── theme.lua
│   └── plugins
│       ├── alpha-nvim.lua
│       ├── autopairs.lua
│       ├── colorizer.lua
│       ├── completions.lua
│       ├── gitsigns.lua
│       ├── lualine.lua
│       ├── mason.lua
│       ├── neotree.lua
│       ├── nightfox.lua
│       ├── noice.lua
│       ├── none-ls.lua
│       ├── presence.lua
│       ├── telescope.lua
│       └── treesitter.lua
├── README.md
```

## Installation

### Prerequisites
Ensure you have these installed first:
- [Neovim](https://github.com/neovim/neovim/releases)
- [Git](https://git-scm.com/downloads)
- [Node.js](https://nodejs.org/)
- [Nerd Font](https://www.nerdfonts.com/)

### 1. Backup existing config (if any)
```sh
mv ~/.config/nvim ~/.config/nvim.bak  # Optional backup
```

### 2. Clone and install
```sh
git clone https://github.com/gustavommcv/minimal-neovim ~/.config/nvim
```

### 3. Verify installation
Run health checks:
```vim
:checkhealth
```

## 🙏 Acknowledgments

Special thanks to:

- [Typecraft](https://www.youtube.com/@typecraft_dev) - For the excellent Neovim free course, thanks nerd! :)
- [LazyVim](https://www.lazyvim.org/) - Plugin organization concepts
- Neovim community for all the amazing plugins and support!
