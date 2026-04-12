-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '<leader>op', ':Neotree reveal<CR>', desc = '[O]pen [P]roject tree', silent = true },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['<leader>op'] = 'close_window',
        },
      },
    },
  },
}
