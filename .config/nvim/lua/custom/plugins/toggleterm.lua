return {
  'akinsho/toggleterm.nvim',
  version = '*',
  keys = {
    { '<leader>th', '<cmd>ToggleTerm size=20 direction=horizontal<cr>', desc = 'Open a horizontal terminal at the current directory' },
    { '<leader>td', '<cmd>ToggleTerm size=150 direction=vertical<cr>', desc = 'Open a vertical terminal at the current directory' },
    { '<leader>tt', '<cmd>ToggleTerm direction=tab<cr>', desc = 'Open a tabbed terminal at the current directory' },
  },
  config = function()
    require('toggleterm').setup()
    vim.keymap.set('t', '<leader>td', '<cmd>ToggleTerm size=150 direction=vertical<cr>', { desc = 'Open a vertical terminal at the current directory' })
    vim.keymap.set('t', '<leader>th', '<cmd>ToggleTerm size=20 direction=horizontal<cr>', { desc = 'Open a horizontal terminal at the current directory' })
    vim.keymap.set('t', '<leader>tt', '<cmd>ToggleTerm direction=tab<cr>', { desc = 'Open a tabbed terminal at the current directory' })
  end,
}
