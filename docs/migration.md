# Migration notes (August 2026 refactor)

This documents the refactor that modernized this config for Neovim 0.12 and
the current (as of August 2026) plugin ecosystem. If you have an older
checkout of this repository, read this before pulling.

## Breaking changes / required action

- **Neovim >= 0.12 is now required.** `nvim-treesitter`'s current API needs
  it. If you're on an older Neovim, upgrade first (`winget upgrade
  Neovim.Neovim` / `brew upgrade neovim` / distro package / release tarball).
- **`~/.config/nvim/undodir` is gone.** Undo history now lives under
  `stdpath("state")` (e.g. `~/.local/state/nvim/undo`, or
  `%LOCALAPPDATA%\nvim-data\undo` on Windows) instead of inside the config
  repo. Your old `undodir/` folder is safe to delete; it will not be
  recreated there.
- **`<leader>cl` conflict resolved**: it was bound to two different things
  (`nvim-lint`'s manual trigger, and Trouble's LSP list) — Trouble keeps
  `<leader>cl`; the manual lint trigger moved to `<leader>cL`.
- **`<leader>e`, `<leader>ff`, `<leader>fg`, `<C-p>` still work the same**,
  but Neo-tree and Telescope are now properly lazy-loaded (`cmd`/`keys`
  instead of loading at startup) — first invocation has a small one-time
  load cost that didn't exist before, in exchange for a faster cold start.
- **`K`, `gd`, `<leader>ca` are now buffer-local, bound on `LspAttach`**,
  instead of global keymaps that silently did nothing without an attached
  client. In a buffer with no LSP client (a plain text file, a commit
  message, a filetype with no server configured), `K` and `gd` now fall back
  to Neovim's native behavior (`keywordprg` lookup and the local-declaration
  `gd` motion, respectively) instead of being permanently shadowed.
  `<leader>rn` was already effectively buffer-scoped in practice and is
  unchanged in behavior, just relocated to `lua/plugins/lsp.lua`.
- **Formatting stays manual by default**, same as before this refactor —
  `<leader>gf` / `:ConformInfo`. `:FormatEnable` (or `:FormatEnable!` for one
  buffer) opts into format-on-save; `:FormatDisable` turns it back off. This
  was evaluated for an on-by-default change and deliberately reverted to
  match prior behavior.

## Directory layout changes

| Before | After |
| --- | --- |
| `lua/core/options.lua` | `lua/config/options.lua` |
| `lua/core/keymaps.lua` | `lua/config/keymaps.lua` |
| `lua/core/theme.lua` | merged into `lua/plugins/colorscheme.lua` |
| `lua/plugins/nightfox.lua` | renamed `lua/plugins/colorscheme.lua` |
| `lua/plugins/completions.lua` | renamed `lua/plugins/completion.lua`, rewritten for blink.cmp |
| *(none)* | `lua/config/diagnostics.lua` (new: `vim.diagnostic.config`, moved out of `options.lua`; no behavior change, same call/values) |
| *(none)* | `lua/plugins/lsp.lua` (new: nvim-lspconfig + capabilities + `LspAttach` keymaps) |
| *(none)* | `lua/plugins/lazydev.lua` (new) |
| *(none)* | `after/lsp/lua_ls.lua`, `after/lsp/arduino_language_server.lua` (new) |
| *(none)* | `docs/`, `.stylua.toml`, `.editorconfig`, `.luarc.json`, `.github/workflows/ci.yml` (new) |

## Plugins removed

| Plugin | Why |
| --- | --- |
| `hrsh7th/nvim-cmp` | Replaced by blink.cmp |
| `hrsh7th/cmp-nvim-lsp` | blink.cmp has its own LSP source |
| `L3MON4D3/LuaSnip` | blink.cmp has its own snippet engine |
| `saadparwaiz1/cmp_luasnip` | No longer needed without LuaSnip |
| `3rd/image.nvim` (as a neo-tree dependency) | Fails to build on Windows without ImageMagick (confirmed during this refactor); decorative, not core to file browsing. See [troubleshooting.md](troubleshooting.md) to re-add it manually if you have ImageMagick. |

`friendly-snippets` was **kept** — blink.cmp consumes its snippet files
directly, no snippet engine plugin required.

## Plugins added

| Plugin | Why |
| --- | --- |
| `saghen/blink.cmp` | Completion engine (replaces the four removed above) |
| `folke/lazydev.nvim` | Correct LuaLS completion/diagnostics while editing this config (`vim.api.*`, `vim.uv.*`, installed plugin modules) |

Net effect: 4 removed, 2 added — fewer plugins overall, and one less
snippet-engine layer. blink.cmp's completion/documentation popups are
explicitly given a border (`completion.menu.border` /
`completion.documentation.window.border` in `lua/plugins/completion.lua`) to
match the border the old `nvim-cmp` config explicitly set — blink.cmp
defaults to no border. Signature help (`<C-k>` in insert mode) was
considered but **not** enabled: it's a new capability the previous
`nvim-cmp` setup never had, with no concrete gap driving it, so it was left
off (`signature.enabled` defaults to `false`).

## API migrations

- `require("lspconfig").<server>.setup({...})` → `vim.lsp.config()` /
  `vim.lsp.enable()`, with mason-lspconfig's `automatic_enable` doing the
  enabling. See [architecture.md](architecture.md) and
  [plugins.md](plugins.md#lsp-stack). `automatic_enable` is set to the same
  `lsp_servers` table as `ensure_installed` (not left at its default `true`,
  which would enable *every* server ever installed through Mason) — a single
  list drives both installing and enabling, and `:MasonInstall`-ing
  something outside that list installs the binary without activating it.
- `nvim-treesitter`'s old `require("nvim-treesitter.configs").setup({...})`
  → the `main`-branch API (`require("nvim-treesitter").install()` +
  `vim.treesitter.start()` in a `FileType` autocmd + `indentexpr`). This repo
  had already started this migration; this refactor completed it
  (install-if-missing semantics, `indentexpr` wiring) and expanded the
  parser list to match every language this config actually supports.
- `williamboman/mason*.nvim` → `mason-org/mason*.nvim` (the packages moved
  organizations; the old names still redirect, but the canonical URLs are
  now used).
- Bootstrap: `(vim.uv or vim.loop)` → `vim.uv` (the `vim.loop` fallback is
  dead code once Neovim >= 0.12 is required).

## Bugs fixed along the way

- `alpha-nvim.lua` depended on a stale personal fork
  (`RchrdAriza/nvim-web-devicons`, last pushed April 2024) instead of the
  actively-maintained `nvim-tree/nvim-web-devicons` already used everywhere
  else in this config.
- `gitsigns.nvim` had no keymaps at all. This is **not** treated as a bug on
  its own — gitsigns needs no `setup()` call to draw its gutter signs, so
  that part already worked. What was missing was a way to jump between
  hunks, so `]c`/`[c` were added (matching the `]d`/`[d` diagnostic
  navigation pattern already in `lua/config/keymaps.lua`). Stage/reset/
  preview/blame keymaps from gitsigns' own README example were deliberately
  **not** added — they're a git-porcelain layer this config never had and
  nothing established a concrete need for it.
- `python` had no formatter configured in conform.nvim despite `ruff` already
  being installed via mason-tool-installer — added `ruff_format`.
- `vim.g.vimtex_view_method` was set twice (once in `init.lua`, once in
  `vimtex.lua`'s own `init`); consolidated into `vimtex.lua`.
- `require("telescope.builtin")` at the top of `keymaps.lua` forced Telescope
  to load at startup regardless of any lazy-loading trigger; moved into
  Telescope's own `keys` table.

## Considered and reverted

A few additions were made during this refactor, then reverted after review
because they didn't fix an existing problem — they were just opinions with
no strong justification, which this project's own stated philosophy argues
against:

- `vim.opt.signcolumn = "yes"`, `updatetime = 250`, `timeoutlen = 300`,
  `splitright = true`, `splitbelow = true` — none of these were requested or
  fixed anything; `splitright`/`splitbelow` in particular would have changed
  where `:split`/`:vsplit` open windows relative to Neovim's own defaults.
- A `TextYankPost` highlight-on-yank autocmd (`lua/config/autocmds.lua`,
  since removed) — a nice-to-have with no prior gap behind it.
- Format-on-save on by default (see above).

## Not changed (evaluated and kept as-is)

- **`vim.pack` was not adopted** in place of lazy.nvim — see
  [architecture.md](architecture.md#plugin-manager-why-lazynvim-and-not-vimpack).
- **`alpha-nvim` (start screen) was kept** even though this project
  otherwise avoids distribution-style dashboards — it's a pre-existing,
  actively-used personal feature, not something newly added.
- **`noice.nvim` was kept** rather than adopting Neovim 0.12's experimental
  `ui2` — `ui2` is opt-in and explicitly experimental; not worth building
  around yet.
- **`vim.g.vimtex_view_method = "zathura"` was kept** even though it's
  Linux/BSD-only. If you're on Windows/macOS, change it — see
  [customization.md](customization.md).
