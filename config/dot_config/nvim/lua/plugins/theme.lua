return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		lazy = false,
		config = function()
			require("catppuccin").setup({
				flavour = "auto",
				transparent_background = true,
				float = {
					transparent = true,
					solid = true,
				},
				auto_integrations = true,
				integrations = {
					cmp = true,
					gitsigns = true,
					native_lsp = { enabled = true },
					noice = true,
					snacks = true,
					telescope = true,
					treesitter = true,
				},
			})

			vim.o.winborder = "rounded"
			vim.cmd.colorscheme("catppuccin")
		end,
	},
	{ "folke/tokyonight.nvim" },
	{ "rebelot/kanagawa.nvim" },
	{ "thesimonho/kanagawa-paper.nvim" },
	{
		-- use transparent background
		"xiyaowong/transparent.nvim",
		opts = {
			extra_groups = {
				"TelescopeNormal",
				"TelescopeBorder",
				"TelescopePromptBorder",
			},
			exclude_groups = {}, -- table: groups you don't want to clear
		},
	},
	{
		"second2050/feline.nvim",
		name = "feline",
		dependencies = {
			"catppuccin/nvim",
		},
		config = require("config.statusline"),
	},
}
