return {
  'nvim-telescope/telescope-file-browser.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
  config = function()
    local telescope = require 'telescope'
    local builtin = require 'telescope.builtin'

    vim.keymap.set('n', '<space>fb', function()
      telescope.extensions.file_browser.file_browser { select_buffer = true }
    end)

    vim.keymap.set('n', '<space>ff', function()
      telescope.extensions.file_browser.file_browser { auto_depth = true, select_buffer = true }
    end)

    vim.keymap.set('n', '<space>fg', builtin.live_grep)
  end,
}
