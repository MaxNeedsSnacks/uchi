require("config.lsp.handlers").setup()
require("lazy-lsp").setup({
	use_vim_lsp_config = true,
	prefer_local = true,
	preferred_servers = {
		html = { "html" },
		markdown = { "marksman" },
		nix = { "nixd" },
		python = { "basedpyright" },
		cpp = { "clangd" },
	},
	default_config = {
		on_attach = require("config.lsp.handlers").on_attach,
		capabilities = require("config.lsp.handlers").capabilities,
	},

	excluded_servers = {
		"java_language_server",
		"jdtls",
	},

	-- config overrides
	configs = {
		lua_ls = {
			settings = {
				Lua = {
					diagnostics = {
						-- Get the language server to recognize the `vim` global
						globals = { "vim" },
					},
				},
			},
		},
		ltex = {
			settings = {
				ltex = {
					language = "auto",
				},
			},
		},
		nixd = {
			settings = {
				nixd = {
					nixpkgs = {
						expr = "import <nixpkgs> { }",
						--[[expr = vim.fs.root(0, { 'shell.nix' }) ~= nil
							and 'import <nixpkgs> { }'
							or string.format(
								'import (builtins.getFlake "%s").inputs.nixpkgs { }',
								vim.fs.root(0, { 'flake.nix' }) or vim.fn.expand '$FLAKE'
							),]]
					},
					options = {
						options = {
							["home-manager"] = {
								expr = string.format(
									'(builtins.getFlake "%s").homeConfigurations.%s.options',
									vim.fs.root(0, { "flake.nix" }) or vim.fn.expand("$FLAKE"),
									vim.fn.hostname()
								),
							},
							["nix-darwin"] = {
								expr = string.format(
									'(builtins.getFlake "%s").darwinConfigurations.%s.options',
									vim.fs.root(0, { "flake.nix" }) or vim.fn.expand("$FLAKE"),
									vim.fn.hostname()
								),
							},
						},
					},
					formatting = {
						command = { "nixfmt" },
					},
				},
			},
		},
	},
})
