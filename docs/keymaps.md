# Keymaps

Leader key: `<Space>`. Only keymaps that are actually defined in this config
are listed below — if it's not here, it's a Neovim default.

## Editing / clipboard

| Mode | Key | Action |
| --- | --- | --- |
| Visual | `<leader>y` | Copy selection to system clipboard |
| Visual | `<leader>p` | Paste from system clipboard |
| Normal | `<leader>Y` | Copy entire buffer to system clipboard |

## Diagnostics

| Mode | Key | Action |
| --- | --- | --- |
| Normal | `]d` | Next diagnostic (opens float) |
| Normal | `[d` | Previous diagnostic (opens float) |
| Normal | `<leader>xx` | Diagnostics list (Trouble) |
| Normal | `<leader>xX` | Buffer diagnostics (Trouble) |
| Normal | `<leader>xL` | Location list (Trouble) |
| Normal | `<leader>xQ` | Quickfix list (Trouble) |

## LSP *(buffer-local, only active where a client is attached)*

| Mode | Key | Action |
| --- | --- | --- |
| Normal | `K` | Hover documentation |
| Normal | `gd` | Go to definition |
| Normal | `gD` | Go to declaration |
| Normal | `gr` | Go to references |
| Normal | `gI` | Go to implementation |
| Normal | `<leader>rn` | Rename symbol |
| Normal + Visual | `<leader>ca` | Code action |
| Normal | `<leader>cs` | Symbols (Trouble) |
| Normal | `<leader>cl` | LSP definitions/references list (Trouble) |

## Formatting / linting

| Mode | Key | Action |
| --- | --- | --- |
| Normal + Visual | `<leader>gf` | Format buffer/selection (conform.nvim) |
| Normal | `<leader>cL` | Trigger linters manually (nvim-lint) |

Formatting is manual by default. Commands: `:FormatEnable` (turn
format-on-save on, global), `:FormatEnable!` (buffer-local),
`:FormatDisable` (turn it back off), `:ConformInfo`.

## Files / search

| Mode | Key | Action |
| --- | --- | --- |
| Normal | `<leader>ff` | Find files (Telescope) |
| Normal | `<leader>fg` | Live grep (Telescope, needs ripgrep) |
| Normal | `<C-p>` | Find git-tracked files (Telescope) |
| Normal | `<leader>e` | Toggle file explorer (Neo-tree) |

## Git (gitsigns, buffer-local where a git repo is detected)

| Mode | Key | Action |
| --- | --- | --- |
| Normal | `]c` | Next git hunk |
| Normal | `[c` | Previous git hunk |

Gutter signs (added/changed/deleted lines) are drawn with no keymaps or
config at all. Stage/reset/preview/blame are intentionally not bound — see
[migration.md](migration.md).

## TODO comments

| Mode | Key | Action |
| --- | --- | --- |
| Normal | `<leader>tt` | Project TODOs (Trouble) |

## Completion (insert mode, blink.cmp)

| Key | Action |
| --- | --- |
| `<C-space>` | Show menu / toggle documentation |
| `<CR>` | Accept selected entry (falls back to a normal Enter otherwise) |
| `<C-y>` | Accept selected entry |
| `<C-e>` | Close menu |
| `<Up>`/`<Down>`/`<C-n>`/`<C-p>` | Navigate entries |
| `<Tab>`/`<S-Tab>` | Jump forward/backward in a snippet |
| `<C-b>`/`<C-f>` | Scroll documentation |

## which-key / help

| Mode | Key | Action |
| --- | --- | --- |
| Normal | `<leader>?` | Show buffer-local keymaps (which-key) |

There is no custom terminal-mode mapping in this config.
