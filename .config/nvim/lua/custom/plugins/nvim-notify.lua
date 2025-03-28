return {
  'rcarriga/nvim-notify',
  event = 'VeryLazy',
  config = function()
    require('notify').setup {
      background_colour = 'NotifyBackground',
      fps = 120,
      icons = {
        DEBUG = '',
        ERROR = '',
        INFO = '',
        TRACE = '✎',
        WARN = '',
      },
      level = 3,
      minimum_width = 50,
      render = 'compact',
      stages = 'fade',
      time_formats = {
        notification = '%T',
        notification_history = '%FT%T',
      },
      timeout = 1000,
      top_down = true,
      merge_duplicates = true,
    }
  end,
}
