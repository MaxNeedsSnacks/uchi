-- replaces what i used to use of lspsaga

vim.pack.add({
	"https://github.com/Bekaboo/dropbar.nvim",
	"https://github.com/kosayoda/nvim-lightbulb",
})

-- breadcrumbs at the top
require("dropbar").setup()

-- marks the cursor line when the language server offers code actions (`gra`)
require("nvim-lightbulb").setup({
	autocmd = { enabled = true },
	priority = 250, -- always on top
	sign = { text = "\u{f0336}" },
})
