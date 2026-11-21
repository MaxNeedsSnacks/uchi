vim.pack.add({
	{ src = "https://github.com/rose-pine/neovim", name = "rose-pine" },
})

require("rose-pine").setup({
	variant = "auto",
	dark_variant = "moon",
	styles = { transparency = true },
})

vim.cmd.colorscheme("rose-pine")

vim.o.winborder = "rounded"
