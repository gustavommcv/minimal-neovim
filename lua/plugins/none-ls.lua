-- null-ls.nvim reloaded / Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
-- https://github.com/nvimtools/none-ls.nvim
return {
	{
		"nvimtools/none-ls.nvim",

		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvimtools/none-ls-extras.nvim",
		},
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		config = function()
			local mason_null_ls = require("mason-null-ls")
			local null_ls = require("null-ls")

			mason_null_ls.setup({
				ensure_installed = { "stylua", "prettier", "goimports" },
			})

			null_ls.setup({
				sources = {
					-- Formatters
					null_ls.builtins.formatting.stylua, -- Lua
					null_ls.builtins.formatting.prettier, -- JS/TS
					null_ls.builtins.formatting.goimports, -- GOlang

					-- Linters/Diagnostics
					-- null_ls.builtins.diagnostics.eslint_d, -- JS/TS

					-- Completion
					-- null_ls.builtins.completion.spell,
				},
			})
		end,
	},
}
