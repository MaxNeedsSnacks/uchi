-- leader must be set before any mapping that uses it
vim.g.mapleader = " "
vim.g.maplocalleader = ","

local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 8

opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4

opt.ignorecase = true
opt.smartcase = true

opt.splitright = true
opt.splitbelow = true

opt.undofile = true
opt.confirm = true

opt.fillchars:append({ eob = " " })

local map = vim.keymap.set

map("n", "<Esc>", "<Cmd>nohlsearch<CR>")

-- german layout remaps (todo: idk if i will use those tbh)
map({ "n", "o", "x" }, "ö", "[", { remap = true })
map({ "n", "o", "x" }, "ä", "]", { remap = true })
map({ "n", "o", "x" }, "Ö", "{", { remap = true })
map({ "n", "o", "x" }, "Ä", "}", { remap = true })

-- yank goes to primary system clipboard, <leader>p to paste from it
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		local e = vim.v.event
		if e.operator == "y" and e.regname == "" then
			vim.fn.setreg("+", e.regcontents, e.regtype)
		end
	end,
})
map({ "n", "x" }, "<leader>p", '"+p')
