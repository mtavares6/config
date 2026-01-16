-- Debugging Support
return {
  -- https://github.com/rcarriga/nvim-dap-ui
  'rcarriga/nvim-dap-ui',
  event = 'VeryLazy',
  dependencies = {
    -- https://github.com/mfussenegger/nvim-dap
    'mfussenegger/nvim-dap',
    -- https://github.com/nvim-neotest/nvim-nio
    'nvim-neotest/nvim-nio',
    -- https://github.com/theHamsta/nvim-dap-virtual-text
    'theHamsta/nvim-dap-virtual-text', -- inline variable text while debugging
    -- https://github.com/nvim-telescope/telescope-dap.nvim
    'nvim-telescope/telescope-dap.nvim', -- telescope integration with dap
  },
  opts = {
    controls = {
      element = 'repl',
      enabled = false,
      icons = {
        disconnect = '',
        pause = '',
        play = '',
        run_last = '',
        step_back = '',
        step_into = '',
        step_out = '',
        step_over = '',
        terminate = '',
      },
    },
    element_mappings = {},
    expand_lines = true,
    floating = {
      border = 'single',
      mappings = {
        close = { 'q', '<Esc>' },
      },
    },
    force_buffers = true,
    icons = {
      collapsed = '',
      current_frame = '',
      expanded = '',
    },
    layouts = {
      {
        elements = {
          {
            id = 'scopes',
            size = 0.50,
          },
          {
            id = 'stacks',
            size = 0.30,
          },
          {
            id = 'watches',
            size = 0.10,
          },
          {
            id = 'breakpoints',
            size = 0.10,
          },
        },
        size = 40,
        position = 'left', -- Can be "left" or "right"
      },
      {
        elements = {
          'repl',
          'console',
        },
        size = 10,
        position = 'bottom', -- Can be "bottom" or "top"
      },
    },
    mappings = {
      edit = 'e',
      expand = { '<CR>', '<2-LeftMouse>' },
      open = 'o',
      remove = 'd',
      repl = 'r',
      toggle = 't',
    },
    render = {
      indent = 1,
      max_value_lines = 100,
    },
  },
  config = function(_, opts)
    local dap = require 'dap'
    require('dapui').setup(opts)

    -- Customize breakpoint signs
    vim.api.nvim_set_hl(0, 'DapStoppedHl', { fg = '#98BB6C', bg = '#2A2A2A', bold = true })
    vim.api.nvim_set_hl(0, 'DapStoppedLineHl', { bg = '#204028', bold = true })
    vim.fn.sign_define('DapStopped', { text = '', texthl = 'DapStoppedHl', linehl = 'DapStoppedLineHl', numhl = '' })
    vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DiagnosticSignError', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'DiagnosticSignWarn', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'DiagnosticSignError', linehl = '', numhl = '' })
    vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'DiagnosticSignInfo', linehl = '', numhl = '' })

    dap.listeners.after.event_initialized['dapui_config'] = function()
      require('dapui').open()
    end

    dap.listeners.before.event_terminated['dapui_config'] = function()
      -- Commented to prevent DAP UI from closing when unit tests finish
      -- require('dapui').close()
    end

    dap.listeners.before.event_exited['dapui_config'] = function()
      -- Commented to prevent DAP UI from closing when unit tests finish
      -- require('dapui').close()
    end

    require('nvim-dap-virtual-text').setup {
      -- This just tries to mitigate the chance that I leak tokens here. Probably won't stop it from happening...
      display_callback = function(variable)
        local name = string.lower(variable.name)
        local value = string.lower(variable.value)
        if name:match 'secret' or name:match 'api' or value:match 'secret' or value:match 'api' then
          return '*****'
        end

        if #variable.value > 15 then
          return ' ' .. string.sub(variable.value, 1, 15) .. '... '
        end

        return ' ' .. variable.value
      end,
    }
    -- Add dap configurations based on your language/adapter settings
    -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
    dap.configurations.java = {
      {
        name = 'Debug Launch (2GB)',
        type = 'java',
        request = 'launch',
        vmArgs = '' .. '-Xmx2g ',
      },
      {
        name = 'Debug Attach (8000)',
        type = 'java',
        request = 'attach',
        hostName = '127.0.0.1',
        port = 8000,
      },
      {
        name = 'Debug Attach (5005)',
        type = 'java',
        request = 'attach',
        hostName = '127.0.0.1',
        port = 5005,
      },
      { name = 'Debug Attach (5004)', type = 'java', request = 'attach', hostName = '127.0.0.1', port = 5004 },
      { name = 'Debug Attach (5003)', type = 'java', request = 'attach', hostName = '127.0.0.1', port = 5003 },
      {
        name = 'c3-backend',
        type = 'java',
        request = 'launch',
        javaExec = '/opt/homebrew/Cellar/openjdk@11/11.0.26/bin/java',
        -- You need to extend the classPath to list your dependencies.
        -- `nvim-jdtls` would automatically add the `classPaths` property if it is missing

        -- If using multi-module projects, remove otherwise.
        -- projectName = "yourProjectName",

        -- javaExec = "java",
        mainClass = 'com.carrotincentives.c3.c3p.App',
        -- modulePaths = {
        --   -- 'c3-portal-backend',
        --   'backend',
        -- },
        -- -- If using the JDK9+ module system, this needs to be extended
        -- `nvim-jdtls` would automatically populate this property
        modulePaths = { 'backend' },
        vmArgs = '',
        cwd = '${workspaceFolder}/backend',
        arg = ' -Dconfig.file=/Users/MiguelTavares/carrot-repos/c3-portal-backend/backend/conf/application.dev.conf',
      },
    }
  end,
}
