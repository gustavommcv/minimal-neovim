-- null-ls.nvim reloaded / Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
-- https://github.com/nvimtools/none-ls.nvim
return {
	"nvimtools/none-ls.nvim",

	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvimtools/none-ls-extras.nvim",
	},

	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				-- Formatters
				null_ls.builtins.formatting.stylua, -- Lua
				null_ls.builtins.formatting.prettier, -- JS/TS
				null_ls.builtins.formatting.shfmt, -- Shell

				-- Linters/Diagnostics
				null_ls.builtins.diagnostics.eslint_d, -- JS/TS
				null_ls.builtins.diagnostics.shellcheck, -- Shell

				-- Completion
				null_ls.builtins.completion.spell,
			},
		})

		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {
			desc = "[G]o [F]ormat (LSP)",
		})
	end,
}
