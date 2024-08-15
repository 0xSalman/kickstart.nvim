return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          'bash',
          'c',
          'css',
          'dockerfile',
          'fish',
          'git_config',
          'git_rebase',
          'gitcommit',
          'gitignore',
          'go',
          'gomod',
          'gotmpl',
          'graphql',
          'html',
          'javascript',
          'json',
          'lua',
          'markdown',
          'markdown_inline',
          'proto',
          'python',
          'rust',
          'solidity',
          'sql',
          'tmux',
          'toml',
          'tsx',
          'typescript',
          'yaml',
          'zig',
        },

        -- Autoinstall languages that are not installed
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },

        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = 'si',
            node_incremental = 'sn',
            scope_incremental = 'snc',
            node_decremental = '<bs>',
          },
        },

        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ['a='] = { query = '@assignment.outer', desc = 'Select outer part of an assignment' },
              ['i='] = { query = '@assignment.inner', desc = 'Select inner part of an assignment' },
              ['l='] = { query = '@assignment.lhs', desc = 'Select left hand side of an assignment' },
              ['r='] = { query = '@assignment.rhs', desc = 'Select right hand side of an assignment' },

              ['aa'] = { query = '@parameter.outer', desc = 'Select outer part of a parameter/argument' },
              ['ia'] = { query = '@parameter.inner', desc = 'Select inner part of a parameter/argument' },

              ['ai'] = { query = '@conditional.outer', desc = 'Select outer part of a conditional' },
              ['ii'] = { query = '@conditional.inner', desc = 'Select inner part of a conditional' },

              ['al'] = { query = '@loop.outer', desc = 'Select outer part of a loop' },
              ['il'] = { query = '@loop.inner', desc = 'Select inner part of a loop' },

              ['af'] = { query = '@call.outer', desc = 'Select outer part of a function call' },
              ['if'] = { query = '@call.inner', desc = 'Select inner part of a function call' },

              ['am'] = { query = '@function.outer', desc = 'Select outer part of a method/function definition' },
              ['im'] = { query = '@function.inner', desc = 'Select inner part of a method/function definition' },

              ['ac'] = { query = '@class.outer', desc = 'Select outer part of a class' },
              ['ic'] = { query = '@class.inner', desc = 'Select inner part of a class' },
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              -- [']m'] = '@function.outer',
              ['<leader>fn'] = '@function.outer',
              [']]'] = '@class.outer',
            },
            goto_next_end = {
              -- [']M'] = '@function.outer',
              ['<leader>fN'] = '@function.outer',
              [']['] = '@class.outer',
            },
            goto_previous_start = {
              -- ['[m'] = '@function.outer',
              ['<leader>fp'] = '@function.outer',
              ['[['] = '@class.outer',
            },
            goto_previous_end = {
              -- ['[M'] = '@function.outer',
              ['<leader>fP'] = '@function.outer',
              ['[]'] = '@class.outer',
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
              ['<leader>A'] = '@parameter.inner',
            },
          },
        },
      }

      local ts_repeat_move = require 'nvim-treesitter.textobjects.repeatable_move'

      -- vim way: ; goes to the direction you were moving.
      vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move)
      vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_opposite)

      -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
      vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f_expr, { expr = true })
      vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F_expr, { expr = true })
      vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t_expr, { expr = true })
      vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T_expr, { expr = true })
    end,
  },
}
