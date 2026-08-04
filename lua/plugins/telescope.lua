-- Find, Filter, Preview, Pick. All lua, all the time.
-- https://github.com/nvim-telescope/telescope.nvim
--
-- telescope-ui-select.nvim: use the Telescope picker for vim.ui.select() (e.g. code actions)
-- https://github.com/nvim-telescope/telescope-ui-select.nvim

return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	cmd = "Telescope",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
	},
	keys = {
		{
			"<leader>ff",
			function()
				require("telescope.builtin").find_files()
			end,
			desc = "Find files",
		},
		{
			"<leader>fg",
			function()
				require("telescope.builtin").live_grep()
			end,
			desc = "Live grep",
		},
		{
			"<C-p>",
			function()
				require("telescope.builtin").git_files()
			end,
			desc = "Find git files",
		},
	},
	config = function()
		require("telescope").setup({
			defaults = {
				layout_strategy = "vertical",
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown({}),
				},
			},
		})
		require("telescope").load_extension("ui-select")
	end,
}
