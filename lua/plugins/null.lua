return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    opts = function()
      local nls = require("null-ls")

      return {
        sources = {
          -- nls.builtins.formatting.prettierd,
          nls.builtins.formatting.autopep8,
          nls.builtins.formatting.djlint,
          nls.builtins.formatting.stylua,
          nls.builtins.diagnostics.flake8,
          nls.builtins.diagnostics.eslint_d.with({
            diagnostics_format = "[eslint] #{m}\n(#{c})",
          }),
          nls.builtins.code_actions.eslint_d,
          nls.builtins.diagnostics.fish,
        },
      }
    end,
  },
}
