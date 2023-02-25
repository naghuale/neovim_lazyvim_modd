return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    opts = function()
      local nls = require("utils.formating")
      nls.list_completions()
      nls.list_code_actions()
      nls.list_formatters()
      nls.list_linters()
      nls.list_hovers()
    end,
  },
}
