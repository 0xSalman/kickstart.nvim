-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    'theHamsta/nvim-dap-virtual-text',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
  },
  keys = {
    -- Basic debugging keymaps, feel free to change to your liking!
    {
      '<F5>',
      function()
        require('dap').continue()
      end,
      desc = 'Debug: Start/Continue',
    },
    {
      '<F1>',
      function()
        require('dap').step_into()
      end,
      desc = 'Debug: Step Into',
    },
    {
      '<F2>',
      function()
        require('dap').step_over()
      end,
      desc = 'Debug: Step Over',
    },
    {
      '<F3>',
      function()
        require('dap').step_out()
      end,
      desc = 'Debug: Step Out',
    },
    {
      '<leader>b',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Debug: Toggle Breakpoint',
    },
    {
      '<leader>B',
      function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = 'Debug: Set Breakpoint',
    },
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    {
      '<F7>',
      function()
        require('dapui').toggle()
      end,
      desc = 'Debug: See last session result.',
    },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {
        function(config)
          require('mason-nvim-dap').default_setup(config)
        end,
        js = function(config)
          config.adapters = {
            debugger_path = vim.fn.stdpath 'data' .. '/mason/bin/js-debug-adapter',
          }
          require('mason-nvim-dap').default_setup(config)
        end,
      },

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
        'codelldb',
        'cppdbg',
        'js',
      },
    }

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
      -- layouts = {
      --   {
      --     elements = {
      --       {
      --         id = "scopes",
      --         size = 0.25
      --       },
      --       {
      --         id = "watches",
      --         size = 0.25
      --       },
      --       {
      --         id = "stacks",
      --         size = 0.25
      --       },
      --       {
      --         id = "breakpoints",
      --         size = 0.25
      --       },
      --     },
      --     position = "left",
      --     size = 40
      --   },
      --   {
      --     elements = {
      --       {
      --         id = "repl",
      --         size = 1.0
      --       }
      --     },
      --     position = "bottom",
      --     size = 10
      --   }
      -- },
      -- render = {
      --   max_type_length = nil,
      -- },
    }
    -- Change breakpoint icons
    -- vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
    -- vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
    -- local breakpoint_icons = vim.g.have_nerd_font
    --     and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
    --   or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
    -- for type, icon in pairs(breakpoint_icons) do
    --   local tp = 'Dap' .. type
    --   local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
    --   vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    -- end

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    local function get_arguments()
      return coroutine.create(function(dap_run_co)
        local args = {}
        vim.ui.input({ prompt = 'Args: ' }, function(input)
          if input:sub(1, 5) == 'file:' then
            local fn = vim.fn.getenv 'HOME' .. '/' .. input:sub(6)
            local file_content = vim.fn.readfile(fn)
            args = vim.split(file_content[1] or '', ' ')
          else
            args = vim.split(input or '', ' ')
          end
        end)
        coroutine.resume(dap_run_co, args)
      end)
    end

    -- Enable telescope dap, if installed
    pcall(require('telescope').load_extension, 'dap')
    -- Enable dap virtual text
    require('nvim-dap-virtual-text').setup()
    -- Install golang specific config
    require('dap-go').setup {
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has 'win32' == 0,
      },
    }

    dap.configurations.go = {
      {
        type = 'go',
        name = 'Debug Package',
        request = 'launch',
        program = '${fileDirname}',
        exitAfterTaskReturns = false,
      },
      {
        type = 'go',
        name = 'Debug Package (Arguments)',
        request = 'launch',
        program = '${fileDirname}',
        args = get_arguments,
        exitAfterTaskReturns = false,
      },
    }

    dap.adapters.codelldb = {
      type = 'server',
      port = '1300',
      host = '127.0.0.1',
      executable = {
        command = vim.fn.stdpath 'data' .. '/mason/packages/codelldb/extension/adapter/codelldb',
        args = { '--liblldb', vim.fn.stdpath 'data' .. '/mason/packages/codelldb/extension/lldb/lib/liblldb.dylib', '--port', '1300' },
      },
    }

    dap.configurations.rust = {
      {
        name = 'Debug Rust',
        type = 'codelldb',
        request = 'launch',
        program = function()
          local job_id = vim.fn.jobstart 'cargo build'
          vim.fn.jobwait { job_id }
          -- vim.cmd('!cargo build', { silent = true })

          local project_dir = vim.fn.getcwd()
          local metadata = vim.fn.systemlist 'cargo metadata --format-version 1 --no-deps'
          local package_name = metadata[1]:match '"name":"(.-)"'
          local executable = project_dir .. '/target/debug/' .. package_name

          return executable
          -- return vim.fn.input('Path to executable: ', executable)
        end,
        cwd = '${workspaceFolder}',
        sourceLanguages = { 'rust' },
        stopOnEntry = false,
        exitAfterTaskReturns = false,
        showDisassembly = 'never',
        runInTerminal = false,
      },
      {
        name = 'Debug Rust (Arguments)',
        type = 'codelldb',
        request = 'launch',
        program = function()
          local job_id = vim.fn.jobstart 'cargo build'
          vim.fn.jobwait { job_id }

          local project_dir = vim.fn.getcwd()
          local metadata = vim.fn.systemlist 'cargo metadata --format-version 1 --no-deps'
          local package_name = metadata[1]:match '"name":"(.-)"'
          local executable = project_dir .. '/target/debug/' .. package_name

          return executable
        end,
        args = get_arguments,
        cwd = '${workspaceFolder}',
        sourceLanguages = { 'rust' },
        stopOnEntry = false,
        exitAfterTaskReturns = false,
        showDisassembly = 'never',
        runInTerminal = false,
      },
    }

    dap.configurations.zig = {
      name = 'Debug Zig',
      type = 'codelldb',
      request = 'launch',
      program = function()
        return vim.fn.input('', vim.fn.getcwd(), 'file')
      end,
      projectDir = '${workspaceFolder}',
      sourceLanguages = { 'zig' },
      stopOnEntry = false,
      exitAfterTaskReturns = false,
      debugAutoInterpetAllModules = false,
      terminal = 'integrated',
    }

    -- TODO refer to https://www.reddit.com/r/neovim/comments/y7dvva/comment/iswqdz7/
    for _, language in ipairs { 'typescript', 'javascript' } do
      dap.configurations[language] = {
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch file',
          program = '${file}',
          cwd = '${workspaceFolder}',
          sourceMaps = true,
          skipFiles = { '<node_internals>/**', 'node_modules/**' },
        },
        {
          type = 'pwa-node',
          request = 'attach',
          name = 'Attach',
          processId = require('dap.utils').pick_process,
          cwd = '${workspaceFolder}',
        },
      }
    end

    -- load project specific configurations
    local project_config = require 'custom.debug'

    -- merge project specific configurations
    for key, value in pairs(project_config) do
      vim.list_extend(dap.configurations[key], value)
    end
  end,
}
