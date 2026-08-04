-- An asynchronous linter plugin for Neovim
-- https://github.com/mfussenegger/nvim-lint

return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		-- Note: <leader>cl is taken by Trouble's LSP list (see trouble.lua),
		-- so the manual lint trigger uses a capital L instead.
		vim.keymap.set("n", "<leader>cL", function()
			lint.try_lint()
		end, { desc = "[C]ode [L]int" })
	end,
}
