local M = {}

local cwd = vim.fn.getcwd()
local is_windows = vim.loop.os_uname().version:match("Windows")
local separator = is_windows and "\\" or "/"

M.join = function(...)
	local path = table.concat(vim.tbl_flatten({ ... }), separator)
	return path:gsub(separator .. "+", separator)
end

M.cwd_has_glob = function(patterns)
	for _, pattern in ipairs(patterns) do
		if #vim.fn.glob(M.join(cwd, pattern), false, true) > 0 then
			return true
		end
	end
	return false
end

return M
