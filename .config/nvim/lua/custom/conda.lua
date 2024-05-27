local function get_last(str, separator)
  local last = 'default'
  for s in string.gmatch(str, '([^' .. separator .. ']+)') do
    last = s
  end
  return last
end

local function set_python_path(path)
  local cmd = string.format(':PyrightSetPythonPath %s', path .. '/bin/python')
  vim.cmd(cmd)
  vim.env.PATH = vim.env.PATH:gsub(vim.env.CONDA_PREFIX .. '/%w+/%w+/bin', path .. '/bin')
  vim.env.PATH = vim.env.PATH:gsub(vim.env.CONDA_PREFIX .. '/bin', path .. '/bin')
  local env_name = get_last(path, '/')
  vim.env.CONDA_PROMPT_MODIFIER = '(' .. env_name .. ')'
  print(string.format('activated %s', env_name))
end

local function make_entry_from_conda_string(current_env)
  return function(conda_str)
    if string.find(conda_str, '#', 1, true) == 1 or string.len(conda_str) == 0 then
      return nil
    end
    local display_str = conda_str:gsub('*', ' '):gsub(current_env .. '  ', '* ' .. current_env)
    return {
      value = conda_str,
      ordinal = conda_str,
      display = display_str,
    }
  end
end

local action_state = require 'telescope.actions.state'
local function print_path(prompt_bufnr)
  if prompt_bufnr then
    local actions = require 'telescope.actions'
    actions.close(prompt_bufnr)
  end
  local selected_value = action_state.get_selected_entry().value
  local conda_path = get_last(selected_value, ' ')
  set_python_path(conda_path)
end

vim.keymap.set('n', '<leader>cc', function()
  -- set_python_path '/home/tobias/miniforge3/envs/deepracer/bin/python'
  local env_name = vim.env.CONDA_PROMPT_MODIFIER
  env_name = env_name:gsub('%(', '')
  env_name = env_name:gsub('%)', '')
  local telescope_actions = require 'telescope.actions'
  local opts = {
    prompt_title = 'Conda Environments',
    entry_maker = make_entry_from_conda_string(env_name),
    layout_config = { prompt_position = 'top', width = 0.35, height = 0.3 },
    attach_mappings = function(_, _)
      telescope_actions.select_default:replace(print_path)
      return true
    end,
  }
  local finders = require 'telescope.finders'
  local conf = require('telescope.config').values
  local find_command = { 'conda', 'info', '--envs' }
  require('telescope.pickers')
    .new(opts, {
      finder = finders.new_oneshot_job(find_command, opts),
      sorter = conf.file_sorter(opts),
    })
    :find()
end, { desc = '[C]hange [C]onda Environment' })
