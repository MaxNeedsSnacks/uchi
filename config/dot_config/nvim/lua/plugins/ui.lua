return {
	{
		"folke/noice.nvim",
		priority = 1000,
		lazy = false,
		opts = require("config.noice"),
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = require("config.snacks"),
		keys = require("config.snacks.keys"),
		init = require("config.snacks.setup"),
		dependencies = {
			"echasnovski/mini.icons",
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			current_line_blame = true,
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		lazy = true,
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
				lazy = true,
			},
		},
	},
	{
		"folke/which-key.nvim",
		config = true,
		lazy = true,
	},
	{
		-- Actually color colorcodes like #ff0000
		"norcalli/nvim-colorizer.lua",
		name = "colorizer",
		config = function()
			require("colorizer").setup({
				"*",
				html = {
					names = true,
					css = true,
				},
				css = {
					names = true,
					css = true,
				},
			}, {
				names = false,
				mode = "background",
			})
		end,
		lazy = true,
		event = { "BufRead" },
	},
}
