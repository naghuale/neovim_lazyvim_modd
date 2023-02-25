return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    opts = function()
      local nls = require("null-ls")

      return {
        sources = {
          -- formatting
          nls.builtins.formatting.prettierd, -- javascript, python, vue, css and etc...
          nls.builtins.formatting.autopep8, -- python
          nls.builtins.formatting.djlint, -- django
          nls.builtins.formatting.stylua, -- lua
          -- diagnostics
          nls.builtins.diagnostics.flake8, -- python
          nls.builtins.diagnostics.eslint_d.with({
            diagnostics_format = "[eslint] #{m}\n(#{c})",
          }),
          nls.builtins.diagnostics.fish,
          -- code_actions
          nls.builtins.code_actions.eslint_d, -- javascript, javascriptreact, typescript, typescriptreact, vue
        },
      }
    end,
  },
}
