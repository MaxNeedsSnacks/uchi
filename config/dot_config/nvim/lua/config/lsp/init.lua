local handlers = require("config.lsp.handlers")

vim.lsp.config("*", {
	capabilities = handlers.capabilities,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client then
			handlers.on_attach(client, args.buf)
		end
	end,
})

-- config overrides, merged on top of nvim-lspconfig's defaults
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
		},
	},
})

vim.lsp.config("ltex", {
	settings = {
		ltex = {
			language = "auto",
		},
	},
})

require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"jdtls",
		"gradle_ls",
		"marksman",
		"html",
		"clangd",
	},
	-- every other installed server gets vim.lsp.enable()'d automatically
	automatic_enable = {
		-- started by nvim-jdtls instead
		exclude = { "jdtls" },
	},
})
