# Installation

## Prerequisites

See the [requirements list in the README](../README.md#requirements) for what
each dependency is for. Below is how to get them per OS.

Mason (see [plugins.md](plugins.md#lsp-stack)) installs most LSP servers,
formatters and linters by downloading a `.zip` and extracting it with the
system `unzip` command. No OS installs `unzip` by default on a minimal
image — without it, Mason installs fail with `Could not find executable
"unzip" in PATH` (confirmed while troubleshooting this on Arch Linux/WSL).
It's included in the commands below.

Five of the eight default-enabled LSP servers (`html`, `cssls`, `emmet_ls`,
`ts_ls`, `pyright`) plus three formatters/linters (`prettierd`, `prettier`,
`eslint_d`) are distributed as **npm packages** — confirmed directly against
Mason's own registry (`mason-registry/packages/*/package.yaml`, `source.id:
pkg:npm/...`). They aren't just installed via npm; they're plain JS programs
that need a working `node` executable every time they *run*, not only at
install time. `gopls` and `goimports` are the reverse case: Mason builds
them with `go install`, which needs the Go toolchain only while
installing — the resulting binary doesn't need Go afterwards. Practically:
skip Node.js/Go only if you're sure you'll never open a JS/TS/HTML/CSS/Python
or Go file; otherwise install them too, even though nothing else in this
config strictly requires them.

### Linux (Debian/Ubuntu example; adjust for your package manager)

```sh
sudo apt install git ripgrep clang unzip
sudo apt install nodejs npm golang-go   # for the LSP servers/formatters above
# Neovim >= 0.12: your distro's repo may lag behind; the AppImage or a
# release tarball from https://github.com/neovim/neovim/releases is the
# most reliable way to get 0.12+.
npm install -g tree-sitter-cli   # or: cargo install tree-sitter-cli
```

### Arch Linux

```sh
sudo pacman -S neovim git ripgrep tree-sitter-cli unzip
sudo pacman -S gcc     # or: sudo pacman -S clang
sudo pacman -S nodejs npm go   # for the LSP servers/formatters above
```

Everything needed is in the official `extra`/`core` repos and tracks current
upstream releases closely — checked directly against the Arch package
database while writing this: `neovim` 0.12.4, `git` 2.55.0, `ripgrep`
15.2.0, `tree-sitter-cli` 0.26.9, `unzip` 6.0, `clang` 22.1.8, `gcc` 16.1.1,
`nodejs` 26.5.1, `npm` 12.0.2, `go` 1.26.5. No AUR package is required for
anything in the requirements list. `gcc` is usually already pulled in by
`base-devel` if you have that installed; either compiler works, pick
whichever you already have. `npm` depends on `nodejs`, so installing either
one alone via pacman pulls the other in — but list both explicitly so it's
obvious what's actually needed.

### macOS

```sh
brew install neovim git ripgrep
brew install llvm            # or use Xcode's clang (xcode-select --install)
brew install node go         # for the LSP servers/formatters above
npm install -g tree-sitter-cli
```

### Windows

```powershell
winget install Neovim.Neovim
winget install Git.Git
winget install BurntSushi.ripgrep.MSVC
winget install tree-sitter.tree-sitter-cli
winget install OpenJS.NodeJS
winget install GoLang.Go
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
matching filetype (or run `:Mason` manually) — see the Node.js/Go note under
Prerequisites above for which ones need what, and why it's not just an
install-time requirement for the npm-based ones.

## Verifying the install

```vim
:checkhealth
:checkhealth vim.lsp
:Lazy
:Mason
```

## Uninstalling

See [the README](../README.md#uninstalling).
