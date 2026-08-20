-- Neovim plugin to manage the file system and other tree like structures.
-- https://github.com/nvim-neo-tree/neo-tree.nvim
--
-- Note: image previews (3rd/image.nvim) are intentionally not wired in here.
-- That dependency requires ImageMagick and fails to build out of the box on
-- Windows; see docs/troubleshooting.md if you want to add it back manually.

-- neo-tree's own M.setup() already hijacks netrw for a directory argument
-- and, via the default `bind_to_cwd`, syncs Neovim's cwd to match -- but
-- only if setup() runs before VimEnter (`vim.v.vim_did_enter == 0`, checked
-- in its own source). Lazy-loading on cmd/keys alone means that never
-- happens in time for `nvim <directory>`, so force eager loading in that
-- one case; stay lazy for the far more common case of just opening a file.
local function starts_on_directory()
	return vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0) --[[@as string]]) == 1
end

return {
	"nvim-neo-tree/neo-tree.nvim",
	lazy = not starts_on_directory(),
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
