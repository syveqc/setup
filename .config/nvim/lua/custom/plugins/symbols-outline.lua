return {
  'hedyhli/outline.nvim',
  lazy = true,
  cmd = { 'Outline', 'OutlineOpen' },
  keys = { -- Example mapping to toggle outline
    { '<leader>o', '<cmd>Outline<CR>', desc = 'Toggle outline' },
  },
  keymaps = {
    up_and_jump = '<C-p>',
    down_and_jump = '<C-n>',
  },
  opts = {
    -- Your setup opts here
  },
}
