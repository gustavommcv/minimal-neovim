# Minimal Neovim

A personal Neovim configuration written in Lua. It is not a distribution:
there is no plugin marketplace, no menu of "presets", and no attempt to work
for everyone. It is meant to be read from top to bottom, understood, and
changed.

## Philosophy

- Minimal: as few plugins as the daily workflow actually needs.
- Native first: prefer a built-in Neovim API over a plugin when the API is
  good enough (native LSP client, native Tree-sitter API, native diagnostics,
  native completion trigger points).
- Readable: every file has one clear responsibility and is short enough to
  read in one sitting.
- Fast to start: nothing loads before it is needed, without contorting the
  config to chase benchmark numbers.
- Not a distribution: no dashboard-of-dashboards, no bundled "language packs",
  no settings UI. Adding a language means adding a few lines, not a framework.

## Requirements

- **Neovim >= 0.12** (tested on 0.12.4). Required by `nvim-treesitter`'s
  current API and by `vim.lsp.config`/`vim.lsp.enable`.
- **Git**
- **A C compiler** (`cc`, `gcc`, or `clang`) and the
  [tree-sitter CLI](https://github.com/tree-sitter/tree-sitter/tree/master/cli) —
  needed by `nvim-treesitter` to compile parsers that don't ship with Neovim.
- **[ripgrep](https://github.com/BurntSushi/ripgrep)** — used by Telescope's
  live grep picker.
- **A [Nerd Font](https://www.nerdfonts.com/)** in your terminal, for icons.

Optional, depending on what you edit:

- **Node.js** — most JS/TS/HTML/CSS/Emmet language servers are installed by
  Mason via npm.
- **Go toolchain** — `gopls`/`goimports` are built by Mason via `go install`.
- **A LaTeX distribution** (TeX Live, MiKTeX) plus a PDF viewer for `vimtex`.
- **arduino-cli** and **clangd** — only if you use the optional Arduino LSP
  (see [after/lsp/arduino_language_server.lua](after/lsp/arduino_language_server.lua)).

See [docs/installation.md](docs/installation.md) for OS-specific steps and
[docs/troubleshooting.md](docs/troubleshooting.md) for what to do when one of
these is missing.

## Installation

```sh
git clone https://github.com/gustavommcv/minimal-neovim ~/.config/nvim
nvim
```

Plugins install automatically on first launch. Full OS-by-OS instructions
(including Windows paths and backing up an existing config) are in
[docs/installation.md](docs/installation.md).

## Project structure

```
.
├── init.lua                 -- entry point: loads config, then plugins
├── lazy-lock.json            -- plugin version lockfile (do not edit by hand)
├── after/lsp/                 -- per-server LSP overrides (native lsp/ mechanism)
├── lua/
│   ├── config/                -- editor settings, not plugin-specific
│   │   ├── lazy.lua           -- lazy.nvim bootstrap
│   │   ├── options.lua        -- vim.opt settings
│   │   ├── keymaps.lua        -- global keymaps
│   │   └── diagnostics.lua    -- vim.diagnostic display config
│   └── plugins/                -- one file per plugin (or tightly related group)
└── docs/                     -- architecture, keymaps, customization, etc.
```

See [docs/architecture.md](docs/architecture.md) for the reasoning behind this
layout and how the pieces fit together.

## Features

- **LSP**: native `vim.lsp.config`/`vim.lsp.enable`, no
  `require("lspconfig").<server>.setup()` calls. Mason installs the servers;
  `mason-lspconfig` enables them.
- **Completion**: [blink.cmp](https://github.com/saghen/blink.cmp) — LSP,
  path, buffer and snippet sources, built-in fuzzy matching, no `nvim-cmp`.
- **Neovim config authoring**: [lazydev.nvim](https://github.com/folke/lazydev.nvim)
  gives accurate completion and diagnostics for `vim.*` and installed plugins
  while editing this very config.
- **Tree-sitter**: highlighting, indentation and incremental selection via
  `nvim-treesitter`'s current (`main` branch) API.
- **Formatting**: [conform.nvim](https://github.com/stevearc/conform.nvim),
  manual by default (`<leader>gf`); format-on-save is an opt-in toggle
  (`:FormatEnable`/`:FormatDisable`).
- **Linting**: [nvim-lint](https://github.com/mfussenegger/nvim-lint) for
  linters that aren't better served by an LSP diagnostic.
- **File explorer**: neo-tree. **Fuzzy finder**: Telescope. **Statusline**:
  lualine. **Git gutter + hunk navigation**: gitsigns.

Full plugin-by-plugin rationale is in [docs/plugins.md](docs/plugins.md).

## Languages supported out of the box

Lua, JavaScript/TypeScript (+ JSX/TSX), HTML/CSS, JSON, YAML, Go, Python,
LaTeX, and (optionally) Arduino/C++. Adding another language is a few lines in
`mason.lua` and `treesitter.lua` — see
[docs/customization.md](docs/customization.md#adding-a-language).

## Keymaps

The leader key is `<Space>`. The full, categorized list is in
[docs/keymaps.md](docs/keymaps.md); the ones you'll use first:

| Key | Action |
| --- | --- |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>e` | Toggle file explorer |
| `K` | Hover documentation |
| `gd` | Go to definition |
| `<leader>ca` | Code action |
| `<leader>rn` | Rename symbol |
| `<leader>gf` | Format buffer |
| `<leader>xx` | Diagnostics list |

## Customization

Changing an option, keymap, colorscheme, or adding a plugin/language/formatter
is covered step by step in [docs/customization.md](docs/customization.md).

## Updating

```vim
:Lazy sync
```

review and commit the resulting `lazy-lock.json` diff. See
[docs/customization.md](docs/customization.md#updating) for Mason tools.

## Troubleshooting

[docs/troubleshooting.md](docs/troubleshooting.md) covers missing tools, LSP
not starting, formatter/linter/parser not found, missing Nerd Font icons, and
how to reset a broken install.

## Health checks

```vim
:checkhealth
:checkhealth vim.lsp
:LspInfo
```

## Uninstalling

```sh
rm -rf ~/.config/nvim ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim
```

On Windows: config and data/state map to `%LOCALAPPDATA%\nvim` and
`%LOCALAPPDATA%\nvim-data`; the cache directory is separate, at
`%LOCALAPPDATA%\Temp\nvim` (verified against a real install — it is *not*
under `nvim-data`).

```powershell
Remove-Item -Recurse -Force "$env:LOCALAPPDATA\nvim", "$env:LOCALAPPDATA\nvim-data", "$env:LOCALAPPDATA\Temp\nvim"
```

## Migrating from an older version of this config

If you're updating an existing checkout of this repository across the
refactor described in this README, read
[docs/migration.md](docs/migration.md) first — it lists renamed files,
removed plugins, and the one or two behavior changes that need action on your
part.

## License

[GPL-3.0](LICENSE)

## Acknowledgements

- [Typecraft](https://www.youtube.com/@typecraft_dev) — the Neovim course
  this config originally grew out of.
- [LazyVim](https://www.lazyvim.org/) — plugin organization ideas.
- The Neovim community and every plugin author listed in
  [docs/plugins.md](docs/plugins.md).
