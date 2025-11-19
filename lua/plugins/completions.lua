-- nvim-cmp
-- A completion plugin for neovim coded in Lua.
-- https://github.com/hrsh7th/nvim-cmp

-- cmp-nvim-lsp
-- nvim-cmp source for neovim builtin LSP client
-- https://github.com/hrsh7th/cmp-nvim-lsp

-- luasnip
-- Snippet Engine for Neovim written in Lua.
-- https://github.com/L3MON4D3/LuaSnip

-- cmp_luasnip
-- luasnip completion source for nvim-cmp
-- https://github.com/saadparwaiz1/cmp_luasnip

-- friendly-snippets
-- Set of preconfigured snippets for different languages.
-- https://github.com/rafamadriz/friendly-snippets

return {
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			require("luasnip.loaders.from_vscode").lazy_load({})

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
				}),
			})
		end,
	},
}
