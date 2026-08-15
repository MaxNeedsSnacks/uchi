return {
	{
		"lambdalisue/vim-suda",
		config = function()
			vim.g["suda#prompt"] = "Suda: Password: "
			vim.g["suda_smart_edit"] = "1"
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			check_ts = true,
			ts_config = {
				lua = { "string", "source" },
				javascript = { "string", "template_string" },
				java = false,
			},
			disable_filetype = { "TelescopePrompt", "spectre_panel" },
			fast_wrap = {
				map = "<M-e>",
				chars = { "{", "[", "(", '"', "'" },
				pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
				offset = 0,
				end_key = "$",
				keys = "qwertzuiopyxcvbnmasdfghjkl",
				check_comma = true,
				highlight = "PmenuSel",
				highlight_grey = "LineNr",
			},
		},
	},
	-- lazy.nvim
	{
		"chrisgrieser/nvim-origami",
		event = "VeryLazy",
		opts = {}, -- required even when using default config

		-- recommended: disable vim's auto-folding
		init = function()
			vim.opt.foldlevel = 99
			vim.opt.foldlevelstart = 99
		end,
	},
	{
		"NMAC427/guess-indent.nvim",
		opts = true,
	},
}
