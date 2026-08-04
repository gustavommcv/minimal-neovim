# Customization

## Changing options

Edit `lua/config/options.lua`. Everything there uses `vim.opt`; see `:h
option-list` for what's available. Options that only matter to one plugin
(e.g. a colorscheme's own settings) belong in that plugin's file instead.

## Changing keymaps

Global, plugin-independent keymaps live in `lua/config/keymaps.lua`.
Plugin-specific keymaps live next to the plugin, either in its `keys` table
(Telescope, Neo-tree, conform, trouble, todo-comments) or inside its `config`
function (gitsigns' `on_attach`, LSP's `LspAttach` in `lua/plugins/lsp.lua`).
Add a `desc` to every new keymap — which-key and `:Telescope keymaps` both
surface it.

## Changing the colorscheme

Edit `lua/plugins/colorscheme.lua`. To switch away from nightfox entirely,
replace the plugin spec and update `install.colorscheme` in
`lua/config/lazy.lua` (used as the fallback while plugins are still
installing).

## Adding a plugin

1. Create `lua/plugins/<name>.lua` returning a lazy.nvim spec (see any
   existing file for the shape).
2. Give it a real lazy-loading trigger (`event`/`cmd`/`ft`/`keys`) unless it
   must be visible from the first frame (colorscheme, statusline) or cannot
   be lazy-loaded (Tree-sitter, vimtex).
3. Run `:Lazy sync`, commit the resulting `lazy-lock.json` diff together with
   your change.
4. Add it to [plugins.md](plugins.md) with the same columns used there.

Before adding, walk through the checklist in
[architecture.md](architecture.md#adding-a-plugin).

## Removing a plugin

Delete its `lua/plugins/<name>.lua`, remove it from any `dependencies` list
that references it, run `:Lazy clean`, and update
[plugins.md](plugins.md)/[keymaps.md](keymaps.md) if it had keymaps.

## Installed vs. enabled: how LSP servers get activated

There are two separate, deliberate steps, both driven by one list:

- **Installed**: the mason-lspconfig server name is in `lsp_servers` in
  `lua/plugins/mason.lua`, so Mason downloads the binary
  (`ensure_installed = lsp_servers`).
- **Enabled**: `vim.lsp.enable()` is called for it, so Neovim actually
  starts a client when you open a matching file
  (`automatic_enable = lsp_servers`, the *same* table).

Both come from the same list on purpose, so there's only one place to edit.
Because `automatic_enable` is a table and not `true`, mason-lspconfig treats
it as an **allowlist**: if you install a server through `:Mason` or
`:MasonInstall` to try it out without adding it to `lsp_servers`, Mason will
have the binary, but `vim.lsp.enable()` is never called for it, so it stays
completely inert — no client starts, nothing changes in your editing
session. That's deliberate: installing something to poke at it should never
silently become a permanent part of this config.

## Adding an LSP server

1. Add the mason-lspconfig server name to the `lsp_servers` table at the top
   of `lua/plugins/mason.lua`. This single edit both installs it (via
   `ensure_installed`) and enables it (via `automatic_enable`) — no
   `handlers` table, no second list to update.
2. If it needs custom `settings`/`cmd`/`root_markers`, add
   `after/lsp/<server_name>.lua` returning a table (see
   `after/lsp/lua_ls.lua` for the shape). Plain `lsp/<server_name>.lua` also
   works but sits in the same merge tier as nvim-lspconfig's own bundled
   config for that server — use `after/lsp/` when you need a guaranteed
   override (see [architecture.md](architecture.md) for why).
3. `:LspInfo` / `:checkhealth vim.lsp` to confirm it attached.

To just try a server without making it a permanent part of this config,
`:MasonInstall <tool>` it and run `:lua vim.lsp.enable('server_name')`
yourself for the session — it won't persist and won't auto-enable on the
next launch unless you also add it to `lsp_servers`.

## Arduino support (optional)

`arduino_language_server` is deliberately **not** in the default
`lsp_servers` list: on a default install it has nothing it needs to actually
run, so enabling it out of the box would just be a server that reliably
fails to attach (confirmed while building this config — it exits
immediately with "Path to ArduinoCLI config file must be set."). Getting it
working requires all of the following, none of which this config installs
or configures for you:

- **`arduino-language-server`** itself (installed via Mason once you add it
  to `lsp_servers`, see below).
- **`arduino-cli`**, installed separately and on your `$PATH`.
- **`clangd`**, installed separately and on your `$PATH`.
- **A board core/platform** installed through `arduino-cli` for the board
  you're targeting (e.g. `arduino-cli core install arduino:avr`).
- **A valid `arduino-cli` configuration file** (`arduino-cli config init`
  generates one) — `after/lsp/arduino_language_server.lua` points at
  `~/.arduino15/arduino-cli.yaml` by default; adjust if yours lives
  elsewhere.
- **A real FQBN** for your board (`arduino-cli board list` with the board
  connected shows it) — the `"arduino:avr:leonardo"` in
  `after/lsp/arduino_language_server.lua` is only an example.
- **A project with a `sketch.yaml`** (`arduino-cli board attach` generates
  one) or an otherwise valid sketch layout the language server can resolve.

To enable it once all of the above is actually in place:

1. Install and configure `arduino-cli`, `clangd`, the board core, and the
   Arduino CLI config file as described above.
2. Edit `after/lsp/arduino_language_server.lua` and replace the example FQBN
   (and the `-cli-config` path, if needed) with your board's real values.
3. Add `"arduino_language_server"` back to the `lsp_servers` table in
   `lua/plugins/mason.lua` — this is what both installs it via Mason and
   enables it via `vim.lsp.enable()`.
4. Restart Neovim (or run `:Lazy reload` on `mason-lspconfig.nvim`) so Mason
   installs the server.
5. Open a real `.ino` file inside a project with a valid `sketch.yaml` and
   run `:LspInfo` to confirm `arduino_language_server` actually attached
   (not just that it's enabled — an enabled server can still fail to start
   if any of the prerequisites above are missing or misconfigured).

This is intentionally manual: no autodetection, no silent fallback if a
prerequisite is missing. If it isn't set up, the server simply never
enables, and nothing else in this config is affected.

## Adding a formatter

Add an entry to `formatters_by_ft` in `lua/plugins/formatting.lua`, and the
tool name to `ensure_installed` in `lua/plugins/mason.lua` (under
mason-tool-installer) if Mason can install it.

## Adding a linter

Add an entry to `linters_by_ft` in `lua/plugins/linting.lua`, same
`ensure_installed` treatment as formatters.

## Adding a language (parser + everything else)

1. Add the [tree-sitter parser name](https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages)
   to the `parsers` list in `lua/plugins/treesitter.lua`, then `:TSUpdate`.
2. Add an LSP server (above) if one exists for the language.
3. Add a formatter/linter (above) if relevant.

## Updating

```vim
:Lazy sync      " plugins -> updates lazy-lock.json
:Mason          " then press U to update outdated tools, or :MasonUpdate
```

Review the `lazy-lock.json` diff before committing — it's the only file in
this repo that should only ever change via `:Lazy`, never by hand.

## Enabling format-on-save

Formatting is manual by default (`<leader>gf`). To opt into format-on-save:
`:FormatEnable` (global) / `:FormatEnable!` (current buffer only) /
`:FormatDisable` to turn it back off. `<leader>gf` always formats manually
regardless of this setting.
