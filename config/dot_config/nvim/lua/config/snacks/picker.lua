return {
	enabled = true,
	hidden = true,
	matcher = {
		fuzzy = true, -- use fuzzy matching
		smartcase = true, -- use smartcase
		ignorecase = true, -- use ignorecase
		sort_empty = false, -- sort results when the search string is empty
		filename_bonus = true, -- give bonus for matching file names (last part of the path)
		file_pos = true, -- support patterns like `file:line:col` and `file:line`
		-- the bonusses below, possibly require string concatenation and path normalization,
		-- so this can have a performance impact for large lists and increase memory usage
		cwd_bonus = true, -- give bonus for matching files in the cwd
		frecency = true, -- frecency bonus
		history_bonus = true, -- give more weight to chronological order
	},
	sort = {
		-- default sort is by score, text length and index
		fields = { "score:desc", "#text", "idx" },
	},

	ui_select = true,
}
