local keymap = vim.keymap
local cmd = vim.cmd
local gs = require 'gitsigns'
local gp = require 'goto-preview'

return {

  -- windows and buffers
  keymap.set('n', '<leader>sl', cmd.vsplit, { desc = 'Split window vertically' }),
  keymap.set('n', '<leader>sj', cmd.sp, { desc = 'Split window horizontally' }),
  keymap.set('n', '<leader>lw', '<C-w>l', { desc = 'Goto right window' }),
  keymap.set('n', '<leader>hw', '<C-w>h', { desc = 'Goto left window' }),
  keymap.set('n', '<leader>kw', '<C-w>k', { desc = 'Goto above window' }),
  keymap.set('n', '<leader>jw', '<C-w>j', { desc = 'Goto down window' }),
  keymap.set('n', '<leader>ew', '<C-w>=', { desc = 'Equalize windows size' }),

  --terminal
  keymap.set('n', '<leader>tt', ':split<bar>resize 15<bar>term<CR>', { noremap = true, desc = 'Open terminal window' }),
  keymap.set('t', '<leader>lw', '<C-\\><C-N><C-w>l', { desc = 'Goto right window from terminal' }),
  keymap.set('t', '<leader>hw', '<C-\\><C-N><C-w>h', { desc = 'Goto left window from terminal' }),
  keymap.set('t', '<leader>kw', '<C-\\><C-N><C-w>k', { desc = 'Goto above window from terminal' }),
  keymap.set('t', '<leader>jw', '<C-\\><C-N><C-w>j', { desc = 'Goto down window from terminal' }),

  -- horizontal movements
  keymap.set('n', 'le', '$', { desc = 'Goto end of line' }),
  keymap.set('v', 'le', '$', { desc = 'Goto end of line' }),
  keymap.set('n', 'ls', '^', { desc = 'Goto start of line' }),
  keymap.set('v', 'ls', '^', { desc = 'Goto start of line' }),

  -- vertical movements
  keymap.set('n', '<leader>pd', '<C-d>zz', { noremap = true, desc = 'Go half page down and keep cursor centered' }),
  keymap.set('v', '<leader>pd', '<C-d>zz', { noremap = true, desc = 'Go half page down and keep cursor centered' }),
  keymap.set('n', '<leader>pu', '<C-u>zz', { noremap = true, desc = 'Go half page up and keep cursor centered' }),
  keymap.set('v', '<leader>pu', '<C-u>zz', { noremap = true, desc = 'Go half page up and keep cursor centered' }),
  keymap.set('n', '<leader>m', '%', { noremap = true, desc = 'Goto matching brace/bracket' }),
  keymap.set('v', '<leader>m', '%', { noremap = true, desc = 'Goto matching brace/bracket' }),

  -- jumpback/forward on buffer/cursor history
  keymap.set('n', 'glb', '<C-o>', { desc = 'Move backward in the jumps list' }),
  keymap.set('n', 'glf', '<C-i>', { desc = 'Move forward in the jumps list' }),

  -- delete/replace
  keymap.set('x', '<leader>p', '"_dP', { desc = 'Send replaced to blackhole' }),
  keymap.set('n', '<leader>d', '"_d', { desc = 'Send deleted to blackhole' }),
  keymap.set('v', '<leader>d', '"_d', { desc = 'Send selected delete to blackhole' }),
  keymap.set('n', 'dle', 'd$', { desc = 'Delete to line end' }),
  keymap.set('n', 'dls', 'd^', { desc = 'Delete to line start' }),
  keymap.set('n', 'dm', 'd%', { desc = 'Delete to matching brace/bracket' }),

  -- copy
  keymap.set('n', '<leader>y', '"+y', { desc = 'Copy to clipboard' }),
  keymap.set('n', '<leader>Y', '"+Y', { desc = 'Copy to clipboard' }),
  keymap.set('v', '<leader>y', '"+y', { desc = 'Copy to clipboard' }),
  keymap.set('n', 'yle', 'y$', { desc = 'Copy to line end' }),
  keymap.set('n', 'yls', 'y^', { desc = 'Copy to line start' }),
  keymap.set('n', 'ym', 'y%', { desc = 'Copy to matching brace/bracket' }),

  -- change
  keymap.set('n', 'cle', 'c$', { desc = 'Change to line end' }),
  keymap.set('n', 'cls', 'c^', { desc = 'Change to line start' }),
  keymap.set('n', 'cm', 'c%', { desc = 'Change to matching brace/bracket' }),

  -- quickfix
  keymap.set('n', '<leader>qn', ':cnext<CR>', { desc = 'Goto next quickfix item' }),
  keymap.set('n', '<leader>qp', ':cprev<CR>', { desc = 'Goto previous quickfix item' }),

  -- misc
  keymap.set('n', 'J', 'mzJ`z', { desc = 'Keep cursor position when merging two lines' }),
  keymap.set('n', '<leader>fv', ':Oil<CR>', { desc = 'Open file explorer of the current directory' }),
  keymap.set('n', '<leader>fs', ':w<CR>', { desc = 'Save file' }),
  keymap.set('n', '<leader>J', 'd0kJ', { desc = 'Delete leading spaces and merge it with above line' }),
  keymap.set('n', '<C-j>', ':m .+1<CR>==', { noremap = true, silent = true, desc = 'Move current line up' }),
  keymap.set('v', '<C-j>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = 'Move selected lines up' }),
  keymap.set('n', '<C-f>', ':m .-2<CR>==', { noremap = true, silent = true, desc = 'Move current line up' }),
  keymap.set('v', '<C-f>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = 'Move selected lines up' }),
  keymap.set('v', '<leader>in', 'g<C-a>', { noremap = true, desc = 'Auto increment selected values' }),
  keymap.set('n', 'gx', ':!open <c-r><c-a><CR>', { desc = 'Open URL under cursor' }),

  -- undo tree
  keymap.set('n', '<leader>tu', cmd.UndotreeToggle, { desc = 'Toggle undotree' }),

  -- git
  -- keymap.set('n', '<leader>gs', cmd.Git, { desc = 'Git: status' }),
  -- keymap.set('n', '<leader>gH', ':0Gllog<CR>', { desc = 'Git: history of current file' }),
  -- keymap.set('n', '<leader>gd', ':Gvdiffsplit!<CR>', { desc = 'Git: three way diff split vertically' }),
  -- keymap.set('n', '<leader>gl', ':diffget //3<CR>', { desc = 'Git: accept changes from right(local)' }),
  -- keymap.set('n', '<leader>gh', ':diffget //2<CR>', { desc = 'Git: accept changes from left(remote)' }),
  -- keymap.set('n', '<leader>gD', ':diffoff<CR>', { desc = 'Git: turn off diff' }),
  keymap.set('n', '<leader>gl', ':diffget RE<CR>', { desc = 'Git: accept changes from right(local)' }),
  keymap.set('n', '<leader>gh', ':diffget LO<CR>', { desc = 'Git: accept changes from left(remote)' }),
  keymap.set({ 'n', 'v' }, '<leader>hn', ':Gitsigns next_hunk<CR>', { desc = 'Git: next diff hunk' }),
  keymap.set({ 'n', 'v' }, '<leader>hp', ':Gitsigns prev_hunk<CR>', { desc = 'Git: previous diff hunk' }),
  keymap.set({ 'n', 'v' }, '<leader>hP', ':Gitsigns preview_hunk<CR>', { desc = 'Git: preview diff hunk' }),
  keymap.set('v', '<leader>hs', function()
    gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
  end, { desc = 'Git: stage hunk' }),
  keymap.set('v', '<leader>hr', function()
    gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
  end, { desc = 'Git: reset hunk' }),
  keymap.set('n', '<leader>hs', gs.stage_hunk, { desc = 'Git: stage hunk' }),
  keymap.set('n', '<leader>hr', gs.reset_hunk, { desc = 'Git: reset hunk' }),
  keymap.set('n', '<leader>hS', gs.stage_buffer, { desc = 'Git: stage buffer' }),
  keymap.set('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'Git: undo stage hunk' }),
  keymap.set('n', '<leader>hR', gs.reset_buffer, { desc = 'Git: reset buffer' }),
  keymap.set('n', '<leader>hb', function()
    gs.blame_line { full = false }
  end, { desc = 'Git: blame line' }),
  keymap.set('n', '<leader>hd', gs.diffthis, { desc = 'Git: diff against index' }),
  keymap.set('n', '<leader>hD', function()
    gs.diffthis '~'
  end, { desc = 'Git: diff against last commit' }),
  keymap.set('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'Git: toggle blame line' }),
  keymap.set('n', '<leader>td', gs.toggle_deleted, { desc = 'Git: toggle show deleted' }),
  keymap.set({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Git: select hunk' }),

  -- telescope
  keymap.set('n', '<leader>sH', function()
    require('telescope.builtin').find_files {
      prompt_title = 'Hidden Files',
      hidden = true,
    }
  end, { desc = '[S]earch Hidden Files' }),
  keymap.set('n', '<leader>sc', ':Telescope commands<CR>', { desc = 'Search commands' }),
  keymap.set('n', '<leader>se', function()
    require('telescope.builtin').diagnostics {
      prompt_title = 'Errors',
      severity = vim.diagnostic.severity.ERROR,
    }
  end, { desc = '[S]earch Errors' }),
  keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' }),
  keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' }),
  keymap.set('n', '<leader>sm', function()
    require('telescope.builtin').treesitter {
      prompt_title = 'Methods',
      default_text = ':method:',
    }
  end, { desc = '[S]earch Document Methods' }),

  -- lsp
  keymap.set('n', 'gR', function()
    vim.lsp.buf.references()
  end, { desc = 'LSP: [L]ist References in quickfix' }),
  keymap.set('n', '<leader>gc', function()
    require('telescope.builtin').lsp_incoming_calls {
      prompt_title = 'LSP Calls',
    }
  end, { desc = 'LSP: [G]oto Calls' }),
  keymap.set('n', 'gC', function()
    vim.lsp.buf.incoming_calls()
  end, { desc = 'LSP: [L]ist Calls' }),
  keymap.set('n', '<leader>gd', function()
    gp.goto_preview_definition {}
  end, { desc = 'LSP: Preview definition in popup' }),
  keymap.set('n', '<leader>gD', function()
    gp.goto_preview_declaration {}
  end, { desc = 'LSP: Preview declaration in popup' }),
  keymap.set('n', '<leader>gr', function()
    gp.goto_preview_references {}
  end, { desc = 'LSP: Preview references in popup' }),
  keymap.set('n', '<leader>gR', ':NiceReference<CR>', { desc = 'LSP: List references in popup', silent = true }),
  keymap.set('n', '<leader>gt', function()
    gp.goto_preview_type_definition {}
  end, { desc = 'LSP: Preview type definition in popup' }),
  keymap.set('n', '<leader>gi', function()
    gp.goto_preview_implementation {}
  end, { desc = 'LSP: Preview implementation in popup' }),
  keymap.set('n', '<leader>gc', function()
    gp.close_all_win {}
  end, { desc = 'LSP: Close all preview popups' }),

  -- db
  keymap.set('n', '<leader>tdb', cmd.DBUIToggle, { desc = 'Toggle dbui' }),

  -- codeium
  keymap.set('i', '<C-g>', function()
    return vim.fn['codeium#Accept']()
  end, { expr = true, silent = true, nowait = true, desc = 'Accept Codeium Suggestion' }),

  -- Nvim-dap
  -- keymap.set("n", "<leader>bb", "<cmd>lua require'dap'.toggle_breakpoint()<cr>")
  -- keymap.set("n", "<leader>bc", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>")
  -- keymap.set("n", "<leader>bl", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>")
  -- keymap.set("n", '<leader>br', "<cmd>lua require'dap'.clear_breakpoints()<cr>")
  -- keymap.set("n", '<leader>ba', '<cmd>Telescope dap list_breakpoints<cr>')
  -- keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>")
  -- keymap.set("n", "<leader>dj", "<cmd>lua require'dap'.step_over()<cr>")
  -- keymap.set("n", "<leader>dk", "<cmd>lua require'dap'.step_into()<cr>")
  -- keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_out()<cr>")
  -- keymap.set("n", '<leader>dd', function() require('dap').disconnect(); require('dapui').close(); end)
  -- keymap.set("n", '<leader>dt', function() require('dap').terminate(); require('dapui').close(); end)
  -- keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>")
  -- keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>")
  -- keymap.set("n", '<leader>di', function() require "dap.ui.widgets".hover() end)
  -- keymap.set("n", '<leader>d?', function() local widgets = require "dap.ui.widgets"; widgets.centered_float(widgets.scopes) end)
  -- keymap.set("n", '<leader>df', '<cmd>Telescope dap frames<cr>')
  -- keymap.set("n", '<leader>dh', '<cmd>Telescope dap commands<cr>')
  -- keymap.set("n", '<leader>de', function() require('telescope.builtin').diagnostics({default_text=":E:"}) end)
}
