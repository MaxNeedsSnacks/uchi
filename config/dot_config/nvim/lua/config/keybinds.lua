local opts = { noremap = true, silent = true }
local wk = require("which-key")
local keymap = vim.api.nvim_set_keymap

-- Leader Key
keymap("", "<Space>", "<Nop>", opts)

-- Window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize windows with ←↓↑→
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Visual --
-- Stay in mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
keymap("v", "<C-a>", "<C-a>gv", opts)
keymap("v", "<C-x>", "<C-x>gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts) -- stop nvim from yanking things when pasting over other things

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- key groups
wk.add({
	{ "<leader>c", group = "Current Buffer", remap = false },
	{
		"<leader>cc",
		"<cmd>lua vim.opt.list = not vim.opt.list:get()<cr>",
		desc = "Toggle List Chars",
		remap = false,
	},
	{ "<leader>f", group = "Find", remap = false },
	{
		"<leader>ft",
		"<cmd>Telescope treesitter<cr>",
		desc = "Search locals",
		remap = false,
	},
	{
		"<leader>h",
		"<cmd>noh<cr>",
		desc = "Dismiss Highlights",
		remap = false,
	},
	{ "<leader>g", group = "Git", remap = false },
	{
		"<leader>gD",
		"<cmd>Gitsigns diffthis<cr>",
		desc = "Diff current file",
		remap = false,
	},
	{ "<leader>gb", group = "Blame", remap = false },
	{
		"<leader>gbi",
		"<cmd>Gitsigns toggle_current_line_blame<cr>",
		desc = "Show Blame inline",
		remap = false,
	},
	{
		"<leader>gbs",
		"<cmd>Gitsigns blame<cr>",
		desc = "Show Blame in sidebar",
		remap = false,
	},
	{
		"<leader>gbh",
		"<cmd>Gitsigns blame_line<cr>",
		desc = "Show Blame",
		remap = false,
	},
	{
		"zu",
		"za",
		desc = "Toggle fold",
		remap = false,
	},
})
