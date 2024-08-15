return {
  {
    'epwalsh/obsidian.nvim',
    version = '*', -- recommended, use latest release instead of latest commit
    lazy = true,
    event = {
      'BufReadPre ' .. vim.fn.expand '~' .. '/second-brain/**/*.md',
      'BufNewFile ' .. vim.fn.expand '~' .. '/second-brain/**/*.md',
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {
      workspaces = {
        {
          name = 'main',
          path = '~/second-brain',
        },
      },
    },
    config = function(_, opts)
      require('obsidian').setup(opts)

      -- Set conceallevel for Markdown files in the Obsidian vault
      vim.api.nvim_create_autocmd('BufEnter', {
        pattern = vim.fn.expand '~' .. '/second-brain/**/*.md',
        callback = function()
          vim.opt_local.conceallevel = 2
        end,
        group = vim.api.nvim_create_augroup('ObsidianMarkdownConceal', { clear = true }),
      })
    end,
  },
}
