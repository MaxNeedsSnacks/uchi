vim.pack.add({
	"https://tangled.org/nvim-mini.org/mini.nvim",
})

require("mini.ai").setup()
require("mini.pairs").setup()
require("mini.icons").setup()

-- vim-surround style keys, matching gram / ideavim / vscode
-- todo: if i stop using `s` i could use the defaults from mini.surround here
require("mini.surround").setup({
	mappings = {
		add = "ys",
		delete = "ds",
		replace = "cs",
		find = "",
		find_left = "",
		highlight = "",
		suffix_last = "",
		suffix_next = "",
	},
	search_method = "cover_or_next",
})

local map = vim.keymap.set

-- `ys` in visual mode would delay plain `y`
vim.keymap.del("x", "ys")
map("x", "S", [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })
map("n", "yss", "ys_", { remap = true })

map("n", "<leader>cd", function() require("mini.bufremove").delete() end, { desc = "close buffer" })
