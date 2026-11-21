vim.pack.add({
	"https://github.com/folke/lazydev.nvim",
})

-- feeds lua_ls the nvim runtime plus plugin sources
require("lazydev").setup({
	library = {
		-- load a plugin's types when one of `words` appears in the file
		{ path = "snacks.nvim", words = { "Snacks" } },
	},
})
