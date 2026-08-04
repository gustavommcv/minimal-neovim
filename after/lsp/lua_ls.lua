-- Overrides nvim-lspconfig's default lua_ls config (see :h lsp-config, "after/" merges last).
return {
	settings = {
		Lua = {
			-- Silence the "do you need to configure your workspace as luv" popup.
			-- lua/plugins/lazydev.lua already injects the Neovim runtime and
			-- installed plugins into the workspace library, so we don't
			-- duplicate that here.
			workspace = { checkThirdParty = false },
		},
	},
}
