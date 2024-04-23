return {
  'famiu/bufdelete.nvim',
  config = function()
    vim.keymap.set('n', '<leader>q', require('bufdelete').bufdelete, {})
  end,
}
