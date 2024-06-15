local M = {}

--- @param str string
--- @param sep string
--- @return table
function M.split(str, sep)
	local t = {}
	local pattern = "([^" .. sep .. "]+)"

	for sub in string.gmatch(str, pattern) do
		table.insert(t, sub)
	end

	return t
end

return M
