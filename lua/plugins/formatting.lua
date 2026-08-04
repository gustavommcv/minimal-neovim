-- Lightweight yet powerful formatter plugin for Neovim
-- https://github.com/stevearc/conform.nvim

return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>gf",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = { "n", "v" },
			desc = "[G]o [F]ormat",
		},
	},

	init = function()
		-- Formatting is manual by default (<leader>gf / :ConformInfo).
		-- :FormatEnable / :FormatEnable! (buffer-local) turns format-on-save
		-- on; :FormatDisable turns it back off.
		vim.api.nvim_create_user_command("FormatEnable", function(args)
			if args.bang then
				vim.b.autoformat = true
			else
				vim.g.autoformat = true
			end
		end, { desc = "Enable format-on-save, use ! for buffer-local", bang = true })

		vim.api.nvim_create_user_command("FormatDisable", function()
			vim.b.autoformat = false
			vim.g.autoformat = false
		end, { desc = "Disable format-on-save" })
	end,

	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			-- Use prettierd first (faster daemon), fallback to prettier
			javascript = { "prettierd", "prettier", stop_after_first = true },
			typescript = { "prettierd", "prettier", stop_after_first = true },
			javascriptreact = { "prettierd", "prettier", stop_after_first = true },
			typescriptreact = { "prettierd", "prettier", stop_after_first = true },
			css = { "prettierd", "prettier", stop_after_first = true },
			html = { "prettierd", "prettier", stop_after_first = true },
			json = { "prettierd", "prettier", stop_after_first = true },
			yaml = { "prettierd", "prettier", stop_after_first = true },
			markdown = { "prettierd", "prettier", stop_after_first = true },
			go = { "goimports" },
			python = { "ruff_format" },
		},
		default_format_opts = {
			lsp_format = "fallback",
		},
		-- Off by default: formatting is manual (<leader>gf). Run :FormatEnable
		-- (or :FormatEnable! for one buffer) to opt into format-on-save.
		format_on_save = function(bufnr)
			if not (vim.g.autoformat or vim.b[bufnr].autoformat) then
				return
			end
			return { timeout_ms = 500, lsp_format = "fallback" }
		end,
	},
}
