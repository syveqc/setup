return {
  'akinsho/toggleterm.nvim',
  version = '*',
  keys = {
    { '<leader>td', '<cmd>ToggleTerm size=20 direction=horizontal<cr>', desc = 'Open a horizontal terminal at the Desktop directory' },
    { '<leader>tt', '<cmd>ToggleTerm size=20 direction=tab<cr>', desc = 'Open a tabbed terminal at the Desktop directory' },
  },
  config = function()
    require('toggleterm').setup()
  end,
}
