# Plugins

One entry per file in `lua/plugins/`. "Loaded" is the lazy.nvim trigger (or
"eager" if the plugin has none and loads at startup).

## LSP stack

Division of responsibility: **mason.nvim** installs binaries.
**mason-lspconfig.nvim** installs and enables LSP servers strictly from one
list, `lsp_servers` in `lua/plugins/mason.lua`, used for both
`ensure_installed` (install) and `automatic_enable` (enable) — there is no
manual `handlers` table, and no duplicated list to keep in sync. Because
`automatic_enable` is set to that same table rather than to `true`, it acts
as an explicit allowlist: installing a server through `:Mason`/
`:MasonInstall` outside of `lsp_servers` installs the binary but does
**not** enable it (`vim.lsp.enable()` is never called for it), so it stays
inert until you either add it to the list or call `vim.lsp.enable('name')`
yourself. See [customization.md](customization.md#adding-an-lsp-server) for
the difference between "installed" and "enabled" and how to add a server.
**nvim-lspconfig** is not `require()`'d anywhere; it's a dependency purely so
its bundled `lsp/<server>.lua` files (default `cmd`, `root_markers`,
`filetypes`) are on `runtimepath` for Neovim's native config resolution to
find. Custom per-server settings live in `after/lsp/<server>.lua`.

| Plugin | File | Loaded | Purpose | Alternative considered |
| --- | --- | --- | --- | --- |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | `lsp.lua` | eager | Bundled server definitions + `LspAttach` keymaps + global capabilities | Hand-writing every server's `cmd`/`root_markers` — more code, no benefit |
| [mason.nvim](https://github.com/mason-org/mason.nvim) | `mason.lua` | eager | Installs LSP servers/formatters/linters | Manual per-OS binary installs |
| [mason-lspconfig.nvim](https://github.com/mason-org/mason-lspconfig.nvim) | `mason.lua` | eager | Bridges Mason installs to `vim.lsp.enable()` | Manually enumerating `vim.lsp.enable()` calls |
| [mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim) | `mason.lua` | eager | Ensures formatter/linter *binaries* (not LSP servers) are installed | — |

## Completion & Lua development

| Plugin | File | Loaded | Purpose | Alternative considered |
| --- | --- | --- | --- | --- |
| [blink.cmp](https://github.com/saghen/blink.cmp) | `completion.lua` | eager | LSP/path/buffer/snippet completion, fuzzy matching | `nvim-cmp` (kept until this refactor; see [migration.md](migration.md)), Neovim's native `vim.o.autocomplete` (still missing fuzzy matching and a documentation UI as of Neovim 0.12) |
| [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) | `completion.lua` | dependency | Snippet *data* consumed natively by blink.cmp | `LuaSnip` + `cmp_luasnip` (removed; blink has its own engine) |
| [lazydev.nvim](https://github.com/folke/lazydev.nvim) | `lazydev.lua` | `ft = "lua"` | Accurate LuaLS completion/diagnostics for `vim.*` and installed plugins while editing this config | `neodev.nvim` (superseded by lazydev), hand-written `.luarc.json` workspace.library list (drifts out of date, and is duplicated per project) |

## Tree-sitter

| Plugin | File | Loaded | Purpose | Alternative considered |
| --- | --- | --- | --- | --- |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) (`main` branch) | `treesitter.lua` | `lazy = false` | Parser install/update, highlighting, indentation | Fully native (no plugin): loses `:TSUpdate`, the query corpus, and textobjects for a manual `git clone` + `tree-sitter build` per parser — more moving parts, not less |

`nvim-treesitter` was briefly archived on GitHub in April 2026 and later
unarchived; as of this writing (checked directly against the GitHub API on
2026-08-03) it is active again, with a push as recent as 2026-08-01, but
`main` requires Neovim >= 0.12. Given that history, treat its maintenance
status as worth re-checking before you depend on it further — if it goes
unmaintained again, the fallback is the fully-native approach above.

## Formatting & linting

| Plugin | File | Loaded | Purpose | Alternative considered |
| --- | --- | --- | --- | --- |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | `formatting.lua` | `BufWritePre`, `cmd`, `keys` | Formatting, format-on-save | `none-ls.nvim` (replaced before this refactor; unmaintained fork of the archived null-ls), pure `vim.lsp.buf.format()` (no per-filetype formatter chains/fallback) |
| [nvim-lint](https://github.com/mfussenegger/nvim-lint) | `linting.lua` | `BufReadPre`, `BufNewFile` | Linting for filetypes not fully covered by an LSP diagnostic (eslint_d for JS/TS) | Native LSP diagnostics alone (ESLint's LSP mode is heavier than `eslint_d` for this use case) |

## Files, search, git

| Plugin | File | Loaded | Purpose | Alternative considered |
| --- | --- | --- | --- | --- |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | `telescope.lua` | `cmd`, `keys` | Fuzzy finder | `fzf-lua` (comparable; telescope kept, no compelling reason to churn) |
| [telescope-ui-select.nvim](https://github.com/nvim-telescope/telescope-ui-select.nvim) | `telescope.lua` | dependency | Routes `vim.ui.select()` (e.g. code actions) through Telescope | Default `vim.ui.select` (less discoverable UI) |
| [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) | `neotree.lua` | `cmd`, `keys`, or eager if started on a directory | File explorer sidebar | Netrw (kept minimal on purpose, but no persistent tree/filtering), `oil.nvim` (buffer-as-directory model; not evaluated) |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | `gitsigns.lua` | `BufReadPre`, `BufNewFile` | Git gutter signs + hunk navigation (`]c`/`[c`) | Signs alone need no plugin config at all (gitsigns needs no `setup()` call); stage/reset/preview/blame keymaps were deliberately left out — see [migration.md](migration.md) |

`neotree.lua` sets `lazy = false` for the one case of Neovim starting with a
single directory argument (`nvim path/to/dir`) — otherwise it stays
`cmd`/`keys`-lazy as normal. That's the *only* thing this config adds:
neo-tree's own `M.setup()` (in its `neo-tree.lua`) already hijacks netrw for
a directory argument and, via `filesystem.bind_to_cwd` (on by default),
syncs Neovim's `cwd` to match — confirmed by reading its source
(`lua/neo-tree.lua`, `lua/neo-tree/setup/netrw.lua`). The catch is that this
only runs if `setup()` executes before `VimEnter` (it checks
`vim.v.vim_did_enter == 0` itself); purely `cmd`/`keys`-triggered loading
never gets there in time, so native netrw wins the race instead and opens a
bare `:Ex`-style listing, rooted at whatever `cwd` already was rather than
the directory you asked for. An earlier version of this fix hand-rolled a
`VimEnter` autocmd to disable netrw and redo all of this manually; it was
strictly worse — more code, and a real bug (relative-path resolution) along
the way — for reimplementing what neo-tree already does more carefully.

`3rd/image.nvim` (image previews inside neo-tree) was removed as a
dependency: it requires ImageMagick and fails to build out of the box on
Windows (confirmed during this refactor — `luarocks` install of `magick`
fails with no ImageMagick present). It's a decorative feature, not core to
file browsing; see [troubleshooting.md](troubleshooting.md) to add it back if
you have ImageMagick installed.

## UI

| Plugin | File | Loaded | Purpose | Alternative considered |
| --- | --- | --- | --- | --- |
| [nightfox.nvim](https://github.com/EdenEast/nightfox.nvim) | `colorscheme.lua` | `lazy = false`, `priority = 1000` | Colorscheme (`carbonfox`) | — |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | `lualine.lua` | eager | Statusline | Native `statusline`/`stl` string (would need hand-rolled git/diagnostics components) |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | `indent-blankline.lua` | `BufReadPost`, `BufNewFile` | Indent guides | Native `listchars` (no scope highlighting) |
| [nvim-colorizer.lua](https://github.com/catgoose/nvim-colorizer.lua) | `colorizer.lua` | `BufReadPre` | Inline color previews (`#rrggbb`, etc.) | — |
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | `autopairs.lua` | `InsertEnter` | Auto-close brackets/quotes | — |
| [alpha-nvim](https://github.com/goolord/alpha-nvim) | `alpha-nvim.lua` | `VimEnter` | Start screen | Kept as an existing personal preference; not something this refactor adds — a distribution-style dashboard is otherwise avoided on purpose |
| [noice.nvim](https://github.com/folke/noice.nvim) | `noice.lua` | `VeryLazy` | Cmdline/messages/popupmenu UI | Neovim 0.12's experimental `ui2` (opt-in, not built around here without stronger justification) |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | `todo-comments.lua` | `BufReadPost` | Highlight/list `TODO`/`FIXME`/etc. | — |
| [trouble.nvim](https://github.com/folke/trouble.nvim) | `trouble.lua` | `cmd`, `keys` | Diagnostics/references/TODOs list UI | Native quickfix/loclist alone (no live filtering/grouping) |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | `which-key.lua` | `VeryLazy` | Keymap discovery popup | — |

## Language-specific

| Plugin | File | Loaded | Purpose |
| --- | --- | --- | --- |
| [vimtex](https://github.com/lervag/vimtex) | `vimtex.lua` | `lazy = false` (cannot be lazy-loaded) | LaTeX filetype support, compilation, viewer sync |

## Shared dependencies

`plenary.nvim`, `nvim-web-devicons`, `nui.nvim` — pulled in transitively by
the plugins above (Telescope/Neo-tree/todo-comments; alpha/lualine/neo-tree;
Neo-tree/noice, respectively). Not configured directly.
