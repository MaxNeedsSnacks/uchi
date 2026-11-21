vim.pack.add({
	"https://tangled.org/nvim-mini.org/mini.nvim",
})

-- branch and status for the statusline, plus the `:Git` command
require("mini.git").setup()

-- change markers and hunk actions, compared against git's index
require("mini.diff").setup({
	view = {
		-- i prefer gutter lines to symbols (which are used by diagnostics already anyways)
		style = "sign",
		signs = { add = "▎", change = "▎", delete = "▁" },
	},
})

vim.keymap.set("n", "<leader>go", function()
	if not MiniDiff.get_buf_data(0) then
		vim.notify("git: no diff for this buffer", vim.log.levels.WARN)
		return
	end
	MiniDiff.toggle_overlay(0)
end, { desc = "toggle diff overlay" })

-- gitsigns is here only for the blame text on the cursor line
-- i wish mini was able to do this as well but it can't iirc so
vim.pack.add({
	"https://github.com/lewis6991/gitsigns.nvim",
})

require("gitsigns").setup({
	signcolumn = false,
	current_line_blame = true,
})
