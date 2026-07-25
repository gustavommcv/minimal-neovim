-- Mason
-- Portable package manager for Neovim that runs everywhere Neovim runs. Easily install and manage LSP servers, DAP servers,
-- linters, and formatters.
-- https://github.com/mason-org/mason.nvim

return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					-- Formatters
					"stylua",
					"prettierd",
					"prettier",
					"goimports",
					"ruff",
					-- Linters
					"eslint_d",
				},
			})
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
					"texlab",
					"pyright",
					"arduino_language_server",
				},
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({})
					end,

					["arduino_language_server"] = function()
						require("lspconfig").arduino_language_server.setup({
							cmd = {
								"arduino-language-server",
								"-cli",
								"arduino-cli",
								"-cli-config",
								vim.fn.expand("~/.arduino15/arduino-cli.yaml"),
								"-fqbn",
								"arduino:avr:leonardo",
								"-clangd",
								"/usr/bin/clangd",
							},
						})
					end,
				},
			})
		end,
	},
}
