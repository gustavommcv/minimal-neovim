# Architecture

## Startup flow

1. `init.lua` sets `mapleader`/`maplocalleader`, then requires, in order:
   `config.lazy` → `config.options` → `config.keymaps` → `config.diagnostics`.
2. `config.lazy` bootstraps [lazy.nvim](https://github.com/folke/lazy.nvim) if
   it isn't cloned yet, then calls `require("lazy").setup({ spec = { { import
   = "plugins" } } })`, which loads every file under `lua/plugins/`.
3. `lazy.lua` runs **first**, before options/keymaps, because a couple of
   keymaps (Telescope, Neo-tree) reference plugin modules through `require()`
   at define-time; those `require()` calls only work once lazy.nvim has added
   the plugins' directories to `runtimepath`. Options/keymaps/diagnostics have
   no such dependency, so their relative order doesn't matter.

## Directory responsibilities

- **`lua/config/`** — editor behavior that isn't about a specific plugin:
  bootstrap, `vim.opt`, global keymaps, autocommands, `vim.diagnostic`
  display. If a setting only makes sense in the context of one plugin, it
  lives in that plugin's file instead (e.g. Arduino's LSP `cmd` lives in
  `after/lsp/arduino_language_server.lua`, not in `config/options.lua`).
- **`lua/plugins/`** — one file per plugin, named after the plugin (or the
  feature, when a file bundles a plugin with a tightly-coupled dependency,
  e.g. `mason.lua` covers `mason.nvim` + `mason-lspconfig.nvim` +
  `mason-tool-installer.nvim` since they only make sense together). Each file
  returns a lazy.nvim plugin spec (or a list of specs). This is intentionally
  *not* consolidated into broader buckets like `ui.lua`/`editing.lua`: with
  ~25 plugins, one-file-per-plugin stays easy to grep (the filename **is**
  the plugin name) without being "dozens of tiny files" — there's no
  meaningful grouping that wouldn't just be renaming things.
- **`after/lsp/`** — per-server LSP customization, using Neovim's native
  `lsp/`/`after/lsp/` discovery (`:h lsp-config`). This project uses
  `after/lsp/` rather than a plain `lsp/` directory on purpose: Neovim merges
  `'*'` config, then all `lsp/<name>.lua` found on `runtimepath` (this
  includes nvim-lspconfig's own bundled defaults), then all
  `after/lsp/<name>.lua`, in that order — so `after/lsp/` is the tier that is
  *guaranteed* to win over nvim-lspconfig's bundled `cmd`/`root_markers`/
  `settings` for the same server. A plain `lsp/lua_ls.lua` in this repo would
  sit in the *same* merge tier as nvim-lspconfig's own `lsp/lua_ls.lua`, and
  whichever one runtimepath happens to order last would win — not a bet worth
  making for `after/lsp/arduino_language_server.lua`, which overrides `cmd`.
- **`docs/`** — this directory.

## Plugin manager: why lazy.nvim (and not `vim.pack`)

Neovim 0.12 ships a built-in plugin manager, `vim.pack`. It was evaluated and
rejected for now: as of this writing it has no event/filetype/command-based
lazy loading — plugins load at startup or via a manual `:packadd`. Roughly
two-thirds of the plugins in `lua/plugins/` are lazy-loaded by event, `cmd`,
`ft`, or `keys` (Telescope on `cmd`, Neo-tree on `cmd`+`keys`, conform on
`BufWritePre`, etc.); reproducing that on `vim.pack` today would mean writing
and maintaining a lazy-loading layer by hand, in exchange for a plugin
manager that is still explicitly labeled experimental and has no equivalent
of `lazy-lock.json`. That's a worse trade for this project than the one extra
`lazy.nvim` dependency. This is worth revisiting once `vim.pack` grows
lazy-loading and a lockfile story.

## LSP

See [plugins.md](plugins.md#lsp-stack) for the division of responsibility
between mason.nvim / mason-lspconfig.nvim / nvim-lspconfig, and
[customization.md](customization.md#adding-an-lsp-server) for how to add a
server.

## Completion

blink.cmp's LSP capabilities are merged globally via
`vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities() })`
in `lua/plugins/lsp.lua`. blink.cmp is loaded eagerly (no `event` field): its
own capabilities function has to run before any server attaches (which can
happen as early as the first `FileType` event, before `InsertEnter` ever
fires), so lazy-loading it behind `InsertEnter` would force it to load at
that same early point anyway on any real editing session — the "laziness"
would only ever pay off for a no-file, no-LSP scratch session. Given blink.cmp
markets itself specifically on near-zero load overhead, loading it eagerly
is a simpler config for a startup cost that isn't measurable in practice (see
[the performance notes](../README.md) in the final report for the measured
numbers).

## Adding a plugin

Before adding one, it should clear all of:

1. Does it solve a problem Neovim's built-ins don't already solve?
2. Is it actively maintained (check the repo's last push, not just stars)?
3. Does it add more than one or two new transitive dependencies?
4. Will it actually get used day to day, not just "look nice to have"?
5. Can it be lazy-loaded without behavior surprises (flicker, broken
   keymaps, delayed diagnostics)?

If a plugin only offers a thin wrapper around something `vim.*` already does
well, prefer the native API and skip the plugin.
