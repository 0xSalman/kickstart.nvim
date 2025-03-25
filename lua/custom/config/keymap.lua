local next_integrations = require 'nvim-next.integrations'

return {

  -- windows and buffers
  vim.keymap.set('n', '<leader>sl', vim.cmd.vsplit, { desc = 'Split window vertically' }),
  vim.keymap.set('n', '<leader>sj', vim.cmd.sp, { desc = 'Split window horizontally' }),
  vim.keymap.set('n', '<leader>lw', '<C-w>l', { desc = 'Goto right window' }),
  vim.keymap.set('n', '<leader>hw', '<C-w>h', { desc = 'Goto left window' }),
  vim.keymap.set('n', '<leader>kw', '<C-w>k', { desc = 'Goto above window' }),
  vim.keymap.set('n', '<leader>jw', '<C-w>j', { desc = 'Goto down window' }),
  vim.keymap.set('n', '<leader>ew', '<C-w>=', { desc = 'Equalize windows size' }),

  -- horizontal movements
  vim.keymap.set('n', 'le', '$', { desc = 'Goto end of line' }),
  vim.keymap.set('v', 'le', '$', { desc = 'Goto end of line' }),
  vim.keymap.set('n', 'ls', '^', { desc = 'Goto start of line' }),
  vim.keymap.set('v', 'ls', '^', { desc = 'Goto start of line' }),

  -- vertical movements
  vim.keymap.set('n', '<leader>m', '%', { noremap = true, desc = 'Goto matching brace/bracket' }),
  vim.keymap.set('v', '<leader>m', '%', { noremap = true, desc = 'Goto matching brace/bracket' }),

  -- jumpback/forward on buffer/cursor history
  vim.keymap.set('n', 'glb', '<C-o>', { desc = 'Move backward in the jumps list' }),
  vim.keymap.set('n', 'glf', '<C-i>', { desc = 'Move forward in the jumps list' }),

  -- delete/replace
  vim.keymap.set('x', '<leader>p', '"_dP', { desc = 'Send replaced to blackhole' }),
  vim.keymap.set('n', '<leader>d', '"_d', { desc = 'Send deleted to blackhole' }),
  vim.keymap.set('v', '<leader>d', '"_d', { desc = 'Send selected delete to blackhole' }),
  vim.keymap.set('n', 'dle', 'd$', { desc = 'Delete to line end' }),
  vim.keymap.set('n', 'dls', 'd^', { desc = 'Delete to line start' }),
  vim.keymap.set('n', 'dm', 'd%', { desc = 'Delete to matching brace/bracket' }),

  -- copy
  vim.keymap.set('n', '<leader>y', '"+y', { desc = 'Copy to clipboard' }),
  vim.keymap.set('n', '<leader>Y', '"+Y', { desc = 'Copy to clipboard' }),
  vim.keymap.set('v', '<leader>y', '"+y', { desc = 'Copy to clipboard' }),

  -- misc
  vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Keep cursor position when merging two lines' }),
  vim.keymap.set('n', '<leader>fv', ':Oil<CR>', { desc = 'Open file explorer of the current directory' }),
  vim.keymap.set('n', '<leader>fs', ':w<CR>', { desc = 'Save file' }),
  vim.keymap.set('n', '<leader>fq', ':q<CR>', { desc = 'Quit file' }),
  vim.keymap.set('n', '<leader>J', 'd0kJ', { desc = 'Delete leading spaces and merge it with above line' }),
  vim.keymap.set('n', '<C-j>', ':m .+1<CR>==', { noremap = true, silent = true, desc = 'Move current line up' }),
  vim.keymap.set('v', '<C-j>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = 'Move selected lines up' }),
  vim.keymap.set('n', '<C-f>', ':m .-2<CR>==', { noremap = true, silent = true, desc = 'Move current line up' }),
  vim.keymap.set('v', '<C-f>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = 'Move selected lines up' }),
  vim.keymap.set('v', '<leader>in', 'g<C-a>', { noremap = true, desc = 'Auto increment selected values' }),

  -- undo tree
  vim.keymap.set('n', '<leader>tu', vim.cmd.UndotreeToggle, { desc = 'Toggle undotree' }),

  -- git
  vim.keymap.set('n', '<leader>gh', ':diffget LO<CR>', { desc = 'Git: accept changes from left(head)' }),
  vim.keymap.set('n', '<leader>gl', ':diffget RE<CR>', { desc = 'Git: accept changes from right(modified)' }),

  -- quickfix
  vim.keymap.set('n', '<leader>ln', next_integrations.quickfix().cnext, { desc = 'Goto next quickfix item' }),
  vim.keymap.set('n', '<leader>lp', next_integrations.quickfix().cprevious, { desc = 'Goto previous quickfix item' }),

  -- diagnostics
  vim.keymap.set(
    'n',
    '<leader>dn',
    next_integrations.diagnostic().goto_next {
      severity = { min = vim.diagnostic.severity.WARN },
    },
    { desc = 'Goto next [D]iagnostic' }
  ),
  vim.keymap.set(
    'n',
    '<leader>dp',
    next_integrations.diagnostic().goto_prev {
      severity = { min = vim.diagnostic.severity.WARN },
    },
    { desc = 'Goto previous [D]iagnostic' }
  ),
  vim.keymap.set(
    'n',
    '<leader>en',
    next_integrations.diagnostic().goto_next {
      severity = { min = vim.diagnostic.severity.ERROR },
    },
    { desc = 'Goto next [E]rror' }
  ),
  vim.keymap.set(
    'n',
    '<leader>ep',
    next_integrations.diagnostic().goto_prev {
      severity = { min = vim.diagnostic.severity.ERROR },
    },
    { desc = 'Goto previous [E]rror' }
  ),

  -- db
  vim.keymap.set('n', '<leader>tdb', vim.cmd.DBUIToggle, { desc = 'Toggle dbui' }),
}
