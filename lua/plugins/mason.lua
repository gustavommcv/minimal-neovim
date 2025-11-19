-- Mason
-- Portable package manager for Neovim that runs everywhere Neovim runs. Easily install and manage LSP servers, DAP servers,
-- linters, and formatters.
-- https://github.com/mason-org/mason.nvim

-- Mason LSP config
-- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim.
-- https://github.com/mason-org/mason-lspconfig.nvim

return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"gopls",
					"html",
					"cssls",
					"emmet_ls",
					"ts_ls",
				},
				handlers = {
					function(server_name) -- default
						require("lspconfig")[server_name].setup({})
					end,
				},
			})
		end,
	},
}
