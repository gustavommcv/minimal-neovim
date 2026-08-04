-- Neovim plugin to manage the file system and other tree like structures.
-- https://github.com/nvim-neo-tree/neo-tree.nvim
--
-- Note: image previews (3rd/image.nvim) are intentionally not wired in here.
-- That dependency requires ImageMagick and fails to build out of the box on
-- Windows; see docs/troubleshooting.md if you want to add it back manually.

return {
	"nvim-neo-tree/neo-tree.nvim",
	cmd = "Neotree",
	keys = {
		{ "<leader>e", "<Cmd>Neotree toggle<CR>", desc = "Toggle file explorer" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	opts = {
		close_if_last_window = true,
		window = {
			position = "right",
			width = 40,
		},
		filesystem = {
			follow_current_file = {
				enabled = true,
				leave_dirs_open = true,
			},
			filtered_items = {
				visible = true,
			},
			use_libuv_file_watcher = true,
		},
		event_handlers = {
			{
				event = "file_opened",
				handler = function()
					require("neo-tree").close_all()
				end,
			},
		},
	},
}
