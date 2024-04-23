return {
  'akinsho/toggleterm.nvim',
  version = '*',
  keys = {
    { '<leader>td', '<cmd>ToggleTerm size=20 direction=horizontal<cr>', desc = 'Open a horizontal terminal at the Desktop directory' },
    { '<leader>tt', '<cmd>ToggleTerm size=20 direction=tab<cr>', desc = 'Open a tabbed terminal at the Desktop directory' },
  },
  config = function()
    require('toggleterm').setup()
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]])
    vim.keymap.set('t', 'jk', [[<C-\><C-n>]])
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]])
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]])
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]])
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]])
    vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]])
  end,
}
