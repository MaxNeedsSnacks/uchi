local M = {}

local jdtls = require("jdtls")
local handlers = require("config.lsp.handlers")

local root_markers = { "gradlew", "mvnw", ".git", "pom.xml", "build.gradle", "build.gradle.kts" }

function M.start_or_attach(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()

	local root_dir = vim.fs.root(bufnr, root_markers)
	if not root_dir then
		return
	end

	local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
	local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name
	local cmd = { "jdtls", "-data", workspace_dir }

	local ok, lazy_lsp = pcall(require, "lazy-lsp")
	if ok then
		cmd = lazy_lsp.in_shell({ "jdt-language-server" }, cmd)
	end

	jdtls.start_or_attach({
		cmd = cmd,
		root_dir = root_dir,
		on_attach = handlers.on_attach,
		capabilities = handlers.capabilities,
		settings = {},
	})
end

function M.setup()
	local augroup = vim.api.nvim_create_augroup("JdtlsAttach", { clear = true })

	vim.api.nvim_create_autocmd("FileType", {
		group = augroup,
		pattern = "java",
		callback = function(args)
			M.start_or_attach(args.buf)
		end,
	})

	if vim.bo.filetype == "java" then
		M.start_or_attach(0)
	end
end

return M
