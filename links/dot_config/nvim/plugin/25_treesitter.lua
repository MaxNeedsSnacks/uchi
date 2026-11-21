vim.pack.add({
	"https://github.com/nvim-treesitter/nvim-treesitter",
})

-- keep expanding this list as i force myself to use even more programming languages
require("nvim-treesitter").install({
	"bash",
	"cpp",
	"css",
	"fish",
	"html",
	"java",
	"javascript",
	"json",
	"just",
	"python",
	"regex",
	"rust",
	"toml",
	"tsx",
	"typescript",
	"typst",
	"yaml",
})

vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		-- fails quietly for filetypes without a parser
		if not pcall(vim.treesitter.start, args.buf) then
			return
		end

		vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})
