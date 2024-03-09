local tally = require('custom.debug.tally')

local M = {
  go = {},
}

vim.list_extend(M.go, tally)

return M
