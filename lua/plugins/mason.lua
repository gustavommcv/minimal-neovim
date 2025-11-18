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
				ensure_installed = { "lua_ls", "ts_ls", "gopls", "dockerls", "somesass_ls", "angularls", "texlab" },
				handlers = {
					function(server_name) -- default
						require("lspconfig")[server_name].setup({})
					end,
				},
			})
		end,
	},
}
