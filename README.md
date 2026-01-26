# Minimal Neovim

A modern, modular Neovim configuration optimized for productivity and aesthetics. Built with Lua.

<img width="2560" height="1440" alt="image" src="https://github.com/user-attachments/assets/27c1df7f-7fe2-4002-85bd-63b9c5f4f776" />

<img width="2560" height="1440" alt="image" src="https://github.com/user-attachments/assets/381828d2-f74e-4883-99b2-4a335cba24f2" />

## Project Structure

```sh
.
├── init.lua
├── lazy-lock.json
├── LICENSE
├── lua
│   ├── config
│   │   └── lazy.lua
│   ├── core
│   │   ├── keymaps.lua
│   │   ├── options.lua
│   │   └── theme.lua
│   └── plugins
│       ├── completions.lua
│       ├── lualine.lua
│       ├── mason.lua
│       ├── none-ls.lua
│       └── ...
├── README.md
└── undodir
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
