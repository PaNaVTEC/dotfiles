require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Git
map("n", "[h", "<cmd>Gitsigns prev_hunk<cr>   ", { desc = "Go to the previous hunk" })
map("n", "]h", "<cmd>Gitsigns next_hunk<cr>   ", { desc = "Go to the next hunk" })
map("n", "<leader>z", "<cmd>Gitsigns reset_hunk<cr>  ", { desc = "Reset hunk" })

-- LSP
map("n", "gI", "<cmd>:Telescope lsp_implementations<cr>",         { desc = "Go to implementations" })
map("n", "gR", "<cmd>:Telescope lsp_references<cr>",              { desc = "Go to references" })
map("i", "<C-h>", function() vim.lsp.buf.signature_help() end,    { desc = "LSP signature help" })
map("n", "]w", function() vim.diagnostic.goto_next() end, { desc = "Next error" })
map("n", "[w", function() vim.diagnostic.goto_prev() end, { desc = "Previous error" })
map("n", "<leader>la", function() vim.lsp.buf.code_action() end,  { desc = "LSP action" })
map("n", "<leader>lr", function() vim.lsp.buf.rename() end,       { desc = "LSP rename" })
map("n", "<leader>lf", function() require("conform").format { lsp_fallback = true } end, { desc = "format files" })

map("n", "<leader>lw", "<cmd>%s/\\s\\+$//e<cr>:noh<cr>", { desc = "Delete trailing whitespace" })

-- Avoid common typos
vim.api.nvim_create_user_command("Q", ":q", {desc = 'Close'})
vim.api.nvim_create_user_command("Qa", ":qa", {desc = 'Close all'})
vim.api.nvim_create_user_command("WQ", ":wq", {desc = 'write close'})
vim.api.nvim_create_user_command("Wqa", ":wqa", {desc = 'write close all'})
vim.api.nvim_create_user_command("Wa", ":wa", {desc = 'write all'})
vim.api.nvim_create_user_command("Wq", ":wq", {desc = 'write close'})
vim.api.nvim_create_user_command("W", ":w", {desc = 'write'})
