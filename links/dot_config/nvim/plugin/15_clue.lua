vim.pack.add({
	"https://tangled.org/nvim-mini.org/mini.nvim",
})

local clue = require("mini.clue")

-- textobjects aren't mappings, so clue can't discover them
local textobjects = {
	w = "word",
	W = "WORD",
	s = "sentence",
	p = "paragraph",
	t = "tag",
	b = "any bracket",
	q = "any quote",
	a = "argument",
	f = "function call",
	["?"] = "ask for edges",
}

local textobject_clues = {}
for _, mode in ipairs({ "o", "x" }) do
	for key, desc in pairs(textobjects) do
		table.insert(textobject_clues, { mode = mode, keys = "i" .. key, desc = "inside " .. desc })
		table.insert(textobject_clues, { mode = mode, keys = "a" .. key, desc = "around " .. desc })
	end
end

clue.setup({
	triggers = {
		{ mode = "n", keys = "<Leader>" },
		{ mode = "x", keys = "<Leader>" },
		{ mode = "n", keys = "g" },
		{ mode = "x", keys = "g" },
		{ mode = "n", keys = "[" },
		{ mode = "n", keys = "]" },
		{ mode = "n", keys = "z" },
		{ mode = "x", keys = "z" },
		{ mode = "n", keys = "<C-w>" },
		{ mode = "n", keys = "'" },
		{ mode = "n", keys = '"' },
		{ mode = "x", keys = '"' },
		{ mode = "i", keys = "<C-r>" },
		{ mode = "o", keys = "i" },
		{ mode = "o", keys = "a" },
		{ mode = "x", keys = "i" },
		{ mode = "x", keys = "a" },
	},
	clues = {
		{ mode = "n", keys = "<Leader>c", desc = "+current buffer" },
		{ mode = "n", keys = "<Leader>f", desc = "+find" },
		{ mode = "n", keys = "<Leader>g", desc = "+git" },
		{ mode = "n", keys = "<Leader>s", desc = "+search" },
		{ mode = "n", keys = "<Leader>u", desc = "+toggles" },
		clue.gen_clues.g(),
		clue.gen_clues.square_brackets(),
		clue.gen_clues.z(),
		clue.gen_clues.windows(),
		clue.gen_clues.marks(),
		clue.gen_clues.registers(),
		textobject_clues,
	},
	window = { delay = 300 },
})
