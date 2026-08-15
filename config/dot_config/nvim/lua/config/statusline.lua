return function()
	local function load_feline()
		package.loaded["feline"] = nil
		package.loaded["catppuccin.special.feline"] = nil

		local ctp_feline = require("catppuccin.special.feline")

		ctp_feline.setup()

		require("feline").setup({
			-- todo (maybe): use my own components again
			components = ctp_feline.get_statusline(),
			force_inactive = {
				filetypes = { "neo-tree", "NvimTree", "lir" },
				buftypes = {},
				bufnames = {},
			},
		})
	end

	local augroup = vim.api.nvim_create_augroup("CtpFeline", { clear = true })

	vim.api.nvim_create_autocmd("ColorScheme", {
		group = augroup,
		desc = "Reload feline after colorscheme changes",
		callback = load_feline,
	})

	load_feline()
end
