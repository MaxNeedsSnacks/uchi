return {
	-- filetypes
	{ "imsnif/kdl.vim" },
	{ "isobit/vim-caddyfile" },
	{
		"mfussenegger/nvim-jdtls",
		ft = "java",
		config = function()
			require("config.lsp.jdtls").setup()
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		opts = true,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-mini/mini.nvim",
		},
	},
	-- lsp
	{
		"dundalek/lazy-lsp.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("config.lsp.lazy-lsp")
		end,
		cond = function()
			if vim.fn.executable("nix") == 1 then
				return true
			else
				vim.notify_once(
					"`nix` not available, no language servers will be available!",
					vim.log.levels.WARN,
					{ level = "warning" }
				)
				return false
			end
		end,
	},
	{
		"glepnir/lspsaga.nvim",
		branch = "main",
		opts = {
			ui = {
				border = "rounded",
				code_action = "",
			},
			lightbulb = {
				virtual_text = false,
			},
		},
		lazy = true,
		cmd = "Lspsaga",
		event = "LspAttach",
	},
	{ "aznhe21/actions-preview.nvim" },
	-- misc
	{
		"nvim-treesitter/nvim-treesitter", -- Better syntax highlighting
		build = ":TSUpdate",
		lazy = false,
		keys = {
			{
				"<leader>cf",
				function()
					vim.lsp.buf.format()
				end,
				desc = "Format File",
				remap = false,
			},
		},
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		init = function()
			vim.api.nvim_create_autocmd("BufWritePre", {
				callback = function(ev)
					local id = ev.id
					local clients = vim.lsp.get_clients({ bufnr = ev.buf })
					if #clients == 0 then
						return
					end

					local client = clients[1]
					local support_format = client and client.server_capabilities.documentFormattingProvider
					local mode = vim.api.nvim_get_mode().mode
					if support_format and vim.bo.modified == true and mode == "n" then
						vim.lsp.buf.format({ async = true, bufnr = ev.buf })
					end
				end,
			})
		end,
		config = function()
			if vim.fn.executable("tree-sitter") == 0 then
				vim.notify(
					"tree-sitter cli is not installed\nyou need it for tree-sitter grammars",
					vim.log.levels.ERROR
				)
				return
			end

			local ts = require("nvim-treesitter")
			ts.setup()

			vim.api.nvim_create_autocmd("FileType", {
				callback = function(ev)
					if vim.tbl_contains(ts.get_installed(), ev.match) then
						vim.treesitter.start()
					end
				end,
			})
		end,
	},
	{
		"Dronakurl/injectme.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		cmd = { "InjectmeToggle", "InjectmeSave", "InjectmeInfo", "InjectmeLeave" },
	},
	{
		-- The completion plugin
		"hrsh7th/nvim-cmp",
		lazy = true,
		cmd = { "BufRead" },
		config = function()
			require("config.cmp")
		end,
		dependencies = {
			"hrsh7th/cmp-buffer", -- buffer completions
			"hrsh7th/cmp-path", -- path completions
			"hrsh7th/cmp-cmdline", -- cmdline completions
			{
				-- snippet completions
				"saadparwaiz1/cmp_luasnip",
				lazy = true,
				dependencies = {
					{
						"L3MON4D3/LuaSnip",
						name = "luasnip",
						lazy = true,
						config = function()
							require("luasnip").config.setup({
								history = false,
							})
						end,
						dependencies = {
							"rafamadriz/friendly-snippets",
						},
					},
				},
			},
			{
				"onsails/lspkind.nvim",
				opts = true,
			},
		},
	},
	{
		-- luals for neovim itself!
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {},
		},
	},
}
