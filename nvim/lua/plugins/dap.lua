-- DAP (Debug Adapter Protocol) configuration for Python/debugpy
return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")

      -- Python debugpy adapter configuration
      dap.adapters.python = function(callback, config)
        callback({
          type = 'server',
          host = config.host or '127.0.0.1',
          port = config.port or 5678,
        })
      end

      -- Python debug configurations
      dap.configurations.python = {
        {
          type = 'python',
          request = 'attach',
          name = 'Attach to FastAPI debugpy (port 5678)',
          host = '127.0.0.1',
          port = 5678,
          justMyCode = false,  -- Debug into library code if needed
          pythonPath = function()
            -- First check for .venv in current working directory (for uv)
            local cwd = vim.fn.getcwd()
            local venv_python = cwd .. '/.venv/bin/python'
            if vim.fn.executable(venv_python) == 1 then
              return venv_python
            end
            -- Fallback to system python3
            return vim.fn.exepath('python3') or 'python3'
          end,
          pathMappings = {
            {
              localRoot = vim.fn.getcwd(),
              remoteRoot = '.',
            },
          },
        }
      }
    end,
  },
}
