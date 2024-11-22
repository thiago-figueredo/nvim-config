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

--- @param method string
--- @param params table
--- @param handler function
function M.request(method, params, handler)
  vim.validate({
    method = { method, 's' },
    handler = { handler, 'f', true },
  })

  return vim.lsp.buf_request(0, method, params, handler)
end

--- @return number|nil
function M.get_floating_window()
  local windows = vim.api.nvim_list_wins()

  for _, win_id in ipairs(windows) do
    local config = vim.api.nvim_win_get_config(win_id)
    local is_floating = config.relative and (config.relative == "editor" or config.relative == "win")

    if is_floating then
      return win_id
    end
  end

  return nil
end

-- @param steps number
-- @return Node
function M.node_at_from_cursor(steps)
  local ts_utils = require("nvim-treesitter.ts_utils")

  local node = ts_utils.get_node_at_cursor()

  if steps == 0 or not node then
    return node
  end

  while steps ~= 0 and node do
    if steps > 0 then
      node = node:next_sibling()
      steps = steps - 1
    elseif steps < 0 then
      node = node:prev_sibling()
      steps = steps + 1
    end
  end

  return node
end

--- @param text string|nil
function M.hover(text)
  local util = require('vim.lsp.util')
  local ms = require('vim.lsp.protocol').Methods
  local params = util.make_position_params()

  M.request(ms.textDocument_hover, params, function(err, result, ctx, config)
    local winid = M.get_floating_window()

    if winid ~= nil then
      return vim.api.nvim_set_current_win(winid)
    end

    local filetype = vim.bo.filetype

    if filetype ~= "go" then
      return vim.lsp.util.open_floating_preview({ result.contents.value }, "markdown")
    end

    local cword = text or vim.fn.expand("<cword>")
    local godoc = vim.fn.system("go doc " .. cword)

    if string.find(godoc, "doc: no symbol Sprintf in package .") ~= nil then
      return vim.lsp.util.open_floating_preview({ result.contents.value }, "markdown")
    end

    if not result then
      return
    end

    if result.contents.value:sub(-1) == '\n' then
      result.contents.value = result.contents.value .. godoc
    else
      result.contents.value = result.contents.value .. "\n" .. godoc
    end

    vim.lsp.util.open_floating_preview({ result.contents.value }, "markdown")
  end)
end

return M
