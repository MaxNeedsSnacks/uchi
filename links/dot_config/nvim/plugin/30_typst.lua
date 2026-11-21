vim.pack.add({
	"https://github.com/chomosuke/typst-preview.nvim",
})

-- typstyle and tinymist both come from this config anyways
vim.lsp.config("tinymist", {
	settings = {
		formatterMode = "typstyle",
	},
})
vim.lsp.enable("tinymist")

require("typst-preview").setup({
	dependencies_bin = { tinymist = "tinymist" },
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "typst",
	callback = function(args)
		vim.keymap.set("n", "<leader>cp", "<Cmd>TypstPreviewToggle<CR>", { buffer = args.buf, desc = "toggle preview" })
	end,
})
