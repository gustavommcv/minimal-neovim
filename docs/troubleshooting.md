# Troubleshooting

## `:Lazy sync` reports a plugin failed to install/build

Run `:Lazy log` on that plugin to see the actual error. The two known
platform-specific ones:

- **`nvim-treesitter` fails to build a parser** — you're missing the
  tree-sitter CLI, a C compiler, or both. See
  [installation.md](installation.md#prerequisites). Parsers that fail to
  build simply won't highlight; everything else keeps working.
- **`image.nvim` fails with a `magick`/luarocks error** — this dependency was
  intentionally removed from `neotree.lua` (see
  [migration.md](migration.md)) precisely because it fails this way on
  Windows without ImageMagick. If you want image previews in Neo-tree and
  have ImageMagick installed, add `"3rd/image.nvim"` back to
  `neotree.lua`'s `dependencies` and pass `filesystem.commands` per that
  plugin's own README — this config does not wire it up for you.

## An LSP server never attaches

1. `:LspInfo` — is the server even listed for this filetype?
2. `:Mason` — is it installed? Servers that need Node.js or Go only build
   successfully if that toolchain was on `$PATH` *when Mason installed them*;
   if you installed Node/Go afterwards, run `:MasonUninstall <tool>` then
   reinstall.
3. `:checkhealth vim.lsp` — shows attached clients per buffer.
4. Check `after/lsp/<server>.lua` if one exists for that server — a typo in
   `cmd` fails silently until you check `:LspLog`.

## No formatter for a filetype

`:ConformInfo` shows exactly which formatters conform looked for and whether
they were found on `$PATH`/Mason. If none are configured for that filetype,
`<leader>gf` falls back to `vim.lsp.buf.format()` via `lsp_format =
"fallback"` — so any attached LSP server that can format still will.

## Icons show up as boxes/question marks

You don't have a [Nerd Font](https://www.nerdfonts.com/) set as your
terminal's font. This is a terminal setting, not something this config can
detect or fix.

## Lua completion for `vim.*` or plugin modules doesn't work while editing this config

- Confirm `lazydev.nvim` actually loaded: it's `ft = "lua"`, so it only
  activates once you open a `.lua` file — open one, then `:Lazy` and check
  its status.
- `:LspInfo` in that buffer should show `lua_ls` attached.
- If `vim.uv.*` specifically doesn't complete, check that lazydev's `library`
  entry for `${3rd}/luv/library` in `lua/plugins/lazydev.lua` is intact —
  this comes from LuaLS's own bundled addon, not a separate plugin.

## After updating, something broke that used to work

1. `git log -- lazy-lock.json` / `:Lazy` to see what actually changed
   versions.
2. `:Lazy restore` reverts plugins to the versions pinned in the current
   `lazy-lock.json` (useful right after a bad `git pull` before you've run
   `:Lazy sync` yourself).

## Resetting entirely

Removing generated state does not touch this repository (undo history now
lives under `stdpath("state")`, not inside the config directory):

```sh
rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim
```

```powershell
Remove-Item -Recurse -Force "$env:LOCALAPPDATA\nvim-data", "$env:LOCALAPPDATA\Temp\nvim"
```

(`stdpath("cache")` on Windows is `%LOCALAPPDATA%\Temp\nvim`, separate from
`nvim-data` — easy to miss.)

Then relaunch `nvim` to reinstall everything from `lazy-lock.json`.
