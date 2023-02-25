return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-telescope/telescope-dap.nvim",
      "mfussenegger/nvim-lua-debugger",
    },
    config = function()
      local dap = require("dap")

      dap.adapters.python = {
        type = "executable",
        command = "/usr/bin/python3",
        args = {
          "-m",
          "debugpy.adapter",
        },
      }

      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}", -- This configuration will launch the current file if used.
        },
      }

      dap.adapters.node2 = {
        type = "executable",
        command = "node",
        args = { vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js" },
      }

      dap.adapters.chrome = {
        type = "executable",
        command = "node",
        args = { vim.fn.stdpath("data") .. "/mason/packages/chrome-debug-adapter/out/src/chromeDebug.js" },
      }

      dap.configurations.javascript = {
        {
          type = "node2",
          request = "launch",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "inspector",
          console = "integratedTerminal",
        },
      }

      dap.configurations.javascript = {
        {
          type = "chrome",
          request = "attach",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "inspector",
          port = 9222,
          webRoot = "${workspaceFolder}",
        },
      }

      dap.configurations.javascriptreact = {
        {
          type = "chrome",
          request = "attach",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "inspector",
          port = 9222,
          webRoot = "${workspaceFolder}",
        },
      }

      dap.configurations.typescriptreact = {
        {
          type = "chrome",
          request = "attach",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "inspector",
          port = 9222,
          webRoot = "${workspaceFolder}",
        },
      }
      dap.adapters.neovim = function(callback)
        local server = require("lua_debugger").launch()
        callback({ type = "server", host = server.host, port = server.port })
      end

      dap.configurations.lua = {
        {
          type = "neovim",
          request = "attach",
          name = "Attach to running neovim instance",
        },
      }
    end,
  },
}
