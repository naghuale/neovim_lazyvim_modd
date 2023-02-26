-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- BufferLine switch-tab
vim.keymap.set("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next Tab" })
vim.keymap.set("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Previous Tab" })

-- Close insert mode to normal
vim.keymap.set("i", "jk", "<Esc>", { desc = "Close to Normal mode" })

-- Select all
vim.keymap.set("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })

-- Move window
vim.keymap.set("n", "<Space>m", "<C-w>w", { desc = "Move next window" })

-- Debug
vim.keymap.set("n", "<F5>", "<CMD>lua require('dap').continue()<CR>", { desc = "dap:continue" })
vim.keymap.set("n", "<Leader>db", "<CMD>lua require('dap').toggle_breakpoint()<CR>", { desc = "dap:toggle_breakpoint" })
vim.keymap.set("n", "<Leader>dh", "<CMD>lua require('dapui').eval()<CR>", { desc = "dapui:eval" })
vim.keymap.set("n", "<F6>", "<CMD>lua require('dap').step_into()<CR>", { desc = "dap:step_into" })
vim.keymap.set("n", "<F7>", "<CMD>lua require('dap').step_out()<CR>", { desc = "dap:step_out" })
vim.keymap.set("n", "<Leader>dO", "<CMD>lua require('dap').step_over()<CR>", { desc = "dap:step_over" })
vim.keymap.set("n", "<Leader>dt", "<CMD>lua require('dap').terminate()<CR>", { desc = "dap:terminate" })

