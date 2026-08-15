-- setup general look of neovim
vim.opt.fillchars = { eob = " " } -- Hide "End of Buffer" (Tilde) Character
vim.opt.number = true -- Show Line Numbers
vim.opt.relativenumber = true -- Show *Relative* Line Numbers
vim.opt.cursorline = true -- highlight current line

-- tab settings
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- misc settings
vim.opt.clipboard = "unnamedplus" -- Use System Clipboard
vim.opt.showmode = false
vim.opt.numberwidth = 4
vim.opt.signcolumn = "yes"
vim.opt.listchars = "tab:<->,multispace:·,space:␣,trail:·,eol:↵"

-- transparent winbar
vim.api.nvim_set_hl(0, "WinBar", { fg = "#ffffff", bg = nil })
vim.api.nvim_set_hl(0, "WinBarNC", { fg = "#ffffff", bg = nil })

-- spellcheck
vim.opt.spelllang = { "en", "de" }
