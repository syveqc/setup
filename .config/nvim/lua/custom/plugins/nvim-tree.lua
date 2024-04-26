return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('nvim-tree').setup {
      respect_buf_cwd = true,
      view = {
        width = 60,
      },
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
    }
    vim.keymap.set('n', '<leader>nt', '<cmd>NvimTreeToggle<CR>', { desc = '[T]oggle Tree' })
    vim.keymap.set('n', '<leader>nf', '<cmd>NvimTreeFindFile<CR>', { desc = '[F]ind File' })
  end,
}
