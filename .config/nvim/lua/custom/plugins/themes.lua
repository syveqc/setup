return { -- You can easily change to a different colorscheme.
  -- Change the name of the colorscheme plugin below, and then
  -- change the command in the config to whatever the name of that colorscheme is.
  --
  -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  'rose-pine/neovim',
  name = 'rose-pine',
  dependencies = { 'folke/tokyonight.nvim' }, -- dependencies here more as loading old themes as well
  priority = 1000, -- Make sure to load this before all the other start plugins.
  init = function()
    -- Load the colorscheme here.
    vim.cmd.colorscheme 'rose-pine-moon'

    -- You can configure highlights by doing something like:
    vim.cmd.hi 'Comment gui=none'
  end,
}
