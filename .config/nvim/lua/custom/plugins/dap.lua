return {
  -- if just exited with error code 1, ensure that debugpy is installed in the conda env!
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
    'nvim-neotest/nvim-nio',
    'williamboman/mason.nvim',
  },
  config = function()
    local dap = require 'dap'
    local ui = require 'dapui'

    require('dapui').setup()

    dap.adapters.python = {
      type = 'executable',
      command = 'python',
      args = { '-m', 'debugpy.adapter' },
    }

    dap.configurations = {
      python = {
        {
          type = 'python',
          request = 'launch',
          name = 'Launch file',
          program = '${file}',
          pythonPath = 'python',
        },
      },
    }

    vim.keymap.set('n', '<space>b', dap.toggle_breakpoint)
    vim.keymap.set('n', '<space>gb', dap.run_to_cursor)
    vim.keymap.set('n', '<space>gt', dap.goto_)

    -- Eval var under cursor
    vim.keymap.set('n', '<space>?', function()
      require('dapui').eval(nil, { enter = true })
    end)

    vim.keymap.set('n', '<F5>', dap.continue)
    vim.keymap.set('n', '<F6>', dap.step_into)
    vim.keymap.set('n', '<F7>', dap.step_over)
    vim.keymap.set('n', '<F8>', dap.step_out)
    vim.keymap.set('n', '<F9>', dap.step_back)
    vim.keymap.set('n', '<F12>', dap.restart)

    dap.listeners.before.attach.dapui_config = function()
      ui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      ui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      ui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      ui.close()
    end
  end,
}
