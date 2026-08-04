-- Git decorations (added/changed/deleted lines) for buffers.
-- https://github.com/lewis6991/gitsigns.nvim

return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		on_attach = function(bufnr)
			local gitsigns = require("gitsigns")
			local map = function(mode, lhs, rhs, desc)
				vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
			end

			-- Navigation only: the natural complement to the gutter signs
			-- gitsigns already draws with no config at all.
			map("n", "]c", function()
				gitsigns.nav_hunk("next")
			end, "Next git hunk")
			map("n", "[c", function()
				gitsigns.nav_hunk("prev")
			end, "Previous git hunk")
		end,
	},
}
