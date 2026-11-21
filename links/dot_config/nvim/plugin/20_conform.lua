vim.pack.add({
	"https://github.com/stevearc/conform.nvim",
})

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		sh = { "shfmt" },
		bash = { "shfmt" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		css = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
	},

	-- anything not listed above is formatted by its language server
	default_format_opts = { lsp_format = "fallback" },

	-- <leader>uf switches this off, e.g. in repos without a formatter config
	format_on_save = function()
		if vim.g.format_on_save ~= false then
			return { timeout_ms = 500 }
		end
	end,
})

vim.keymap.set({ "n", "x" }, "<leader>cf", function() require("conform").format() end, { desc = "format" })
