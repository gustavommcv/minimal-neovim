# Installation

## Prerequisites

See the [requirements list in the README](../README.md#requirements) for what
each dependency is for. Below is how to get them per OS.

### Linux (Debian/Ubuntu example; adjust for your package manager)

```sh
sudo apt install git ripgrep clang
# Neovim >= 0.12: your distro's repo may lag behind; the AppImage or a
# release tarball from https://github.com/neovim/neovim/releases is the
# most reliable way to get 0.12+.
npm install -g tree-sitter-cli   # or: cargo install tree-sitter-cli
```

### Arch Linux

```sh
sudo pacman -S neovim git ripgrep tree-sitter-cli
sudo pacman -S gcc     # or: sudo pacman -S clang
```

Everything needed is in the official `extra`/`core` repos and tracks current
upstream releases closely — checked directly against the Arch package
database while writing this: `neovim` 0.12.4, `git` 2.55.0, `ripgrep`
15.2.0, `tree-sitter-cli` 0.26.9, `clang` 22.1.8, `gcc` 16.1.1. No AUR
package is required for anything in the requirements list. `gcc` is usually
already pulled in by `base-devel` if you have that installed; either
compiler works, pick whichever you already have.

### macOS

```sh
brew install neovim git ripgrep
brew install llvm            # or use Xcode's clang (xcode-select --install)
npm install -g tree-sitter-cli
```

### Windows

```powershell
winget install Neovim.Neovim
winget install Git.Git
winget install BurntSushi.ripgrep.MSVC
winget install tree-sitter.tree-sitter-cli
```

You also need a C compiler. Either of these works:

```powershell
winget install LLVM.LLVM
# or, if you already have Visual Studio Build Tools / MSVC, use that instead
```

Install tree-sitter-cli from the winget package above, **not** via
`npm install -g tree-sitter-cli`: on Windows, npm installs it as a `.cmd`
shim, and Neovim's process spawner cannot invoke that shim (fails with
`ENOENT` when `nvim-treesitter` tries to compile a parser) — confirmed while
building this config. The winget package is a native `.exe` and works.

Neovim on Windows resolves `stdpath("config")` to `%LOCALAPPDATA%\nvim`,
`stdpath("data")`/`stdpath("state")` to `%LOCALAPPDATA%\nvim-data`, and
`stdpath("cache")` to `%LOCALAPPDATA%\Temp\nvim` (verified directly against
a real Neovim 0.12 install — the cache directory is *not* under
`nvim-data`).

## Backing up an existing configuration

```sh
mv ~/.config/nvim ~/.config/nvim.bak            # Linux/macOS
```

```powershell
Rename-Item "$env:LOCALAPPDATA\nvim" "$env:LOCALAPPDATA\nvim.bak"   # Windows
```

## Clone and first launch

```sh
git clone https://github.com/gustavommcv/minimal-neovim ~/.config/nvim
nvim
```

```powershell
git clone https://github.com/gustavommcv/minimal-neovim "$env:LOCALAPPDATA\nvim"
nvim
```

On first launch, lazy.nvim clones itself, then installs every plugin listed
under `lua/plugins/`. `nvim-treesitter`'s `build = ":TSUpdate"` compiles the
parsers listed in `lua/plugins/treesitter.lua`, which needs the C compiler
and tree-sitter CLI mentioned above — if either is missing, that step fails
but the rest of the config still loads (see
[troubleshooting.md](troubleshooting.md)).

Mason installs LSP servers, formatters and linters the first time you open a
matching filetype (or run `:Mason` manually). Some of them (`gopls`,
`ts_ls`, `pyright`, `emmet_ls`, `html`, `cssls`) need Go or Node.js already on
`$PATH` at install time.

## Verifying the install

```vim
:checkhealth
:checkhealth vim.lsp
:Lazy
:Mason
```

## Uninstalling

See [the README](../README.md#uninstalling).
