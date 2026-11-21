vim.pack.add({
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/folke/noice.nvim",
})

require("noice").setup({
	-- the command line takes over the bottom row while typing
	cmdline = {
		view = "cmdline",
		format = {
			cmdline = { pattern = "^:", icon = "", lang = "vim" },
			search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
			search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
			filter = { pattern = "^:%s*!", icon = "$", lang = "fish" },
			lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
			help = { pattern = "^:%s*he?l?p?%s+", icon = "?" },
			input = { view = "cmdline_input", icon = "󰥻 " },
		},
	},
	messages = {
		view_search = "mini",
	},
	lsp = {
		progress = { view = "mini" },
		-- render hover and signature docs through treesitter
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
		},
	},
	presets = {
		bottom_search = true,
		long_message_to_split = true,
		lsp_doc_border = true,
	},
	views = {
		mini = { win_options = { winblend = 0 } },
	},
	routes = {
		{ filter = { event = "msg_show", kind = { "shell_out" } }, view = "split", opts = { level = "info" } },
		{ filter = { event = "msg_show", kind = { "shell_err" } }, view = "notify", opts = { level = "error" } },
	},
})
