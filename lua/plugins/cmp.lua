local icons = require("utils.icons")
return {
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind-nvim",
      { "tzachar/cmp-tabnine", build = "./install.sh" },
    },
    opts = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      local tabnine = require("cmp_tabnine.config")
      local types = require("cmp.types")

      tabnine:setup({
        max_lines = 1000,
        max_num_results = 3,
        sort = true,
        show_prediction_strength = true,
        run_on_every_keystroke = true,
        snipper_placeholder = "..",
        ignored_file_types = {},
      })

      local source_mapping = {
        npm = icons.terminal .. "NPM",
        cmp_tabnine = icons.light,
        Copilot = icons.copilot,
        nvim_lsp = icons.paragraph .. "LSP",
        buffer = icons.buffer .. "BUF",
        nvim_lua = icons.bomb,
        luasnip = icons.snippet .. "SNP",
        calc = icons.calculator,
        path = icons.folderOpen2,
        treesitter = icons.tree,
        fish = icons.terminal .. "FISH",
      }

      local function deprioritize_snippet(entry1, entry2)
        if entry1:get_kind() == types.lsp.CompletionItemKind.Snippet then
          return false
        end
        if entry2:get_kind() == types.lsp.CompletionItemKind.Snippet then
          return true
        end
      end

      local buffer_option = {
        -- Complete from all visible buffers (splits)
        get_bufnrs = function()
          local bufs = {}
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            bufs[vim.api.nvim_win_get_buf(win)] = true
          end
          return vim.tbl_keys(bufs)
        end,
      }
      return {
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            max_width = 50,
            symbol_map = source_mapping,
            before = function(entry, vim_item)
              vim_item.kind = lspkind.symbolic(vim_item.kind, { with_text = true })
              local menu = source_mapping[entry.source.name]
              local maxwidth = 50

              if entry.source.name == "cmp_tabnine" then
                if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
                  menu = menu .. entry.completion_item.data.detail
                else
                  menu = menu .. "TB"
                end
              end

              vim_item.menu = menu
              vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
              return vim_item
            end,
          }),
        },
        -- You should specify your *installed* sources.
        sources = {
          { name = "nvim_lsp", priority = 9 },
          { name = "npm", priority = 9 },
          { name = "copilot", priority = 8 },
          { name = "cmp_tabnine", priority = 8, max_num_results = 3 },
          { name = "luasnip", priority = 7, max_item_count = 8 },
          { name = "buffer", priority = 7, keyword_length = 5, option = buffer_option, max_item_count = 8 },
          { name = "nvim_lua", priority = 5 },
          { name = "path", priority = 4 },
          { name = "calc", priority = 3 },
        },

        sorting = {
          comparators = {
            deprioritize_snippet,
            cmp.config.compare.exact,
            cmp.config.compare.locality,
            cmp.config.compare.recently_used,
            cmp.config.compare.score,
            cmp.config.compare.offset,
            cmp.config.compare.sort_text,
            cmp.config.compare.order,
          },
        },
        window = {
          completion = cmp.config.window.bordered({
            winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
          }),
          documentation = cmp.config.window.bordered({
            winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
          }),
        },
        experimental = {
          ghost_text = {
            hl_group = "LspCodeLens",
          },
        },
      }
    end,
  },
}
