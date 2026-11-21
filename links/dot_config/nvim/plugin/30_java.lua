vim.pack.add({
	"https://github.com/mfussenegger/nvim-jdtls",
})

-- todo: at some point, configure runtimes so i can run stuff other than default `java`
vim.lsp.config("jdtls", {
	init_options = {
		-- lets jdtls hand over sources of classes inside jars, decompiled if needed
		extendedClientCapabilities = require("jdtls.capabilities"),
	},
})
vim.lsp.enable("jdtls")

vim.api.nvim_create_autocmd("FileType", {
	pattern = "java",
	callback = function(args)
		vim.keymap.set(
			"n",
			"<leader>co",
			function() require("jdtls").organize_imports() end,
			{ buffer = args.buf, desc = "organize imports" }
		)
	end,
})
