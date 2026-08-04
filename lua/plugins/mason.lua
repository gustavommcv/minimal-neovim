-- Mason: portable package manager for LSP servers, formatters and linters.
-- https://github.com/mason-org/mason.nvim
--
-- mason-lspconfig: bridges mason-installed servers to vim.lsp.enable().
-- https://github.com/mason-org/mason-lspconfig.nvim
--
-- mason-tool-installer: ensures formatters/linters (non-LSP tools) are installed.
-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim

-- The set of LSP servers this config officially supports: installed by Mason
-- and enabled via vim.lsp.enable(). Used for both `ensure_installed` and
-- `automatic_enable` below so there is exactly one list to edit. Installing
-- another server through `:Mason`/`:MasonInstall` does NOT add it here and
-- does NOT enable it — see docs/customization.md#adding-an-lsp-server.
--
-- arduino_language_server is deliberately NOT in this list: it needs
-- arduino-cli, clangd, a board core and a real sketch to do anything, none
-- of which a default install has, so enabling it by default would just be a
-- server that reliably fails to attach. It's opt-in — see
-- docs/customization.md#arduino-support-optional.
local lsp_servers = {
	"lua_ls",
	"gopls",
	"html",
	"cssls",
	"emmet_ls",
	"ts_ls",
	"texlab",
	"pyright",
}

return {
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
			ensure_installed = lsp_servers,
			-- A table (as opposed to `true`) makes this an explicit allowlist:
			-- only servers in `lsp_servers` are auto-enabled, regardless of
			-- what else is installed in Mason.
			automatic_enable = lsp_servers,
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "mason-org/mason.nvim" },
		opts = {
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
		},
	},
}
