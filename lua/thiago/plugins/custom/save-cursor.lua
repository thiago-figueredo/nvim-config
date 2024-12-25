local M = {}

local state = {
  allowed_dirs = { "~/.config/nvim", "~/Documents/github" },
  filetypes = { "c", "lua", "python", "typescript", "php", "go", "rust" },
  save_dir = vim.fn.stdpath("data") .. "/cursor-sessions",
}

M.setup = function(opts)
  state = vim.tbl_deep_extend("force", state, opts or {})
  M.create_autocmds()
end

M.save_cursor = function(path)
  local cursor = vim.api.nvim_win_get_cursor(0)
  local filetype = vim.fn.fnamemodify(path, ":e")
  local dirpath = state.save_dir .. "/" .. filetype
  local filepath = dirpath .. "/" .. vim.fn.fnamemodify(path, ":t:r")
  local file = vim.loop.fs_open(filepath, "w", 438)

  if not file then
    vim.fn.mkdir(dirpath, "p")

    file = vim.loop.fs_open(filepath, "w", 438)

    if not file then
      print("Failed to open file for writing: " .. filepath)
      return
    end
  end

  vim.loop.fs_write(file, cursor[1] .. ',' .. cursor[2], -1)
  vim.loop.fs_close(file)
end

M.restore_cursor = function(path)
  local filetype = vim.fn.fnamemodify(path, ":e")
  local dirpath = state.save_dir .. "/" .. filetype
  local filepath = dirpath .. "/" .. vim.fn.fnamemodify(path, ":t:r")

  local file = vim.loop.fs_open(filepath, "r", 438)  -- Check if the file exists in read mode

  if not file then
    return
  end

  vim.loop.fs_close(file)

  local helpers = require('thiago.core.helpers')
  local lines = vim.fn.readfile(filepath)

  if lines == nil or #lines == 0 then
    return
  end

  local cursor = helpers.split(lines[1], ',')

  vim.api.nvim_win_set_cursor(0, { tonumber(cursor[1]), tonumber(cursor[2]) })
end

M.is_filepath_allowed = function(path)
  for _, allowed_filetype in ipairs(state.filetypes) do
    if allowed_filetype == vim.filetype.match({ filename = path })then
      return true
    end
  end

  return false
end

M.is_valid_path = function(path)
  for _, allowed_dir in ipairs(state.allowed_dirs) do
    local is_allowed_path = vim.startswith(path, vim.fn.fnamemodify(allowed_dir, ":p"))
    local is_allowed_filetype = M.is_filepath_allowed(path)

    if is_allowed_filetype and is_allowed_path then
      return true
    end
  end

  return false
end

M.create_autocmds = function()
  vim.api.nvim_create_autocmd({ "BufEnter" }, {
    callback = function(event)
      if not M.is_valid_path(event.match) then return end
      M.restore_cursor(event.match)
    end
  })

  vim.api.nvim_create_autocmd({ "BufLeave" }, {
    callback = function(event)
      if not M.is_valid_path(event.match) then return end
      M.save_cursor(event.match)
    end
  })
end

return M
