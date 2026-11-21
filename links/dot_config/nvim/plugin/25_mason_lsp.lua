vim.pack.add({
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
})

require("mason").setup()
-- enables every mason-installed server automatically
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls" },
})

-- installed outside mason so they match the local toolchains
vim.lsp.enable({ "rust_analyzer", "clangd" })

vim.diagnostic.config({
	virtual_text = {
		current_line = false,
		source = "if_many",
	},
	virtual_lines = { current_line = true },
	severity_sort = true,
	signs = {
		--        text = {
		--            [vim.diagnostic.severity.ERROR] = "",
		--            [vim.diagnostic.severity.WARN] = "",
		--            [vim.diagnostic.severity.INFO] = "",
		--            [vim.diagnostic.severity.HINT] = ""
		--        },
		numhl = {
			[vim.diagnostic.severity.ERROR] = "DiagnosticError",
			[vim.diagnostic.severity.WARN] = "DiagnosticWarn",
		},
	},
})

vim.keymap.set("n", "<leader>d", function() Snacks.picker.diagnostics_buffer() end, { desc = "file diagnostics" })
vim.keymap.set("n", "<leader>D", function() Snacks.picker.diagnostics() end, { desc = "project diagnostics" })

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local map = function(lhs, rhs, desc) vim.keymap.set("n", lhs, rhs, { buffer = args.buf, desc = desc }) end

		-- same keys as gram
		map("gs", function() Snacks.picker.lsp_symbols() end, "file symbols")
		map("gS", function() Snacks.picker.lsp_workspace_symbols() end, "project symbols")

		map("gd", function() Snacks.picker.lsp_definitions() end, "definition")
		map("gD", function() Snacks.picker.lsp_declarations() end, "declaration")
		map("gy", function() Snacks.picker.lsp_type_definitions() end, "type definition")
		map("gI", function() Snacks.picker.lsp_implementations() end, "implementations")
		map("gai", function() Snacks.picker.lsp_incoming_calls() end, "incoming calls")
		map("gao", function() Snacks.picker.lsp_outgoing_calls() end, "outgoing calls")
	end,
})
