return {
  {
    'epwalsh/obsidian.nvim',
    version = '*', -- recommended, use latest release instead of latest commit
    lazy = true,
    -- ft = 'markdown',
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    event = {
      -- refer to `:h file-pattern` for more examples
      'BufReadPre '
        .. vim.fn.expand '~'
        .. '/second-brain/**/*.md',
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
  },
}
