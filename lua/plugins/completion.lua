-- blink.cmp: performant, batteries-included completion plugin for Neovim.
-- Replaces nvim-cmp + cmp-nvim-lsp + LuaSnip + cmp_luasnip: blink ships its
-- own fuzzy matcher, LSP/path/buffer sources and snippet engine, so those
-- four plugins are no longer needed. friendly-snippets is kept as a source
-- of snippet *data* only (blink.cmp expands them natively).
-- Pinned to the 1.x line, which the plugin's own docs recommend for
-- stability; v2 requires an extra native "blink.lib" dependency.
-- https://github.com/saghen/blink.cmp
--
-- friendly-snippets: community VSCode-style snippets, consumed by blink.cmp.
-- https://github.com/rafamadriz/friendly-snippets

return {
	"saghen/blink.cmp",
	version = "1.*",
	dependencies = { "rafamadriz/friendly-snippets", "folke/lazydev.nvim" },
	opts = {
		keymap = {
			preset = "default",
			-- Keep Enter confirming the selected entry, matching the previous
			-- nvim-cmp `confirm({ select = true })` behavior.
			["<CR>"] = { "select_and_accept", "fallback" },
		},
		completion = {
			-- blink.cmp defaults to no border; the old nvim-cmp config explicitly
			-- bordered both windows via cmp.config.window.bordered(). Kept for
			-- visual parity.
			menu = { border = "rounded" },
			documentation = {
				auto_show = true,
				window = { border = "rounded" },
			},
			ghost_text = { enabled = true },
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer", "lazydev" },
			providers = {
				lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
			},
		},
	},
}
