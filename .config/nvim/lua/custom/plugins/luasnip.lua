return {
  'L3MON4D3/LuaSnip',
  config = function()
    -- luasnip.lua, from https://github.com/vimjoyer/nvim-luasnip-video

    local ls = require 'luasnip'
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    local extras = require 'luasnip.extras'
    local rep = extras.rep
    local fmt = require('luasnip.extras.fmt').fmt
    local c = ls.choice_node
    local f = ls.function_node
    local d = ls.dynamic_node

    vim.keymap.set({ 'i', 's' }, '<A-n>', function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end)

    vim.keymap.set({ 'i', 's' }, '<C-n>', function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      end
    end, { silent = true })

    vim.keymap.set({ 'i', 's' }, '<C-p>', function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end, { silent = true })

    ls.add_snippets('tex', {
      s('begin', {
        t '\\begin{',
        i(1),
        t '}',
        t { '', '\t' },
        i(0),
        t { '', '\\end{' },
        rep(1),
        t '}',
      }),
    })
  end,
}
