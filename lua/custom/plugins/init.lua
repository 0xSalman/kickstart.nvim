-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  'mbbill/undotree',
  'tpope/vim-repeat',
  -- 'tpope/vim-surround',
  -- 'unblevable/quick-scope',
  'hrsh7th/cmp-nvim-lsp-signature-help',
  -- {
  --   'Exafunction/codeium.vim',
  --   -- event = 'BufEnter',
  --   -- opts = {},
  -- },
  {
    'stevearc/oil.nvim',
    opts = {},
  },
  'rafamadriz/friendly-snippets',
  {
    'saecki/crates.nvim',
    tag = 'stable',
    config = function()
      require('crates').setup()
    end,
  },
  {
    'wiliamks/nice-reference.nvim',
    dependencies = {
      'rmagatti/goto-preview',
      config = function()
        require('goto-preview').setup()
      end,
    },
  },
}
