---@module 'snacks'
return {
	bigfile = { enabled = true },
	dashboard = require("config.snacks.dashboard"),
	dim = { enabled = true },
	explorer = {
		enabled = true,
		replace_netrw = true,
		trash = true,
	},
	indent = { enabled = true },
	input = { enabled = true },
	notifier = require("config.snacks.notifier"),
	picker = require("config.snacks.picker"),
	quickfile = { enabled = true },
	scope = { enabled = true },
	scroll = { enabled = true },
	statuscolumn = { enabled = true },
	styles = {
		notification = {},
	},
	words = { enabled = true },
}
