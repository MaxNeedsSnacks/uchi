vim.pack.add({
	"https://github.com/folke/snacks.nvim",
})

require("snacks").setup({
	picker = {
		sources = {
			explorer = {
				actions = {
					explorer_reveal = function(_, item)
						if not item then
							return
						end
						if vim.fn.has("mac") == 1 then
							vim.system({ "open", "-R", item.file })
						else
							-- no portable way to highlight the file, so open its folder
							---@diagnostic disable-next-line: param-type-mismatch
							vim.ui.open(vim.fs.dirname(item.file))
						end
					end,
					explorer_mkdir = function(picker)
						Snacks.input({ prompt = "New folder" }, function(value)
							if not value or vim.trim(value) == "" then
								return
							end
							local path = vim.fs.normalize(picker:dir() .. "/" .. value)
							vim.fn.mkdir(path, "p")
							local tree = require("snacks.explorer.tree")
							tree:open(path)
							tree:refresh(vim.fs.dirname(path))
							require("snacks.explorer.actions").update(picker, { target = path })
						end)
					end,
				},
				win = {
					list = {
						keys = {
							["%"] = "explorer_add",
							["d"] = "explorer_mkdir",
							["x"] = "explorer_reveal",
							["s"] = "explorer_open",
							["D"] = "explorer_del",
							["R"] = "explorer_rename",
							["a"] = false,
							["r"] = false,
							["o"] = false,
						},
					},
				},
			},
		},
	},
	explorer = {},
	bigfile = {},
	input = {},
	words = {},
	indent = {},
	notifier = { timeout = 3000 },
	-- `ii` / `ai` textobjects and `[i` / `]i` jumps
	scope = { treesitter = { enabled = false } },
})

local map = vim.keymap.set

-- { keys, picker, description, picker opts }
local pickers = {
	{ "<leader><space>", "smart", "smart find" },
	{ "<leader>/", "grep", "grep" },
	{ "<leader>,", "buffers", "buffers" },
	{ "<leader>:", "command_history", "command history" },
	{ "<leader>;", "pickers", "all pickers" },
	{ "<leader>n", "notifications", "notification history" },

	{ "<leader>fb", "buffers", "buffers" },
	{ "<leader>fc", "files", "config files", { cwd = vim.fn.stdpath("config") } },
	{ "<leader>ff", "files", "files" },
	{ "<leader>fp", "projects", "projects" },
	{ "<leader>fr", "recent", "recent files" },

	{ "<leader>gB", "git_branches", "branches" },
	{ "<leader>gd", "git_diff", "changed hunks" },
	{ "<leader>gf", "git_log_file", "log for this file" },
	{ "<leader>gl", "git_log", "log" },
	{ "<leader>gL", "git_log_line", "log for this line" },
	{ "<leader>gs", "git_status", "status" },

	{ '<leader>s"', "registers", "registers" },
	{ "<leader>s/", "search_history", "search history" },
	{ "<leader>sa", "autocmds", "autocmds" },
	{ "<leader>sb", "lines", "lines in buffer" },
	{ "<leader>sB", "grep_buffers", "grep open buffers" },
	{ "<leader>sC", "commands", "commands" },
	{ "<leader>sd", "diagnostics_buffer", "file diagnostics" },
	{ "<leader>sD", "diagnostics", "project diagnostics" },
	{ "<leader>sh", "help", "help pages" },
	{ "<leader>sH", "highlights", "highlights" },
	{ "<leader>si", "icons", "icons" },
	{ "<leader>sj", "jumps", "jumplist" },
	{ "<leader>sk", "keymaps", "keymaps" },
	{ "<leader>sm", "marks", "marks" },
	{ "<leader>sM", "man", "man pages" },
	{ "<leader>sq", "qflist", "quickfix list" },
	{ "<leader>sR", "resume", "resume last picker" },
	{ "<leader>su", "undo", "undo history" },
}

for _, p in ipairs(pickers) do
	map("n", p[1], function() Snacks.picker[p[2]](p[4]) end, { desc = p[3] })
end

map({ "n", "x" }, "<leader>sw", function() Snacks.picker.grep_word() end, { desc = "grep word or selection" })
map("n", "<leader>e", function() Snacks.explorer() end, { desc = "explorer" })
map("n", "<leader>cR", function() Snacks.rename.rename_file() end, { desc = "rename file" })

-- jump between references of the symbol under the cursor
map("n", "]]", function() Snacks.words.jump(vim.v.count1) end, { desc = "next reference" })
map("n", "[[", function() Snacks.words.jump(-vim.v.count1) end, { desc = "previous reference" })
