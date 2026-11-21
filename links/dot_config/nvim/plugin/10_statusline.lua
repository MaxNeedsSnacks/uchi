vim.pack.add({
	"https://tangled.org/nvim-mini.org/mini.nvim",
})

local statusline = require("mini.statusline")

-- nerdfont powerline code points
local CAP_LEFT, CAP_RIGHT = "\u{e0b6}", "\u{e0b4}"

local MODE_GROUPS = {
	"MiniStatuslineModeNormal",
	"MiniStatuslineModeInsert",
	"MiniStatuslineModeVisual",
	"MiniStatuslineModeReplace",
	"MiniStatuslineModeCommand",
	"MiniStatuslineModeOther",
}

-- dynamically update colours with the theme
local function update_highlights()
	local function get(name) return vim.api.nvim_get_hl(0, { name = name, link = false }) end

	vim.api.nvim_set_hl(0, "StatuslineText", { fg = get("StatusLine").fg })
	vim.api.nvim_set_hl(0, "StatuslineFile", { fg = get("MiniStatuslineModeNormal").fg, bg = get("Function").fg })
	vim.api.nvim_set_hl(0, "StatuslineDir", { link = "MiniStatuslineDevinfo" })

	local pills = vim.list_extend({ "StatuslineFile", "StatuslineDir" }, MODE_GROUPS)
	for _, name in ipairs(pills) do
		vim.api.nvim_set_hl(0, name .. "Cap", { fg = get(name).bg })
	end
end

update_highlights()
vim.api.nvim_create_autocmd("ColorScheme", { callback = update_highlights })

local function format_pill(hl, text)
	if text == "" then
		return ""
	end

	return ("%%#%sCap#%s%%#%s# %s %%#%sCap#%s"):format(hl, CAP_LEFT, hl, text, hl, CAP_RIGHT)
end

-- display properly escaped escaped filename
local function format_filename(fname) return vim.fn.fnamemodify(fname, ":t"):gsub("%%", "%%%%") end

-- just the filename, or [Scratch] for generic scratch buffers
-- using this for the inactive bar because i don't like vim's default
local function buffer_label()
	if vim.bo.buftype == "terminal" then
		return "Terminal"
	end

	local name = vim.api.nvim_buf_get_name(0)
	if name == "" then
		return "Scratch"
	end

	return format_filename(name)
end

-- TODO:
-- - change the way git changes are displayed
-- - maybe remove the LSP icon? or at least the ++, it's annoying
-- - display diagnostics with dots instead of "W7" again
statusline.setup({
	content = {
		active = function()
			local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
			local git = statusline.section_git({ trunc_width = 40 })
			local diagnostics = statusline.section_diagnostics({ trunc_width = 75 })
			local lsp = statusline.section_lsp({ trunc_width = 75 })
			local search = statusline.section_searchcount({ trunc_width = 75 })

			local file_icon = MiniIcons.get("file", vim.api.nvim_buf_get_name(0))
			local dir_icon = MiniIcons.get("directory", vim.fn.getcwd())
			local dir = format_filename(vim.fn.getcwd())

			local text = "%#StatuslineText#"
			return table.concat({
				format_pill(mode_hl, mode:upper()),
				text .. " %p%% %l:%c " .. search,
				"%<%=",
				text .. diagnostics,
				"%=",
				text .. git .. " " .. lsp .. " ",
				format_pill("StatuslineFile", file_icon .. " " .. buffer_label() .. "%m"),
				" ",
				format_pill("StatuslineDir", dir_icon .. " " .. dir),
			})
		end,
		inactive = function() return "%#StatuslineText# " .. buffer_label() end,
	},
})
