vim.pack.add({
	-- tagged releases ship a prebuilt fuzzy matcher so i don't have to build from src
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
})

require("blink.cmp").setup({
	keymap = {
		-- <C-n> / <C-p> to navigate (if super-tab you can also use arrows)
		preset = "super-tab", -- todo: use default if this gets in the way
	},
	completion = {
		documentation = { auto_show = true },
	},
	sources = {
		default = { "lazydev", "lsp", "path", "snippets", "buffer" },
		providers = {
			-- rank nvim api completions above lua_ls' generic ones
			lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
		},
	},
})
