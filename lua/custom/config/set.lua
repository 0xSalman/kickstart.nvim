local opt = vim.opt

-- line number
opt.relativenumber = true

-- indentation
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smarttab = true
opt.autoindent = true

-- folding
opt.foldlevel = 20
opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr()'

-- window
opt.scrolloff = 999

-- disable mouse
-- opt.mouse = ''

-- misc
opt.swapfile = false
opt.undodir = vim.fn.stdpath 'cache' .. '/undo'
opt.iskeyword:append '-'

local g = vim.g

g.codeium_no_map_tab = true

return {

  -- Autocommand for TermOpen
  -- interferes with nvim-dap: https://www.reddit.com/r/neovim/comments/wlbxh0/nvimdap_continue_drops_buffer_into_insert_mode/
  -- vim.cmd([[autocmd TermOpen * startinsert]]),
}
