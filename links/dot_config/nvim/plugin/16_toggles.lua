-- depends on 10_snacks.lua for the Snacks global
local toggle = Snacks.toggle

toggle.option("spell", { name = "spelling" }):map("<leader>us")
toggle.option("wrap", { name = "wrap" }):map("<leader>uw")
toggle.option("relativenumber", { name = "relative numbers" }):map("<leader>uL")
toggle.line_number():map("<leader>ul")
toggle.diagnostics():map("<leader>ud")
toggle.inlay_hints():map("<leader>uh")
toggle.indent():map("<leader>ug")
toggle.treesitter():map("<leader>uT")

toggle({
	name = "format on save",
	get = function() return vim.g.format_on_save ~= false end,
	set = function(state) vim.g.format_on_save = state end,
}):map("<leader>uf")

toggle({
	name = "inline blame",
	get = function() return require("gitsigns.config").config.current_line_blame end,
	set = function(state) require("gitsigns").toggle_current_line_blame(state) end,
}):map("<leader>ub")

vim.keymap.set("n", "<leader>un", function() Snacks.notifier.hide() end, { desc = "dismiss notifications" })
